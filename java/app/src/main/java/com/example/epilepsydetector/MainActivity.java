package com.example.epilepsydetector;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Color;
import android.graphics.drawable.ShapeDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.ContactsContract;
import android.renderscript.ScriptGroup;
import android.util.Log;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;
import com.jjoe64.graphview.series.PointsGraphSeries;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.channels.AsynchronousFileChannel;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import pantompkins.QRSDetector;


public class MainActivity extends AppCompatActivity {

    String binFile = "testData.bin";
    String txtFile = "testData.txt";

    private Context mContext;
    static String LOG_TAG = "jeje";

    File externalStorage;
    File path;

    LineGraphSeries<DataPoint> series;
    PointsGraphSeries<DataPoint> points;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity);
        GraphView graph = (GraphView) findViewById(R.id.graph);


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

        readFile();

    }

    public void readFile() {
        FileInputStream fIn = null;

        series = new LineGraphSeries<DataPoint>();
        points = new PointsGraphSeries<DataPoint>();
        GraphView graph = (GraphView) findViewById(R.id.graph);
        graph.getViewport().setScalable(true);

// activate horizontal scrolling
        graph.getViewport().setScrollable(true);

// activate horizontal and vertical zooming and scrolling
        graph.getViewport().setScalableY(true);

// activate vertical scrolling
        graph.getViewport().setScrollableY(true);


        File file = new File(path, txtFile);
        int size = (int) Math.pow(2, 15);
        String ret = "";
        double[] arrTime = new double[size];
        List<Double> values = new ArrayList<>();
        try {
            fIn = new FileInputStream(file);
            InputStreamReader isr = new InputStreamReader(fIn);
            BufferedReader bufferedReader = new BufferedReader(isr);

            String recString = "";
            int i = 0;
            while ((recString = bufferedReader.readLine()) != null) {
                values.add(Double.parseDouble(recString));
                arrTime[i++] = Double.parseDouble(recString);
            }
            ret = "";
            isr.close();
        } catch (IOException e) {
            e.printStackTrace();

        }
        double x1, x2, y1, y2;
        double [] ecg = new double[values.size()];
        for (int i=0; i<values.size(); i++){
            ecg[i] = values.get(i);
            x1 = i;
            y1 = values.get(i);
            series.appendData(new DataPoint(x1, y1), true, values.size());
        }
        graph.addSeries(series);

        QRSDetector qrsDetector = new QRSDetector(ecg);
        qrsDetector.detect();
        double [] peak = qrsDetector.getPeaks();
        int [] loc = qrsDetector.getIndices();
        for(int i=0; i<peak.length; i++){
            x2 = loc[i];
            y2 = ecg[i-1];
            points.appendData(new DataPoint(x2, y2), true, peak.length);
        }
        points.setSize(points.getSize()/2);
        points.setShape(PointsGraphSeries.Shape.TRIANGLE);
        points.setColor(Color.RED);
        graph.addSeries(points);



    }
}