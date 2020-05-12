package pantompkins;

import java.util.ArrayList;
import java.util.List;
/*
    Utility class implementing in finding peaks of a signal using zero-crossing of
    differentiated signal
 */

public class Peaks extends QRSDetector{

    private int[] locations;
    private double[] amplitudes;
    private static final int fs = 200;

    Peaks(){}

    private Peaks(int[] locations, double[] amplitudes){
        super();
        this.locations = locations;
        this.amplitudes = amplitudes;
    }

    int[] getLocations(){ return locations; }

    double[] getAmplitudes(){
        return amplitudes;
    }

    public void setLocations(int [] locations){
        this.locations = locations;
    }

    public void setAmplitudes(double[] amplitudes){
        this.amplitudes = amplitudes;
    }


    Peaks findPeaks(double[] ecg){
        List<Integer> zeroCrossings = findZeroCrossings(ecg);
        int[] locs = new int[zeroCrossings.size()];
        double[] peaks = new double[zeroCrossings.size()];
        for (int i=0; i<zeroCrossings.size(); i++){
            locs[i] = zeroCrossings.get(i);
            peaks[i] = ecg[zeroCrossings.get(i)];
        }

        return new Peaks(locs, peaks);
    }


    private List<Integer> findZeroCrossings(double[] ecg){
        double[] ecgDiff = new double[ecg.length-1];
        for(int i = 0; i<ecg.length-2; i++){
            ecgDiff[i] = ecg[i+1]-ecg[i];
        }
        List<Integer> zeroCrossings = new ArrayList<>();
        for (int i=0; i<ecgDiff.length-2; i++){
            if (ecgDiff[i]>0 && ecgDiff[i+1]<0){
                zeroCrossings.add(i);
            }
        }
        return zeroCrossings;
    }
}