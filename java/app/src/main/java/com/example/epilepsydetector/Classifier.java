package com.example.epilepsydetector;
import java.lang.Math;
import java.util.Arrays;

import edu.stanford.nlp.maxent.Feature;

public class Classifier {
    private double[] ecgData;
    private double [] featureValues;
    public boolean seizure;

    public Classifier(double[] ecg){
        this.ecgData = ecg;
    }

    public void predict() {
        FeatureExtractor fe = new FeatureExtractor(ecgData);
        featureValues = fe.extract();
        if (featureValues!=null) {
            weightedkNN();
        }
        else{
            seizure = false;
        }
    }

    // Classifier
    private void weightedkNN(){

        int n = 12;         // number of data points
        int k = 10;         // number of neighbors include in decision
        int[] val = new int[]{1,0,1,0,1,1,0,0,1,1,1,1};     // y-value (class value)
        // Mobi_coor is the mobility data points
        double[] Mobi_coor = new double[]{0.3160, 0.1530, 0.1304,0.1364,0.1591,0.1454,0.1458,0.1958,0.3283,0.2195,0.2066,0.2796};
        // PNN_coor is the PNN50 data points
        double[] PNN_coor = new double[]{82.3529,88.2353,88.2353,94.1176,76.4706,76.4706,94.1176,94.1176,70.5882,94.1176,70.5882,52.9412};
        // Max is the max value in the linear phase (data point)
        double[] Max = new double[]{96.4199,107.6219,86.5635,87.0185,88.5660,102.4832,96.6923,89.9914,97.5307,80.0089,111.9234,87.3021};
        // leng is the length of the linear phase (data point)
        double[] leng = new double[]{16,16,16,16,13,13,16,16,14,16,15,14};
        // mea is the mean of the linear phase (data point)
        double[] mea = new double[]{1.1726,1.4699,1.1850,1.3688,1.3176,1.4110,1.2727,1.1755,1.4459,1.3521,1.1167,1.2245};
        // dis is the distance from the feature point to all the other points
        double[] dis = new double[12];

        // Fill weighted distances of all points from the featureValues
        for (int i = 0; i < n; i++){
            dis[i] = (Math.sqrt((Mobi_coor[i]- featureValues[0]) * (Mobi_coor[i] - featureValues[0]) +
                    (PNN_coor[i] - featureValues[1]) * (PNN_coor[i] - featureValues[1]) +
                    (Max[i] - featureValues[2]) * (Max[i] - featureValues[2]) +
                    (leng[i] - featureValues[3]) * (leng[i] - featureValues[3]) +
                    (mea[i] - featureValues[4]) * (mea[i] - featureValues[4])));
        }

        // Sort the Points by weighted distance from p
        Arrays.sort(dis);

        // Now consider the first k elements and only
        // two groups
        double freq1 = 0;     // weighted sum of group 0
        double freq2 = 0;     // weighted sum of group 1

        for (int i = 0; i < k; i++)
        {
            if (val[i]== 0) {
                freq1 += (1/Math.pow(dis[i],2));
            }else{
                if (val[i] == 1) {
                    freq2 += (1/Math.pow(dis[i],2));}
            }
        }
        seizure = (!(freq1 > freq2));
        // returning the label value
        //return (freq1 > freq2 ? 0 : 1);
    }

}
