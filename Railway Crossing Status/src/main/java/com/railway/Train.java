package com.railway;

public class Train {
    private String trainName;
    private String crossingStatus;
    private String personInCharge;
    private String trainSchedule;
    private String landmark;
    private String address;

   

    public Train(String trainName, String crossingStatus, String personInCharge, String trainSchedule, String landmark, String address) {
        this.trainName = trainName;
        this.crossingStatus = crossingStatus;
        this.personInCharge = personInCharge;
        this.trainSchedule = trainSchedule;
        this.landmark = landmark;
        this.address = address;
    }

    public String getTrainName() {
        return trainName;
    }

    public void setTrainName(String trainName) {
        this.trainName = trainName;
    }

    public String getCrossingStatus() {
        return crossingStatus;
    }

    public void setCrossingStatus(String crossingStatus) {
        this.crossingStatus = crossingStatus;
    }

    public String getPersonInCharge() {
        return personInCharge;
    }

    public void setPersonInCharge(String personInCharge) {
        this.personInCharge = personInCharge;
    }

    public String getTrainSchedule() {
        return trainSchedule;
    }

    public void setTrainSchedule(String trainSchedule) {
        this.trainSchedule = trainSchedule;
    }

    public String getLandmark() {
        return landmark;
    }

    public void setLandmark(String landmark) {
        this.landmark = landmark;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}

