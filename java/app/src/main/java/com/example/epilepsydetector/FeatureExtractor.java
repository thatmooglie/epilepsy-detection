package com.example.epilepsydetector;


import android.util.Log;

import java.util.List;

import org.apache.commons.math3.analysis.polynomials.PolynomialSplineFunction;
import org.apache.commons.math3.stat.StatUtils;

import java.util.stream.IntStream;
import org.apache.commons.math3.analysis.interpolation.LinearInterpolator;

import pantompkins.QRSDetector;

public class FeatureExtractor {
    private static final String LOG_TAG = "Feature Extractor";

    private List<Feature> features;
    private double[] ecg;
    private double [] featureValues;
    private double[] meanvec;
    private double[] stdvec;


    FeatureExtractor(double[] ecg){
        this.ecg = ecg;
    }

    protected FeatureExtractor(){

    }

	// maybe this function should be outside the extract function (I don't know, but if not when maybe the text over this should be move to another function)


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

    // FUNCTIONS

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
        PolynomialSplineFunction rr = linIntp.interpolate(rrDIndices, rrInterval);
        double[] hrvSig = new double[newX.length];
        for (int i = 0; i<newX.length; i++) {
            hrvSig[i] = rr.value(newX[i]);
        }
        return hrvSig;
    }

    // feature extraction functions here
    public void getMean(double[] signal) {
        features.add(new Feature("mean", StatUtils.mean(signal)));
        //return StatUtils.mean(signal);
    }

    public void getSTD(double[] signal) {
        features.add(new Feature("std", Math.sqrt(StatUtils.variance(signal))));
    }

    public void getRMS(double[] signal) {
        features.add(new Feature("RMS", Math.sqrt(StatUtils.sumSq(signal)/signal.length)));
    }
	
private void linearPhaseDetect(double[] ecg, int flag){
        int max_i = 0;
        int min_i = 0;
        double max = ecg[0];
        double min = ecg[1];

        // this findes the max and min value
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
            if (endpoint > 0){
                if((ecg[1]-endpoint)> 150){

                    if (flag ==1){
                        features.add(new Feature("Max LinPhase", max));
                    }else if (flag == 2){
                        features.add(new Feature("Length LinPhase", length));
                    }else if (flag == 3){
                        double sum =0;
                        for (double v : ecg) {
                            sum = sum + v;
                        }
                        return;
                        features.add(new Feature("Mean LinPhase", (sum/ecg.length)));
                    }else{
                        features.add(new Feature("linPhase", 0));
                    }
                }
            }else{
                double endpoint = ecg.length-1;
                if (flag ==1){
                    features.add(new Feature("Max LinPhase", max));
                }else if (flag == 2){
                    features.add(new Feature("Length LinPhase", length));
                }else if (flag == 3){
                    double sum =0;
                    for(int i = 0; i<ecg.length;i++){
                        sum = sum + ecg[i];
                    }
                    features.add(new Feature("Mean LinPhase", (sum/ecg.length)));
                }else{
                    features.add(new Feature("linPhase", 0));
                }
            }
        }else features.add(new Feature("linPhase", 0));
    }

    private void getPNN50(double[] hrvsig){
        int counter = 0;

        for(int i=0; i<hrvsig.length; i++) {
            if(Math.abs(hrvsig[i-1]-hrvsig[i]) > 0.05){
                counter = counter + 1;
            }
        }
        double pNN50 = (counter/hrvsig.length)*100;
        features.add(new Feature("pnn50", pNN50));
    }

    public void getActivity(double[] hrvSig){
        features.add(new Feature("Activity", StatUtils.variance(hrvSig)));
    }


    private void getMobility(double[] hrvSig){
        double[] diffsig = diff(hrvSig);
        features.add(new Feature("Mobility", Math.sqrt(StatUtils.variance(diffsig)/StatUtils.variance(hrvSig))));
    }

    public void complexity(double[] hrvsig){
        double [] diffsig = diff(hrvsig);
        double[] diffdiffsig = diff(diffsig);
        double com = Math.sqrt(StatUtils.variance(diffdiffsig)/StatUtils.variance(diffsig))/Math.sqrt(StatUtils.variance(diffsig)/StatUtils.variance(hrvsig));
        features.add(new Feature("Complexity", com));
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

    /*string name1 = "Mean";
    string name2 = "Standard deviation";
    string name3 = "Root mean square";
    string name4 = "NN50";
    string name5 = "pNN50";
    string name6 = "Activity";
    string name7 = "Mobility";
    string name8 = "Complexity";

    this.addfeature(new feature(name1,Mean));
    this.addfeature(new feature(name2,standardDeviation));
    this.addfeature(new feature(name3,RootMeanSquare));
    this.addfeature(new feature(name4,NN50));
    this.addfeature(new feature(name5,pNN50));
    this.addfeature(new feature(name6,ac));
    this.addfeature(new feature(name7,mob));
    this.addfeature(new feature(name8,com));
*/
    }

