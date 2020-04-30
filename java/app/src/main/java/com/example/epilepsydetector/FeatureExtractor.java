package com.example.epilepsydetector;

import android.view.animation.LinearInterpolator;

import java.util.List;
import java.util.stream.IntStream;

import org.apache.commons.math3.stat.StatUtils;

import pantompkins.QRSDetector;

public class FeatureExtractor {
    private List<Feature> features;
    private double[] ecg;
    private double [] featureValues;


    public FeatureExtractor(double[] ecg){
        this.ecg = ecg;
    }

    public FeatureExtractor(){
    }

    public double[] extract(){

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

    private double[] extractHR(double[] hrvSignal){

        double[] hrSig = new double[0];

        return hrSig;
    }

    private double[] extractHRV(int[] rrSignal){

        double[] rrInterval = new double[rrSignal.length-1];
        for (int i=0; i<rrSignal.length-2; i++){
            rrInterval[i] = rrSignal[i+1]-rrSignal[i];
        }
        int [] newX = IntStream.range(rrSignal[0], rrSignal[rrSignal.length-1]/25).map(i -> i*3).toArray();
        LinearInterpolator linIntp = new LinearInterpolator();
        double[] hrvSig = new double[0];
        return hrvSig;
    }
    // Add extraction functions here

    public void getAllFeature(){
        double value = 42;
        String name = "LinearPhaseFeature";
        Feature linPhase = new Feature(name, (float) value);
        this.addFeature(linPhase);

        this.feature - > List<feature>;

        FeatureExtractor featExt = new FeatureExtractor(ecg);
        featExt.getFeatureValues() -> double[];

    }

}
