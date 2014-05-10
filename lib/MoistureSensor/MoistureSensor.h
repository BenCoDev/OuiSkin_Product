#ifndef _MOISTURE_SENSOR_H_
#define _MOISTURE_SENSOR_H_

/**
 * @file MoistureSensor.h
 * @author Ladislas de Toldi
 * @version 1.0
 */

#include <Arduino.h>

/**
 * @class MoitstureSensors
 */
class MoistureSensors {

	public:

		MoistureSensors();

		void init();

		//	SENSORS
		void getValue();
		void debug();

	private:

		//	VARIABLES
		uint8_t moistureValue;

};

#endif
