/*
*
*  This program takes input from the moisture sensor
*  and print them in serial
*
*
* @file moisture.ino
* @author Benoit Cotte
* 
*/


#include <Arduino.h>

const int sensorPin = 0;    // select the input pin for the sensor
int sensorValue = 0;  // variable to store the value coming from the sensor
long time; //var to store time

void setup() {
  //  setup serial
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);
  delay(500);
}
