package com.example.epilepsydetector;

public class Feature {
    protected String name;
    protected double value;

    public Feature(){

    }
    public Feature(String name, double value){
        this.name = name;
        this.value = value;
    }


    public double getValue(){
        return value;
    }

    public void setValue(double value){
        this.value = value;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }
}
