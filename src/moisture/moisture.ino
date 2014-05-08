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
  
  // If value != 0
  if (analogRead(sensorPin))  
  { 
    // start the timer 
    time = millis();
    
    // measure and print during 3 sec
    while(millis() - time <= 3000)
    {
      sensorValue = analogRead(sensorPin);
      Serial.print("sensor = " );                       
      Serial.println(sensorValue);
      delay(500);
    }
    // end of measure
    Serial.print("Measure recorded\n");    
  }
  else 
  {
     Serial.print("Place the sensor\n");
     delay(500);
  }
}
