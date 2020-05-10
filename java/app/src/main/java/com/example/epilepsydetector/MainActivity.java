package com.example.epilepsydetector;

import androidx.appcompat.app.AppCompatActivity;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import android.app.AlertDialog;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.telephony.SmsManager;
import android.text.InputType;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.GridLabelRenderer;
import com.jjoe64.graphview.Viewport;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;
import com.jjoe64.graphview.series.PointsGraphSeries;

import org.apache.commons.math3.exception.ZeroException;
import org.apache.commons.math3.geometry.euclidean.twod.Line;
import org.apache.commons.math3.stat.StatUtils;
import org.apache.commons.math3.util.MathArrays;
import org.xmlpull.v1.XmlPullParser;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
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
    private String emergencyNr;

    private File externalStorage;
    private File path;
    private File file;
    private FileInputStream fIn;
    private InputStreamReader isr;
    private BufferedReader bufferedReader;

    private NotificationManagerCompat notificationManager;
    private LayoutInflater inflater;

    public List<Double> ecgSignal = Collections.synchronizedList(new ArrayList<>());
    public List<Double> timeECG = Collections.synchronizedList(new ArrayList<>());
    LineGraphSeries<DataPoint> series = new LineGraphSeries<>();
    int hr = 0;
    final static int winSize = 200 * 16;
    boolean hasEmergencyContact = false;
    String initTime;

    GraphView graph;
    TextView heartRate;
    Button contact;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        notificationManager = NotificationManagerCompat.from(this);

        graph = (GraphView) findViewById(R.id.graph);
        heartRate = findViewById(R.id.heartrate);
        heartRate.setText("   ");
        initTime = new SimpleDateFormat("mm:ss").format(Calendar.getInstance().getTime());


        // data
        contact = findViewById(R.id.emergencyButton);
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
        series.setColor(R.color.colorPrimary);
        series.setThickness(5);
        inflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);

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
    protected void onStart() {
        super.onStart();
        if(emergencyNr==null) {
            contact.performClick();
        }
        ScheduledExecutorService dataAq = Executors.newSingleThreadScheduledExecutor();
        dataAq.scheduleAtFixedRate(new Runnable() {
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
                    runOnUiThread(() -> {
                        addEntry();
                        updateHR(hr);
                    });
                    try {
                        Thread.sleep(5);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }, 0, 5, TimeUnit.MILLISECONDS);

        ScheduledExecutorService hrServ = Executors.newSingleThreadScheduledExecutor();
        hrServ.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                try {
                    calculateHeartRate();
                } catch (Exception e) {
                    Log.w("HeartRateCalc", e);
                }
            }
        }, 15000, 500, TimeUnit.MILLISECONDS);


        ScheduledExecutorService ser = Executors.newSingleThreadScheduledExecutor();
        ser.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                boolean seizure = classify();
                String time = new SimpleDateFormat("DD/MM hh:mm:ss").format(Calendar.getInstance().getTime());
                if(seizure){
                    try {
                        Log.d("Classifier", "Initial Time: " + initTime);
                        sendWarning();
                        //addSeizure(time);
                        Thread.sleep(3*60*1000);


                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }},
                20, 1, TimeUnit.SECONDS);


    }

    private void addSeizure(String time) {
        ViewGroup mainLL = findViewById(R.id.seizuresLL);
        TextView seizureDate = findViewById(R.id.time);
        seizureDate.setText(time);
        mainLL.addView(seizureDate);
        mainLL.invalidate();



    }

    private void sendWarning() throws InterruptedException {
        String content;
        if(emergencyNr ==  null || emergencyNr.isEmpty()){
            content = "Please setup an Emergency Contact";
        }
        else{
            try {
                SmsManager smgr = SmsManager.getDefault();
                smgr.sendTextMessage("+45"+emergencyNr, null, "Possible Seizure Detected", null, null);
            } catch(Exception e){
                Log.d("SMS", e.toString());
            }

            content = "An SMS has been sent to "+ emergencyNr;
        }
        Notification notification = new NotificationCompat.Builder(this, app.CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_26589)
                .setContentTitle("POSSIBLE SEIZURE DETECTED!")
                .setContentText(content)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setStyle(new NotificationCompat.BigTextStyle().setBigContentTitle("POSSIBLE SEIZURE DETECTED!"))
                .setAutoCancel(false)
                .build();
        notificationManager.notify(0, notification);
        //Thread.sleep(5*60*100);
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
            FeatureExtractor fe = new FeatureExtractor(data);
            double [] hrv = fe.extractHRV();
            hr = (int) (200*60/ StatUtils.mean(hrv));
            Log.d("HR", String.valueOf(hr));
        }
    }

    private boolean classify(){
        try {
            List<Double> tmpData = ecgSignal;
            if(tmpData.size() < winSize){
                Log.d("Classifier", "Not enough data");
            }
            else{
                Log.d("Classifier", "Running Classification " + new SimpleDateFormat("mm:ss").format(Calendar.getInstance().getTime()));
                double[] data = new double[winSize];
                for (int i=0; i<=winSize-1 ; i++){
                    data[i] = tmpData.get(tmpData.size()-(winSize-i));
                }
                Classifier classifier = new Classifier(data);
                classifier.predict();
                if(classifier.seizure){
                    Log.d("Classifier", "Seizure Found" + tmpData.size());
                }

                return classifier.seizure;

            }
        }catch (Exception e) {
            Log.w("Classifier", e);
        }
        return false;
    }

    private void updateHR(int HR) {
        if (HR == 0 || HR > 180) {
            heartRate.setText("---");
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
                    data[i] = tmpData.get(i);
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


    public void changeEmergencyContact(View view) {

        AlertDialog.Builder alert = new AlertDialog.Builder(this);
        if(hasEmergencyContact){
            alert.setTitle("Change Emergency Contact");
        }
        else {
            alert.setTitle("Add Emergency Contact");
        }
        EditText phoneInput = new EditText(this);
        LinearLayout.LayoutParams lp = new LinearLayout
                .LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
        phoneInput.setLayoutParams(lp);
        phoneInput.setInputType(InputType.TYPE_CLASS_PHONE);
        alert.setView(phoneInput);
        alert.setPositiveButton("Save", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if(phoneInput.getText().toString().length()!= 8){
                    Toast.makeText(getApplicationContext(), "Must be a valid Phone Number", Toast.LENGTH_SHORT).show();
                    contact.performClick();
                }else{
                    emergencyNr = phoneInput.getText().toString();
                    Toast.makeText(getApplicationContext(), emergencyNr + " saved as emergency contact", Toast.LENGTH_SHORT).show();
                    hasEmergencyContact = true;
                }

            }
        });
        alert.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        alert.show();

    }
}



