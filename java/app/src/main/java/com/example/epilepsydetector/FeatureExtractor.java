package com.example.epilepsydetector;


import java.util.List;
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


    // Add extraction functions here
    
}
