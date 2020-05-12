package pantompkins;

import android.util.Log;

import com.example.epilepsydetector.FeatureExtractor;

import org.apache.commons.math3.exception.DimensionMismatchException;
import org.apache.commons.math3.exception.NotPositiveException;
import org.apache.commons.math3.stat.StatUtils;
import org.apache.commons.math3.util.MathArrays;
import org.apache.commons.lang3.ArrayUtils;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.math.ArrayMath;

/*
    Object class implementing the Pan-Tompkins QRS detection
 */

public class QRSDetector extends FeatureExtractor {

    private double [] ecgData;
    private final int fs = 200;
    private double [] peaks;
    private int[] indices;

    private double thresholdI1 = 0;
    private double thresholdI2 = 0;
    private double thresholdF1 = 0;
    private double thresholdF2 = 0;


    public QRSDetector(double[] ecg){
        this.ecgData = ecg;
    }

    public QRSDetector() {}

    public double[] getEcgData() {
        return ecgData;
    }

    public double[] getPeaks() {
        return peaks;
    }

    public int[] getIndices() {
        return indices;
    }

    public void setEcgData(double[] ecgData) {
        this.ecgData = ecgData;
    }

    public void setPeaks(double[] peaks) {
        this.peaks = peaks;
    }

    public void setIndices(int[] indices) {
        this.indices = indices;
    }

    public QRSDetector(double[] ecg, double[] peaks, int[] indices){
        this.ecgData = ecg;
        this.peaks = peaks;
        this.indices = indices;
    }


    public void detect(){
        // Initialize variables
        double[] ecgF = Filter.highPassFilter(Filter.lowPassFilter(ecgData));
        double[] ecgM = Filter.filterECG(ecgData);
        double SPKI = 0;
        double NPKI = 0;
        double SPKF = 0;
        double NPKF = 0;
        double yi = 0;
        int xi = 0;
        List<Double> qrsC = new ArrayList<>();
        List<Integer> qrsI = new ArrayList<>();
        double[] diffRR = new double[7];
        double mSelectedRR = 0;
        double meanRR = 0;
        double tempM = 0;
        List<Double> qrsCRaw = new ArrayList<>();
        List<Integer> qrsIRaw = new ArrayList<>();
        int xIt = 0;
        double yIt = 0;
        boolean notNoise = false;
        List<Double> noiseC = new ArrayList<>();
        List<Integer> noiseI  = new ArrayList<>();
        boolean skip = false;
        boolean searchBack=false;

        setThresholds(ecgM, ecgF);
        Peaks rLocations = new Peaks();
        rLocations = rLocations.findPeaks(ecgM);
        int[] peakLocs = rLocations.getLocations();
        double[] peakVal = rLocations.getAmplitudes();

        // Thresholding and online decision rule
        for (int i=0; i<peakLocs.length; i++){
            // Locate the corresponding peak in filtered signal
            if(peakLocs[i]-Math.round(0.150*fs) >= 0 && peakLocs[i]<ecgF.length){
                yi = StatUtils.max(ecgF, (int) (peakLocs[i]-Math.round(0.150*fs)),
                        (int) Math.round(0.150*fs));
                xi = argmax(ecgF, (int)(peakLocs[i]-Math.round(0.150*fs)), peakLocs[i]);
            } else{
                if (i==0){
                    yi = StatUtils.max(ecgF, i, peakLocs[i]);
                    xi = argmax(ecgF, i, peakLocs[i]);
                    searchBack = false;
                }
                else if (peakLocs[i]>=ecgF.length){
                    yi = StatUtils.max(ecgF, (int) (peakLocs[i]-Math.round(0.150*fs)),
                            (int) Math.round(0.150*fs));
                    xi = argmax(ecgF, (int) (peakLocs[i]-Math.round(0.150*fs)),
                            ecgF.length-1);
                }
            }
            // Update HR
            if(qrsC.size() >= 9){
                for (int j=qrsI.size()-9; j< qrsI.size()-2; j++){
                    diffRR[j-(qrsI.size()-9)] = qrsI.get(j + 1) - qrsI.get(j);
                }
                meanRR = StatUtils.mean(diffRR);
                double comp = qrsI.get(qrsI.size()-1)-qrsI.get(qrsI.size()-2);
                if (comp <= 0.92*meanRR || comp >= 1.16*meanRR){
                    thresholdI1 = 0.5*thresholdI1;
                    thresholdF1 = 0.5*thresholdF1;
                } else {
                    mSelectedRR = meanRR;
                }
            }
            // Calculate mean of last 8 RR to make sure no QRS is missing
            if (mSelectedRR != 0){
                tempM = mSelectedRR;
            } else if (meanRR!=0){
                tempM = meanRR;
            }
            else{
                tempM = 0;
            }
            // This part needs more debugging in order to be usable.
            if(false){//tempM!=0){ false
                if (peakLocs[i] - qrsI.get(qrsI.size()-1) >= Math.round(1.66*tempM)) {
                    int start = (int) (qrsI.get(qrsI.size()-1)+Math.round(0.2*fs));
                    int end = (int)(peakLocs[i]-Math.round(0.2*fs));
                    if(start>end)
                        end = ecgM.length-1;
                    else if(start>ecgM.length-1)
                        start=ecgM.length-1;
                    else if(end>ecgM.length-1)
                        end = ecgM.length-1;
                    double peakTemp = 0;
                    peakTemp = StatUtils.max(ecgM, (int) (qrsI.get(qrsI.size() - 1) +
                            Math.round(0.2 * fs)), Math.abs(end-start));


                    int locTemp = argmax(ecgM, (int) (qrsI.get(qrsI.size() - 1) +
                            Math.round(0.2 * fs)), (int) (peakLocs[i]-Math.round(0.2*fs))-1);
                    locTemp = (int) (qrsI.get(qrsI.size() - 1) + Math.round(0.2 * fs) +
                            locTemp - 2);

                    if (peakTemp > thresholdI2) {
                        qrsC.add(peakTemp);
                        qrsI.add(locTemp);
                        
                        // Find bandpass signal location
                        if (locTemp <= ecgF.length) {
                            yIt = StatUtils.max(ecgF, (int) (locTemp - Math.round(0.15 * fs)),
                                    (int) Math.round(0.150*fs));
                            xIt = argmax(ecgF, (int) (locTemp - Math.round(0.15 * fs)), locTemp);
                        } else{
                            try{
                                yIt = StatUtils.max(ecgF, (int) (locTemp - Math.round(0.15 * fs)),
                                        (int) ((ecgF.length - 1)-(locTemp-Math.round(0.15*fs))));
                                xIt = argmax(ecgF, (int) (locTemp - Math.round(0.15 * fs)),
                                        ecgF.length - 1);
                            }catch(NotPositiveException e){
                                yIt = ecgF[ecgF.length-1];
                                xIt = ecgF.length-1;
                            }
                        }
                        // Take care of the threshold
                        if (yIt > thresholdF2) {
                            qrsIRaw.add((int) (locTemp - Math.round(0.150 * fs) + xIt - 1));
                            qrsCRaw.add(yIt);
                            SPKF = 0.25 * yIt + 0.75 * SPKF;
                        }
                        notNoise = true;
                        SPKI = 0.25 * peakTemp + 0.75 * SPKI;
                    }
                }
            }

            // Find noise and QRS peaks
            if (peakVal[i] >= thresholdI1){
                // if a QRS candidate occurs within 360ms of the previous QRS the algorithm
                // determines if it's a T wave of QRS
                if (qrsC.size() >= 3){
                    if(peakLocs[i]-qrsI.get(qrsI.size()-1) <= Math.round(0.36*fs)){
                        double slope1 = StatUtils.mean(MathArrays.ebeSubtract(
                                ArrayUtils.subarray(ecgM, (int)
                                        (peakLocs[i]-Math.round(0.075*fs))+1, peakLocs[i]),
                                ArrayUtils.subarray(ecgM, (int) (peakLocs[i]-Math.round(0.075*fs)),
                                        peakLocs[i]-1)));
                        double slope2 = 0;
                        try{
                            slope2 = StatUtils.mean(MathArrays.ebeSubtract(
                                    ArrayUtils.subarray(ecgM, (int)
                                            (qrsI.get(qrsC.size()-1)-Math.round(0.075*fs))+1,
                                            qrsI.get(qrsC.size()-1)+1),
                                    ArrayUtils.subarray(ecgM, (int) (qrsI.get(qrsC.size()-1)-
                                            Math.round(0.075*fs)), qrsI.get(qrsC.size()-1))));
                        } catch (DimensionMismatchException e) {
                            Log.w("QRS", e);
                        }
                        if(Math.abs(slope1) <= Math.abs(0.5*slope2)){
                            noiseC.add(peakVal[i]);
                            noiseI.add(peakLocs[i]);
                            skip = true;
                            NPKF = 0.125*yi + 0.875*NPKF;
                            NPKI = 0.125*peakVal[i] + 0.875*NPKI;
                        } else{
                            skip = false;
                        }
                    }
                }

                if(!skip){
                    qrsC.add(peakVal[i]);
                    qrsI.add(peakLocs[i]);

                    // check bandpass filter threshold
                    if(yi>=thresholdF1){
                        if(searchBack){
                            qrsIRaw.add(xi);
                        } else {
                            qrsIRaw.add((int)(peakLocs[i]-Math.round(0.15*fs)+(xi-1)));
                        }
                        qrsCRaw.add(yi);
                        SPKF = 0.125*yi+0.875*SPKF;
                    }
                    SPKI = 0.125*peakVal[i]+0.875*SPKI;
                } else if (thresholdI2 <= peakVal[i] && peakVal[i]<thresholdI1){
                    NPKF = 0.125*yi + 0.875*NPKF;
                    NPKI = 0.125*peakVal[i] + 0.875*NPKI;
                } else if (peakVal[i] < thresholdI2){
                    noiseC.add(peakVal[i]);
                    noiseI.add(peakLocs[i]);

                    NPKF = 0.125*yi + 0.875*NPKF;
                    NPKI = 0.125*peakVal[i] + 0.875*NPKI;
                }
            }
            if(NPKI !=0 || SPKI !=0){
                thresholdI1 = NPKI + 0.25*(Math.abs(SPKI-NPKI));
                thresholdI2 = 0.5*thresholdI1;
            }
            if(NPKF != 0 || SPKF !=0){
                thresholdF1 = NPKF + 0.25*(Math.abs(SPKF-NPKF));
                thresholdF2 = 0.5*thresholdF1;
            }

            skip = false;
            notNoise = false;
            searchBack = false;
        }
        List<Double> tmpPeak = new ArrayList<>();
        List<Integer> tmpIdx = new ArrayList<>();
        tmpPeak.add(qrsCRaw.get(0));
        tmpIdx.add(qrsIRaw.get(0));
        for(int j=1; j<qrsCRaw.size(); j++){
            if (!qrsIRaw.get(j).equals(qrsIRaw.get(j-1))){
                tmpPeak.add(qrsCRaw.get(j));
                tmpIdx.add(qrsIRaw.get(j));
            }
        }
        double[] pks = new double[tmpPeak.size()];
        int[] idx = new int[tmpIdx.size()];


        for(int j=0; j<tmpPeak.size(); j++){
            pks[j] = tmpPeak.get(j);
            idx[j] = tmpIdx.get(j);
        }

        this.peaks = pks;
        this.indices = idx;
        System.gc();
    }


    private void calculateThresholds(double [] ecgM){
        int initializeTime = 2*fs;
        double[] initSig = new double[initializeTime];
        for (int i=0; i<initializeTime; i++){
            initSig[i] = ecgM[i];
        }
        double SPKI = StatUtils.max(initSig, 0, initializeTime-1)*0.25;
        double NPKI = StatUtils.mean(initSig,0, initializeTime-1)*0.5;
        thresholdI1 = NPKI + 0.25*(SPKI-NPKI);
        thresholdI2 = 0.5*thresholdI1;
    }

    private void calculateBPThresholds(double [] ecgF){
        int initializeTime = 2*fs;
        double[] initSig = new double[initializeTime];
        for (int i=0; i<initializeTime; i++){
            initSig[i] = ecgF[i];
        }
        double SPKF = StatUtils.max(initSig, 0, initializeTime-1)*0.25;
        double NPKF = StatUtils.mean(initSig,0, initializeTime-1)*0.5;
        thresholdI1 = NPKF + 0.25*(SPKF-NPKF);
        thresholdF2 = 0.5*thresholdF1;
    }

    private void setThresholds(double[]ecgM, double [] ecgF){
        calculateThresholds(ecgM);
        calculateBPThresholds(ecgF);
    }


    private int argmax(double[] sig, int start, int end){
        double[] signalRange = new double[Math.abs(end-start)];
        for(int i = Math.min(start,end); i<Math.max(start,end); i++){
            signalRange[i-Math.min(start,end)] = sig[i];
        }
        return ArrayMath.argmax(signalRange);
    }
}