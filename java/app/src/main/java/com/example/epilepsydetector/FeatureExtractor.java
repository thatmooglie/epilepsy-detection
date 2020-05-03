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


    public FeatureExtractor(double[] ecg){
        this.ecg = ecg;
    }

    public FeatureExtractor(){
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

    public static double std(double[] signal) {
        return Math.sqrt(StatUtils.variance(signal));
    }

    public static double rms(double[] signal) {
        return Math.sqrt(StatUtils.sumSq(signal)/signal.length);
    }

    public static double nn50(double[] hrvsig){
        int counter = 0;

        for(int i=0; i<hrvsig.length; i++) {
            if(Math.abs(hrvsig[i-1]-hrvsig[i]) > 0.05){
                counter = counter + 1;
            }
        }

        double NN50 = counter;
        //double pNN50 = (counter/hrvsig.length)*100;

        return NN50;
        //return pNN50;
    }

    public static double activity(double[] hrvsig){
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

    public static double mobility(double[] hrvsig){
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
    string name3 = 'Root mean square';
    string name4 = 'NN50';
    string name5 = 'pNN50';
    string name6 = 'Activity';
    string name7 = 'Mobility';
    string name8 = 'Complexity';

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

