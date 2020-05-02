package com.example.epilepsydetector;

import android.view.animation.LinearInterpolator;

import java.util.List;
import org.apache.commons.math3.stat.StatUtils;
import org.apache.commons.math3.util.MathArrays;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.math3.transform.FastFourierTransformer;
import java.util.stream.IntStream;

import org.apache.commons.math3.stat.StatUtils;

import pantompkins.QRSDetector;

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

    public double[] extract(){
	 double[] feature = new double[5];

        if (Linearphasedetect(ecg,1) == 0) {
            return feature;
        }else{
            feature[2] = Linearphasedetect(ecg,1);
            feature[3] = Linearphasedetect(ecg,2);
            feature[4] = Linearphasedetect(ecg,3);
            feature[0] = calculate_Mobi();	// name of the function that calculates the mobility
            feature[1] = calculate_PNN50();	// name of the function that calculates the pNN50
            return feature;
        }
	// maybe this function should be outside the extract function (I don't know, but if not when maybe the text over this should be move to another function)
        public double normalize(double[] features){
            double[] normfeatures = new double[features.length];
            for(i=0;i<features.size;i++){
                for(n=0,n<meanvec.size;n++) {
                    double normfeatures[i] =(features[i] - meanvec[n]) / stdvec[n];
                }
            }
           return normfeatures;
        }
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

	 public static double mean(double[] hrvsig) {
        //double sum = 0;
        //for (int i = 0; i < hrvsig.length; i++) {
          //  sum += hrvsig[i];
        //}
        //double Mean = sum / hrvsig.length;
         double Mean = StatUtils.mean(hrvsig);
        return Mean;
    }

    public static double std(double[] hrvsig)
    {
        int sum = 0;
        //int max = 0;
        //int min = 0;
        double sd = 0;
        for(int i=0; i<hrvsig.length; i++)
        {
            sum = sum + hrvsig[i];
        }
        double average = sum / hrvsig.length;

        //for(int i=0; i<hrvsig.length; i++)
        //{
          //  if(hrvsig[i] > max)
            //{
            //    max = hrvsig[i];
           // }
        //}
       // for(int i=0; i<hrvsig.length; i++)
        //{
          //  if(hrvsig[i] < min)
           // {
             //   min = hrvsig[i];
           // }
        //}
        for (int i=0; i<hrvsig.length;i++) {
            for(int i = 0; i < hrvsig.length; i++)
            {
                sd += Math.pow((hrvsig[i] - average),2) / hrvsig.length;
            }
            double standardDeviation = Math.sqrt(sd);

        }
        return standardDeviation;
    }

    public static double rms(double[] hrvsig) {
        int sum = 0;

        for(int i=0; i<hrvsig.length; i++) {
            sum = sum + Math.pow(hrvsig[i],2);
        }

        double RootMeanSquare = Math.sqrt(sum)/hrvsig.length;
        return RootMeanSquare;
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
    public static double nn50(double[] hrvsig){
        int counter = 0;

        for(int i=0; i<hrvsig.length; i++) {
            if(Math.abs(hrvsig[i-1]-hrvsig[i]) > 0.05){
                counter = counter + 1;
            }
        }

        double NN50 = counter;
        double pNN50 = (counter/hrvsig.length)*100;

        return NN50;
        return pNN50;
    }
}

    public static double activity(double[] hrvsig){
        ac = StatUtils.variance(hrvsig);
        return ac;
    }

    public double diff(double[] hrvsig){
        j = 0;

        for(i = 0; i < hrvsig.length; i++) {
            y[j] = (hrvsig[i] - hrvsig[i - 1]);
            j++;
        }
    }

    public static double mobility(double[] hrvsig){

        double diffsig = diff(hrvsig);

        double mob = Math.sqrt(StatUtils.variance(diffsig))/StatUtils.variance(hrvsig);
        return mob;
    }

    public static double complexity(double[] hrvsig){
        double diffsig = diff(hrvsig);
        double diffdiffsig = diff(diffsig);

        double com = (Math.sqrt(StatUtils.variance(diffdiffsig))/StatUtils.variance(diffsig))/(Math.sqrt(StatUtils.variance(diffsig)/StatUtils.variance(hrvsig)));

        return com;
    }

    string name1 = "Mean";
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

    }

}
