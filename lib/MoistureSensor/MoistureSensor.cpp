#include <Arduino.h>
#include "MoistureSensor.h"

/**
 * @file MoistureSensor.cpp
 * @author Ladislas de Toldi
 * @version 1.0
 */


//-----------------------------------------------------//
// CONSTRUCTORS
//-----------------------------------------------------//

/**
 * @brief MoitsureSensors Class Constructors
 */
MoistureSensor::MoistureSensor(){
	// nothing to do here
}

void MoistureSensor::init(){
	// to be implemented
	_moistureValue = 0;
}


//-----------------------------------------------------//
// GENERAL
//-----------------------------------------------------//

/**
 * @brief
 */
void MoistureSensor::getValue(){
	// to be implemented
	_moistureValue = analogRead(MOISTURE_SENSOR_PIN);
}

/**
 * @brief
 */
void MoistureSensor::debug(){
	// to be implemented
	Serial.print(F("Moisture Value: "));
	Serial.println(_moistureValue);
}

