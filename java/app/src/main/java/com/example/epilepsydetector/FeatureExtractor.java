package com.example.epilepsydetector;


import java.util.List;

import org.apache.commons.math3.analysis.polynomials.PolynomialSplineFunction;
import org.apache.commons.math3.stat.StatUtils;

import java.util.stream.IntStream;
import org.apache.commons.math3.analysis.interpolation.LinearInterpolator;

public class FeatureExtractor {
    private List<Feature> features;
    private double[] ecg;
    private double [] featureValues;
    private double[] meanvec;
    private double[] stdvec;


    public FeatureExtractor(double[] ecg){
        this.ecg = ecg;
    }

    public FeatureExtractor(){

    }
    public double[] extract() {
        double[] feature = new double[5];

        if (Linearphasedetect(ecg, 1) == 0) {
            return feature;
        } else {
            feature[2] = Linearphasedetect(ecg, 1);
            feature[3] = Linearphasedetect(ecg, 2);
            feature[4] = Linearphasedetect(ecg, 3);
            feature[0] = getMobility();    // name of the function that calculates the mobility
            feature[1] = getPNN50();    // name of the function that calculates the pNN50
            return feature;
        }
    }
	// maybe this function should be outside the extract function (I don't know, but if not when maybe the text over this should be move to another function)
        public double[] normalize(double[] features){
            double[] normfeatures = new double[features.length];
            for(int i=0;i<features.length;i++){
                normfeatures[i] = (features[i] - meanvec[i]) / stdvec[i];
            }
           return normfeatures;
        }

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

    public double[] extractHRV(int[] rSignal){

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

    // Add extraction functions here
    public double getMean(double[] signal) {
        return StatUtils.mean(signal);
    }

    public static double getSTD(double[] signal) {
        return Math.sqrt(StatUtils.variance(signal));
    }

    public static double getRMS(double[] signal) {
        return Math.sqrt(StatUtils.sumSq(signal)/signal.length);
    }
	
public double Linearphasedetect(double[] ecg, int flag){
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
        int lenght = max_i -min_i;
        // calculating the slope
        double slope;
        if(max_i > min_i){
            slope = (max-min)/(max_i-min_i);
        }else{
            slope = 0;
        }
        if(slope > 1.1 && lenght > 12 && max > 80 && (max-ecg[1])> 15){
            if (endpoint > 0){
                if((ecg[1]-endpoint)> 150){

                    if (flag ==1){
                        return max;
                    }else if (flag == 2){
                        return lenght;
                    }else if (flag == 3){
                        double sum =0;
                        for(int i = 0; i<ecg.length;i++){
                            sum = sum + ecg[i];
                        }
                        return (sum/ecg.length);
                    }else{
                        return 0;
                    }
                }
            }else{
                endpoint = ecg[ecg.length-1];
                if (flag ==1){
                    return max;
                }else if (flag == 2){
                    return lenght;
                }else if (flag == 3){
                    double sum =0;
                    for(int i = 0; i<ecg.length;i++){
                        sum = sum + ecg[i];
                    }
                    return (sum/ecg.length);
                }else{
                    return 0;
                }
            }
        }else return 0;
    }
    public static double getPNN50(double[] hrvsig){
        int counter = 0;

        for(int i=0; i<hrvsig.length; i++) {
            if(Math.abs(hrvsig[i-1]-hrvsig[i]) > 0.05){
                counter = counter + 1;
            }
        }
        double pNN50 = (counter/hrvsig.length)*100;
        return pNN50;
    }

    public static double getActivity(double[] hrvsig){
        double ac = StatUtils.variance(hrvsig);
        return ac;
    }

    public static double[] diff(double[] hrvsig){
        double[] y = new double[hrvsig.length-1];
        for(int i = 0; i < hrvsig.length-1; i++) {
            y[i] = (hrvsig[i+1] - hrvsig[i]);
        }
        return y;
    }

    public static double getMobility(double[] hrvsig){
        double[] diffsig = diff(hrvsig);

        double mob = Math.sqrt(StatUtils.variance(diffsig))/StatUtils.variance(hrvsig);
        return mob;
    }

    public static double complexity(double[] hrvsig){
        double [] diffsig = diff(hrvsig);
        double[] diffdiffsig = diff(diffsig);
        double com = (Math.sqrt(StatUtils.variance(diffdiffsig))/StatUtils.variance(diffsig))/(Math.sqrt(StatUtils.variance(diffsig)/StatUtils.variance(hrvsig)));
        return com;
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

