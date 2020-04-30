package pantompkins;

import org.apache.commons.math3.util.MathArrays;
import org.apache.commons.math3.stat.StatUtils;

import static org.apache.commons.math3.util.MathArrays.convolve;

public class Filter extends QRSDetector{

    private static final String TAG = "Pan-Tompkins Filter";


    private static final double[] lpH = {1, 2, 3 ,4 ,5 ,6 ,5, 4, 3, 2, 1 ,0 ,0};
    private static final double[] hpH = {-1, -1, -1, -1 , -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
            -1 ,-1, 31, -1, -1, -1, -1 , -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0};
    private static final double[] dH = {-0.125, -0.25, 0, 0.25, 0.125};
    private int delay = 0;


    public Filter(double[] ecg) {
    }


    public static double[] filterECG(double[] ecg){
        double[] ecgL = lowPassFilter(ecg);
        double[] ecgH = highPassFilter(ecgL);
        double[] ecgD = derivativeFilter(ecgH);
        double[] ecgS = squareFilter(ecgD);
        return movingAverage(ecgS);
    }

    public static double[] lowPassFilter(double[] ecg){
        double[] lpECG = MathArrays.convolve(ecg, lpH);
        double[] absVals = new double[lpECG.length];
        for (int i=0; i<lpECG.length; i++){
            if(lpECG[i]<0){
                absVals[i] = -lpECG[i];
            } else {
                absVals[i] = lpECG[i];
            }
        }
        double maxECG = StatUtils.max(absVals);
        return MathArrays.scale(1/maxECG, lpECG);
    }

    public static double[] highPassFilter(double[] ecg){
        double[] hpECG = MathArrays.convolve(ecg, hpH);
        double[] absVals = new double[hpECG.length];
        for (int i=0; i<hpECG.length; i++){
            if(hpECG[i]<0){
                absVals[i] = -hpECG[i];
            } else {
                absVals[i] = hpECG[i];
            }
        }
        double maxECG = StatUtils.max(absVals);
        return MathArrays.scale(1/Math.abs(maxECG), hpECG);
    }

    public static double[] derivativeFilter(double[] ecg){
        double[] result = MathArrays.convolve(ecg, dH);
        double maxValue = StatUtils.max(result);
        return MathArrays.scale(1/maxValue, result);
    }

    public static double[] squareFilter(double[] ecg){
        return MathArrays.ebeMultiply(ecg, ecg);
    }

    public static double[] movingAverage(double[] ecg){
        int fs = 200;
        double[] maH = new double[(int) Math.round(0.150* fs)];
        for (int i = 0; i<(int)Math.round(0.150* fs); i++) {
            maH[i] = 1/(0.150d*fs);
        }
        double[] result = MathArrays.convolve(ecg, maH);
        return result;

    }


}

