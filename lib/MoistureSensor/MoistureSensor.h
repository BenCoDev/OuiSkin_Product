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
class MoistureSensor {

	public:

		MoistureSensor();

		void init();

		//	SENSORS
		void readValue();
		uint8_t getValue();
		void debug();

	private:

		//	VARIABLES
		uint8_t _moistureValue;
		static const uint8_t MOISTURE_SENSOR_PIN = 0;
};

#endif
