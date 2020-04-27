package com.example.epilepsydetector;

public class Feature {
    protected String name;
    protected float value;

    public Feature(){

    }
    public Feature(String name, float value){
        this.name = name;
        this.value = value;
    }


    public float getValue(){
        return value;
    }

    public void setValue(float value){
        this.value = value;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }
}
