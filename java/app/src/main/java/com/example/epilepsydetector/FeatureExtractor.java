package com.example.epilepsydetector;


import android.util.Log;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.math3.analysis.polynomials.PolynomialSplineFunction;
import org.apache.commons.math3.exception.NonMonotonicSequenceException;
import org.apache.commons.math3.stat.StatUtils;
import org.apache.commons.math3.stat.descriptive.rank.Median;

import java.util.stream.IntStream;
import org.apache.commons.math3.analysis.interpolation.LinearInterpolator;
import org.apache.commons.math3.util.MathArrays;

import edu.stanford.nlp.math.ArrayMath;
import pantompkins.QRSDetector;

public class FeatureExtractor {
    private static final String LOG_TAG = "Feature Extractor";

    private List<Feature> features = new ArrayList<>();
    private double[] ecg;
    private double[] meanvec = {0.2013, 81.8627, 94.3435, 15.0833, 1.2927};
    private double[] stdvec = {0.071, 12.9018, 9.5021, 1.2401, 0.1186};


    FeatureExtractor(double[] ecg){
        this.ecg = ecg;
    }

    protected FeatureExtractor(){
    }

    // Getter and Setter functions

    public void setFeatures(List<Feature> features){
        this.features = features;
    }

    public List<Feature> getFeatures(){
        return this.features;
    }

    public double[] getFeatureValues(){
        double[] featureValues = new double [this.features.size()];
        for(int i=0; i<this.features.size();i++){
            featureValues[i] = features.get(i).getValue();
        }
        return featureValues;
    }

    public String[] getFeatureNames(){
        String [] featureNames = new String[this.features.size()];
        for(int i=0; i<this.features.size(); i++){
            featureNames[i] = this.features.get(i).getName();
        }
        return featureNames;
    }

    public void addFeature(Feature feature){
        this.features.add(feature);
    }

    public double[] extractHR(double[] hrvSignal){
        double[] hrSig = new double[Math.floorDiv(hrvSignal.length, 8)];
        for(int i=0; i<hrvSignal.length/8; i++){
            hrSig[i] = 60/(hrvSignal[i*8]/200);
        }
        return hrSig;
    }

    // Feature extraction functions

    public double[] extract() {
        double [] hrvSig = extractHRV();
        double [] hrSig = extractHR(hrvSig);
        getMobility(hrvSig);    // name of the function that calculates the mobility
        getPNN50(hrvSig);
        linearPhaseDetect(hrSig, 1);
        if(features.get(2).getValue()==0) {
            Log.d(LOG_TAG, "No Linear Phase found");
            return null;
        }
        else{
            linearPhaseDetect(hrSig, 2);
            linearPhaseDetect(hrSig, 3);
            return normalize(this.getFeatureValues());
        }
    }

    public double[] extractHRV(){
        QRSDetector qrsDetector = new QRSDetector(ecg);
        qrsDetector.detect();
        int[] rSignal = qrsDetector.getIndices();
        double[] rrInterval = new double[rSignal.length-1];
        int[] rrIndices = new int[rSignal.length-1];
        double[] rrDIndices = new double[rSignal.length-1];
        for (int i=0; i<rSignal.length-1; i++){
            rrInterval[i] = rSignal[i+1]-rSignal[i];
            rrIndices[i] = rSignal[i];
            rrDIndices[i] = rSignal[i];
        }
        int [] newX = IntStream.range(rrIndices[0], rrIndices[rrIndices.length-1]).filter(i -> i%25==0).toArray();
        LinearInterpolator linIntp = new LinearInterpolator();
        PolynomialSplineFunction rr = null;
        try {
            rr = linIntp.interpolate(rrDIndices, rrInterval);
        } catch(NonMonotonicSequenceException e){
            Log.w("HRV", e);
        }
        double[] hrvSig = new double[newX.length];
        for (int i = 0; i<newX.length; i++) {
            hrvSig[i] = rr.value(newX[i]);
        }
        return hrvSig;
    }


private void linearPhaseDetect(double[] ecg, int flag){
        //ecg = medFilt1(ecg, 20);
        int max_i = 0;
        int min_i = 0;
        double max = ecg[0];
        double min = ecg[1];

        // this finds the max and min value
        for(int i = 1; i < ecg.length; i++){
            if(ecg[i] > max) {
                max = ecg[i];
                max_i = i;
            } if(ecg[i] < min){
                min = ecg[i];
                min_i = i;
            }
        }
        //calculating the length
        int length = max_i -min_i;
        // calculating the slope
        double slope;
        if(max_i > min_i){
            slope = (max-min)/(max_i-min_i);
        }else{
            slope = 0;
        }
        if(slope > 1.1 && length > 12 && max > 80 && (max-ecg[1])> 15){
	        if (flag ==1){
		        features.add(new Feature("Max LinPhase", max));
	        }else if (flag == 2){
		        features.add(new Feature("Length LinPhase", length));
	        }else if (flag == 3){
		        features.add(new Feature("RelativeMaxLinPhase", max/ecg[0]));
	        }else{
		        features.add(new Feature("isLinPhase", 0));
	        }
        }else features.add(new Feature("isLinPhase", 0));
    }

    private void getPNN50(double[] hrvsig){
        double counter = 0;

        for(int i=0; i<hrvsig.length-1; i++) {
            if(Math.abs(hrvsig[i+1]-hrvsig[i]) > 0.05){
                counter = counter + 1;
            }
        }
        double pNN50 = (counter/hrvsig.length)*100;
        features.add(new Feature("pnn50", pNN50));
    }


    private void getMobility(double[] hrvSig){
        double[] diffsig = diff(hrvSig);
        features.add(new Feature("Mobility", Math.sqrt(StatUtils.variance(diffsig)/StatUtils.variance(hrvSig))));
    }


    // Helper Functions

    private double[] normalize(double[] features){
        double[] normfeatures = new double[features.length];
        for(int i=0;i<features.length;i++){
            normfeatures[i] = (features[i] - meanvec[i]) / stdvec[i];
        }
        return normfeatures;
    }

    private static double[] diff(double[] hrvsig){
        double[] y = new double[hrvsig.length-1];
        for(int i = 0; i < y.length-1; i++) {
            y[i] = hrvsig[i+1] - hrvsig[i];
        }
        return y;
    }

    private double[] medFilt1(double[] x, int k){
        int k2 = (k-1)/2;
        double[] y = new double[x.length];
        for (int i = 0; i<y.length; i++){
            if (i<k2){
                y[i] = x[i];
            } else if(i>y.length-1-k2){
                y[i] = x[i];
            } else{
                y[i] = ArrayMath.median(ArrayUtils.subarray(x, i-k2, 20));
            }
        }
        return y;
    }

    private double[] meanfilt(double[] hrsig){
        double[] filtersig = new double[hrsig.length-1];

        for(int i=0; i<filtersig.length-1;i++){
            filtersig[i] = hrsig[i] / StatUtils.mean(hrsig);
        }
        return filtersig;
    }

}

