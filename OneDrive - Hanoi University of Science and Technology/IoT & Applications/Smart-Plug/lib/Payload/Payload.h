#ifndef Payload_h
#define Payload_h
#include <Arduino.h>
#include <ArduinoJson.h>
class Payload
{
public:
    // Constructor
    Payload(int data);

    // Member function
    void displayData();

private:
    int data_;
};

class RemotePayload
{
private:
    String device_;
    int data_;
public:
    RemotePayload();
    RemotePayload(String dev, int dat);
    // Getter and Setter for Device Name
    String getDeviceName() const;
    void setDeviceName(const String &device);
    // Getter and Setter for Data
    int getData() const;
    void setData(int data);
    String toJson() const;
    static RemotePayload fromJson(const String &jsonString);
};

class TimeSetPayload
{
private:
    String device_;
    float time_;
    int type_;
    int data_;

public:
    TimeSetPayload();
    TimeSetPayload(String device, float time, int type, int data);
    String getDeviceName() const;
    void setDeviceName(const String &device);
    float getTime() const;
    void setTime(float time);
    int getType() const;
    void setType(int type);
    String toJson() const;
    static TimeSetPayload fromJson(const String &jsonString);
}

#endif
