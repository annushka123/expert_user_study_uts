/*****************************************************************************/
//	Function:    Get the accelemeter of X/Y/Z axis and print out on the
//					serial monitor.
//  Hardware:    3-Axis Digital Accelerometer(��16g)
//	Arduino IDE: Arduino-1.0
//	Author:	 Frankie.Chu
//	Date: 	 Jan 11,2013
//	Version: v1.0
//	by www.seeedstudio.com
//
//  This library is free software; you can redistribute it and/or
//  modify it under the terms of the GNU Lesser General Public
//  License as published by the Free Software Foundation; either
//  version 2.1 of the License, or (at your option) any later version.
//
//  This library is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public
//  License along with this library; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//
/*******************************************************************************/

#include <Wire.h>
#include "MMA7660.h"
MMA7660 accelemeter;
#include <Adafruit_NeoPixel.h>

#define FORCE_SENSOR_PIN A6
#define LED_PIN 6

#define LED_COUNT 1
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

int value;
int const potSlider = A7;
int potVal;

const int BUTTON1_PIN = 2;  // Connect to Sig0
const int BUTTON2_PIN = 3;  // Connect to Sig1
const int BUTTON3_PIN = 4;  // Connect to Sig0
const int BUTTON4_PIN = 5;  // Connect to Sig1

const int AD_PIN = A0;
byte previousButton = 0;

void setup() {
  Serial.begin(57600);
  accelemeter.init();
  pinMode(BUTTON1_PIN, INPUT);
  pinMode(BUTTON2_PIN, INPUT);
  pinMode(BUTTON3_PIN, INPUT);
  pinMode(BUTTON4_PIN, INPUT);

  strip.begin();
  strip.show();
}

void loop() {

  // put your main code here, to run repeatedly:
  int adValue = analogRead(AD_PIN);


  

  accel();

  slider();

  fsr();

  delay(100);

  neoPixel();


  buttonPress();
  

  
}
