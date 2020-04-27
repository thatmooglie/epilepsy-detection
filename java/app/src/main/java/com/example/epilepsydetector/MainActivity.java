package com.example.epilepsydetector;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.res.AssetManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.renderscript.ScriptGroup;
import android.util.Log;

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


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


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
        double [] ecg = new double[values.size()];
        for (int i=0; i<values.size(); i++){
            ecg[i] = values.get(i);
        }
        QRSDetector qrsDetector = new QRSDetector(ecg);
        qrsDetector.detect();
        Log.d(LOG_TAG, ret);

    }
}