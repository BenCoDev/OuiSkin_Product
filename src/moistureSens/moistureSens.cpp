#include <Arduino.h>
#include "MoistureSensor.h"

MoistureSensor sensor;

long time; //var to store time

void setup() {
	//  setup serial
	Serial.begin(9600);

	delay(1000);

	sensor.init();
}

void loop() {


	// start the timer
	time = millis();

	// measure and print during 3 sec
	while(millis() - time <= 3000)
	{
		sensor.getValue();
		sensor.debug();
		delay(500);
	}
}
