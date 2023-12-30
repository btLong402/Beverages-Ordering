#include "Payload.h"

// Constructor implementation
Payload::Payload(int data) : data_(data) {}

// Member function implementation
void Payload::displayData()
{
    Serial.print("Data: ");
    Serial.println(data_);
}

// Implementation for RemotePayload class

// Default constructor
RemotePayload::RemotePayload() : data_(0) {}

// Parameterized constructor
RemotePayload::RemotePayload(String dev, int dat) : device_(dev), data_(dat) {}

// Getter and Setter for Device Name
String RemotePayload::getDeviceName() const
{
    return device_;
}

void RemotePayload::setDeviceName(const String &device)
{
    device_ = device;
}

// Getter and Setter for Data
int RemotePayload::getData() const
{
    return data_;
}

void RemotePayload::setData(int data)
{
    data_ = data;
}
String RemotePayload::toJson() const
{
    StaticJsonDocument<256> doc;
    doc["device"] = device_;
    doc["data"] = data_;

    String jsonString;
    serializeJson(doc, jsonString);
    return jsonString;
}

RemotePayload RemotePayload::fromJson(const String &jsonString)
{
    DynamicJsonDocument doc(256); // Adjust the size based on your JSON data size
    deserializeJson(doc, jsonString);

    String device = doc["device"];
    int data = doc["data"];

    return RemotePayload(device, data);
}
// ---------------------------------------------------------------------------------------------------------------------------------

// Implementation for TimeSetPayload class

// Default constructor

TimeSetPayload::TimeSetPayload() : time_(0), type_(0), data_(0) {}

// Parameterized constructor implementation
TimeSetPayload::TimeSetPayload(String device, float time, int type, int data)
    : device_(device), time_(time), type_(type), data_(data) {}

// Getter and Setter implementations
String TimeSetPayload::getDeviceName() const
{
    return device_;
}

void TimeSetPayload::setDeviceName(const String &device)
{
    device_ = device;
}

float TimeSetPayload::getTime() const
{
    return time_;
}

void TimeSetPayload::setTime(float time)
{
    time_ = time;
}

int TimeSetPayload::getType() const
{
    return type_;
}

void TimeSetPayload::setType(int type)
{
    type_ = type;
}

// Method to convert object to JSON string
String TimeSetPayload::toJson() const
{
    DynamicJsonDocument doc(256); // Adjust the size based on your JSON data size
    doc["device"] = device_;
    doc["time"] = time_;
    doc["type"] = type_;
    doc["data"] = data_;

    String jsonString;
    serializeJson(doc, jsonString);
    return jsonString;
}

// Static method to create an object from JSON string
TimeSetPayload TimeSetPayload::fromJson(const String &jsonString)
{
    DynamicJsonDocument doc(256); // Adjust the size based on your JSON data size
    deserializeJson(doc, jsonString);

    String device = doc["device"];
    float time = doc["time"];
    int type = doc["type"];
    int data = doc["data"];

    return TimeSetPayload(device, time, type, data);
}