package com.example.epilepsydetector;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.widget.TextView;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.GridLabelRenderer;
import com.jjoe64.graphview.Viewport;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;
import com.jjoe64.graphview.series.PointsGraphSeries;

import org.apache.commons.math3.exception.ZeroException;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import pantompkins.Filter;
import pantompkins.QRSDetector;


public class MainActivity extends AppCompatActivity {

    String binFile = "testData.bin";
    String txtFile = "testData.txt";

    private Context mContext;
    static String LOG_TAG = "jeje";

    private File externalStorage;
    private File path;
    private File file;
    private FileInputStream fIn;
    private InputStreamReader isr;
    private BufferedReader bufferedReader;

    private NotificationManagerCompat notificationManager;

    public List<Double> ecgSignal = Collections.synchronizedList(new ArrayList<>());
    public List<Double> timeECG = Collections.synchronizedList(new ArrayList<>());
    LineGraphSeries<DataPoint> series = new LineGraphSeries<>();
    int hr = 0;
    final static int winSize = 200 * 16;

    GraphView graph;
    TextView heartRate;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        notificationManager = NotificationManagerCompat.from(this);

        graph = (GraphView) findViewById(R.id.graph);
        heartRate = findViewById(R.id.heartrate);
        heartRate.setText("   ");

        // data
        series = new LineGraphSeries<>();
        graph.addSeries(series);
        // customize a little bit viewport
        Viewport viewport = graph.getViewport();
        viewport.setYAxisBoundsManual(true);
        viewport.setXAxisBoundsManual(true);
        graph.getGridLabelRenderer().setVerticalLabelsVisible(false);
        graph.getGridLabelRenderer().setHorizontalLabelsVisible(false);
        viewport.setMinX(0);
        viewport.setMaxX(5);
        viewport.setMinY(-1);
        viewport.setMaxY(1);
        viewport.setScrollable(true);
        graph.getGridLabelRenderer().setGridStyle(GridLabelRenderer.GridStyle.NONE);
        viewport.setBackgroundColor(Color.TRANSPARENT);
        viewport.setBorderColor(Color.TRANSPARENT);
        series.setColor(Color.parseColor("#CCB00020"));
        series.setThickness(4);

        externalStorage = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
        path = new File(externalStorage.getAbsolutePath());

        Log.d(LOG_TAG, path.getAbsolutePath());

        if (!path.exists()) {
            Log.d(LOG_TAG, "Directory Doesn't Exist");
            if (!path.mkdirs()) {
                Log.d(LOG_TAG, "Directory not Created");
            } else {
                Log.d(LOG_TAG, "Directory is created");
            }
        } else {
            Log.d(LOG_TAG, "Directory does exist");
        }

        fIn = null;
        file = new File(path, txtFile);
        try {
            fIn = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        isr = new InputStreamReader(fIn);
        bufferedReader = new BufferedReader(isr);
        //readFile();


    }

    @Override
    protected void onResume() {
        super.onResume();

        new Thread(new Runnable() {
            @Override
            public void run() {
                String recString = "";
                while (true) {
                    try {
                        if ((recString = bufferedReader.readLine()) == null) break;
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    ecgSignal.add(Double.parseDouble(recString));
                    timeECG.add((ecgSignal.size() - 1) / 200.0);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            //filterPlotData(ecgSignal);
                            addEntry();
                            updateHR(hr);

                        }
                    });
                    try {
                        Thread.sleep(5);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
        /*new Thread(new Runnable() {
            @Override
            public void run() {
                while (true) {
                    calculateHeartRate();
                    try {
                        Thread.sleep(500);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();*/

        ScheduledExecutorService hrServ = Executors.newSingleThreadScheduledExecutor();
        hrServ.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                calculateHeartRate();
            }
        }, 15000, (long) 500, TimeUnit.MILLISECONDS);

        /*new Thread(new Runnable() {
            @Override
            public void run() {

                try {
                    Thread.sleep(winSize);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                while (true) {
                    if (ecgSignal.size() > winSize) {
                        double[] data = new double[winSize];
                        for (int i = 0; i < winSize; i++) {
                            data[i] = ecgSignal.get(ecgSignal.size() - (winSize - i));
                        }
                        Classifier classifier = new Classifier(data);
                        classifier.predict();
                        if (classifier.seizure) {
                            sendWarning();
                            try {
                                Thread.sleep(1000 * 5 * 60);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        } else {
                            try {
                                Thread.sleep(3000);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        }
                    }

                }

            }
        }).start();*/
        ScheduledExecutorService ser = Executors.newSingleThreadScheduledExecutor();
        ser.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                boolean seizure = classify();
                if(seizure){
                    try {
                        sendWarning();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }},
                0, 3, TimeUnit.SECONDS);


    };

    private void sendWarning() throws InterruptedException {
        Notification notification = new NotificationCompat.Builder(this, app.CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_warning_black_24dp)
                .setContentTitle("EPILEPSY WARNING!")
                .setContentText("POSSIBLE SEIZURE DETECTED!")
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setTimeoutAfter(15000)
                .build();
        notificationManager.notify(1, notification);
        Thread.sleep(5*60*100);
    }

    private void calculateHeartRate() {
        List<Double> tmpData = ecgSignal;
        int size = tmpData.size();
        QRSDetector detector = new QRSDetector();
        if (size < 3000) {
            Log.d(LOG_TAG, "not enough data to calculate HR");
        } else {
            double[] data = new double[3000];
            for (int i = 0; i < 3000; i++) {
                data[i] = -tmpData.get(tmpData.size() - (3000 - i)-1);
            }
            detector.setEcgData(data);
            detector.detect();
            int[] rLocs = detector.getIndices();
            if (rLocs.length > 1) {
                try {
                    hr = rLocs.length * 4;
                } catch (ArithmeticException ignore) {
                }
            }
        }
    }

    private boolean classify(){
        try {
            List<Double> tmpData = ecgSignal;
            if(tmpData.size() < winSize){
                Log.d("Classifier", "Not enough data");
            }
            else{
                Log.d("Classifier", "Running Classification");
                double[] data = new double[winSize];
                for (int i=0; i<=winSize-1 ; i++){
                    data[i] = tmpData.get(tmpData.size()-(winSize-i));
                }

                Classifier classifier = new Classifier(data);
                classifier.predict();
                //if(classifier.seizure){
                 //   sendWarning();
                //}

                return classifier.seizure;

            }
        }catch (Exception e) {
            Log.w("Classifier", e);
        }
        return false;
    }

    private void updateHR(int HR) {
        if (HR == 0) {
            heartRate.setText("   ");
        } else {
            heartRate.setText(String.valueOf(HR));
        }
    }

    private double[] filterPlotData(List<Double> tmpData) {
        int size = tmpData.size();
        double[] data = null;
        if (size < 5 * 200) {
            data = new double[size];
            for (int i = 0; i < size - 1; i++) {
                try {
                    data[i] = tmpData.get(i);
                } catch (ArrayIndexOutOfBoundsException e) {
                }
            }
        } else {
            data = new double[1000];
            for (int i = 0; i < 1000; i++) {
                data[i] = tmpData.get(size - (1000 - i));
            }
        }

        //filteredECG = DoubleStream.of(filtData).boxed().collect(Collectors.toList());
        return Filter.highPassFilter(Filter.lowPassFilter(data));
    }

    private void addEntry() {
        List<Double> tmpData = ecgSignal;
        double[] filtData = filterPlotData(tmpData);
        series.appendData(new DataPoint(timeECG.get(timeECG.size() - 1), filtData[filtData.length / 2]), true, 20000);
    }

}



