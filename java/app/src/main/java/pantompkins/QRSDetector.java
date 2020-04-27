package pantompkins;

import com.example.epilepsydetector.FeatureExtractor;

import org.apache.commons.math3.stat.StatUtils;
import org.apache.commons.math3.util.MathArrays;
import org.apache.commons.lang3.ArrayUtils;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.math.ArrayMath;

public class QRSDetector extends FeatureExtractor {

    public Peaks rLocations;
    private int fs = 200;
    private int initializeTime = 2*fs;
    private double [] ecgData;
    private double [] peaks;
    private int[] indices;
    private double thresholdI1;
    private double thresholdI2;
    private double thresholdF1;
    private double thresholdF2;
    private double[] ecgF;
    private double[] ecgM;

    private List<Double> qrsC;
    private List<Integer> qrsI;
    private double[] diffRR = new double[9];
    private double mSelectedRR = 0;
    private double meanRR;
    private double tempM;
    private List<Double> qrsCRaw;
    private List<Integer> qrsIRaw;
    private int xIt;
    private double yIt;
    private boolean notNoise;
    private double SPKI;
    private double NPKI;
    private double SPKF;
    private double NPKF;
    private List<Double> noiseC;
    private List<Integer> noiseI;
    private double yi;
    private int xi;
    private boolean skip;
    private boolean searchBack=false;
    private List<Double> signalBuff;
    private List<Double> signalFBuff;
    private List<Double> noiseBuff;
    private List<Double> noiseFBuff;
    private List<Double> thresholdBuff;
    private List<Double> thresholdFBuff;

    public QRSDetector(double[] ecg){
        this.ecgData = ecg;
    }

    public QRSDetector() {
    }

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
        double [] ecg = this.ecgData;
        setFilteredSignals(ecg);
        setThresholds();
        rLocations = new Peaks();
        rLocations = rLocations.findPeaks(ecgM);
        int[] peakLocs = rLocations.getLocations();
        double[] peakVal = rLocations.getAmplitudes();

        qrsC = new ArrayList<>();
        qrsI = new ArrayList<>();
        qrsCRaw = new ArrayList<>();
        qrsIRaw = new ArrayList<>();

        // Thresholding and online decision rule
        for (int i=0; i<peakLocs.length; i++){
            // Locate the corresponding peak in filtered signal
            if(peakLocs[i]-Math.round(0.150*fs) >= 0 && peakLocs[i]<ecgF.length){
                yi = StatUtils.max(ecgF, (int) (peakLocs[i]-Math.round(0.150*fs)), (int) Math.round(0.150*fs));
                xi = argmax(ecgF, (int)(peakLocs[i]-Math.round(0.150*fs)), peakLocs[i]);
            } else{
                if (i==0){
                    yi = StatUtils.max(ecgF, i, peakLocs[i]);
                    xi = argmax(ecgF, i, peakLocs[i]);
                }
                else if (peakLocs[i]>=ecgF.length){
                    yi = StatUtils.max(ecgF, (int) (peakLocs[i]-Math.round(0.150*fs)), (int) Math.round(0.150*fs));
                    xi = argmax(ecgF, (int) (peakLocs[i]-Math.round(0.150*fs)), ecgF.length-1);
                }
            }
            // Update HR
            if(qrsC.size() >= 9){
                for (i=qrsI.size()-9; i< qrsI.size()-1; i++){
                    diffRR[i-qrsI.size()+1] = qrsI.get(i + 1) - qrsI.get(i);
                }
                double meanRR = StatUtils.mean(diffRR);
                double comp = qrsI.get(qrsI.size()-1)-qrsI.get(qrsI.size()-2);
                if (comp <= 0.92*meanRR || comp >= 1.16*meanRR){
                    thresholdI1 = 0.5*thresholdI1;
                    thresholdF1 = 0.5*thresholdF1;
                } else {
                    double mSelectedRR = meanRR;
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

            if(tempM!=0){
                if (peakLocs[i] - qrsI.get(qrsI.size()-1) >= Math.round(1.66*tempM)){
                    double peakTemp = StatUtils.max(ecgM, (int) (qrsI.get(qrsI.size()-1)+Math.round(0.2*fs)), (int)(peakLocs[i]-Math.round(0.2*fs)));
                    int locTemp = argmax(ecgM, (int) (qrsI.get(qrsI.size()-1)+Math.round(0.2*fs)), (int)(peakLocs[i]-Math.round(0.2*fs)));
                    locTemp = (int) (qrsI.get(qrsI.size()-1)+Math.round(0.2*fs) + locTemp -1);

                    if (peakTemp > thresholdI2){
                        qrsC.add(peakTemp);
                        qrsI.add(locTemp);

                        // Find bandpass signal location
                        if(locTemp <= ecgF.length){
                            yIt = StatUtils.max(ecgF, (int) (locTemp-Math.round(0.15*fs)), locTemp);
                            xIt = argmax(ecgF, (int) (locTemp-Math.round(0.15*fs)), locTemp);
                        } else{
                            yIt = StatUtils.max(ecgF, (int) (locTemp-Math.round(0.15*fs)), ecgF.length-1);
                            xIt = argmax(ecgF, (int) (locTemp-Math.round(0.15*fs)), ecgF.length-1);
                        }
                        // Take care of the threshold
                        if (yIt > thresholdF2){
                            qrsIRaw.add((int) (locTemp-Math.round(0.150*fs)+xIt-1));
                            qrsCRaw.add(yIt);
                            SPKF = 0.25*yIt + 0.75*SPKF;
                        }
                        
                        notNoise = true;
                        SPKI = 0.25*peakTemp + 0.75*SPKI;
                    }else{
                        notNoise = false;
                    }

                    // Find noise and QRS peaks
                    if (peakVal[i] >= thresholdI1){
                        // if a QRS candidate occurs within 360ms of the previous QRS the algorithm
                        // determines if it's a T wave of QRS
                        if (qrsC.size() >= 3){
                            if(peakLocs[i]-qrsI.get(qrsI.size()-1) <= Math.round(0.36*fs)){
                                double slope1 = StatUtils.mean(MathArrays.ebeSubtract(
                                        ArrayUtils.subarray(ecgM, (int) (peakLocs[i]-Math.round(0.075*fs))+1, peakLocs[i]),
                                        ArrayUtils.subarray(ecgM, (int) (peakLocs[i]-Math.round(0.075*fs)), peakLocs[i]+1)));
                                double slope2 = StatUtils.mean(MathArrays.ebeSubtract(
                                        ArrayUtils.subarray(ecgM, (int) (qrsI.get(qrsC.size()-1)-Math.round(0.075*fs))+1, qrsI.get(qrsC.size())),
                                        ArrayUtils.subarray(ecgM, (int) (qrsI.get(qrsC.size()-1)-Math.round(0.075*fs)), qrsI.get(qrsC.size())-1)));
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

                        if(skip){
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
                    signalBuff.add(SPKI);
                    noiseBuff.add(NPKI);
                    thresholdBuff.add(thresholdI1);

                    signalFBuff.add(SPKF);
                    noiseFBuff.add(NPKF);
                    thresholdFBuff.add(thresholdF1);

                    skip = false;
                    notNoise = false;
                    searchBack = false;
                }
            }
        }
        double[] pks = new double[qrsCRaw.size()];
        int[] idx = new int[qrsIRaw.size()];
        for(int i=0; i<qrsCRaw.size(); i++){
            pks[i] = qrsCRaw.get(i);
            idx[i] = qrsIRaw.get(i);
        }
        this.peaks = pks;
        this.indices = idx;
    }

    private void calculateThresholds(){

        double[] initSig = new double[initializeTime];
        for (int i=0; i<initializeTime; i++){
            initSig[i] = ecgM[i];
        }
        SPKI = StatUtils.max(initSig, 0, initializeTime-1)*0.25;
        NPKI = StatUtils.mean(initSig,0, initializeTime-1)*0.5;
        thresholdI1 = NPKI + 0.25*(SPKI-NPKI);
        thresholdI2 = 0.5*thresholdI1;
    }

    private void calculateBPThresholds(){

        double[] initSig = new double[initializeTime];
        for (int i=0; i<initializeTime; i++){
            initSig[i] = ecgF[i];
        }
        SPKF = StatUtils.max(initSig, 0, initializeTime-1)*0.25;
        NPKF = StatUtils.mean(initSig,0, initializeTime-1)*0.5;
        thresholdI1 = NPKF + 0.25*(SPKF-NPKF);
        thresholdF2 = 0.5*thresholdF1;
    }

    private void setThresholds(){
        calculateThresholds();
        calculateBPThresholds();
    }

    private void setFilteredSignals(double [] ecg){
        ecgF = Filter.highPassFilter(Filter.lowPassFilter(ecg));
        ecgM = Filter.filterECG(ecg);
    }

    private int argmax(double[] sig, int start, int end){
        double[] signalRange = new double[end-start];
        for(int i = start; i<end; i++){
            signalRange[i-start] = sig[i];
        }
        return ArrayMath.argmax(signalRange);
    }
}
