#include <Wire.h>
#include "MMA7660.h"
#include <Adafruit_NeoPixel.h>
#include <Kalman.h> // Correct Kalman filter library

#define FORCE_SENSOR_PIN A6
#define LED_PIN 6

#define LED_COUNT 1
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

int value;
int const potSlider = A7;
int potVal;

const int AD_PIN = A0;
byte previousButton = 0;

// Create Kalman filter objects for each axis
Kalman kalmanX;  // Create a Kalman object for X-axis
Kalman kalmanY;  // Create a Kalman object for Y-axis
Kalman kalmanZ;  // Create a Kalman object for Z-axis

MMA7660 accelemeter;

void setup() {
    Serial.begin(57600);
    accelemeter.init();

    strip.begin();
    strip.show();

    // Initialize the Kalman filter angle
    kalmanX.setAngle(0); // Assuming starting at zero angle
    kalmanY.setAngle(0);
    kalmanZ.setAngle(0);
}

void loop() {
    // Main code here, running repeatedly
    int adValue = analogRead(AD_PIN);
    byte button = buttonFromValue(adValue);

    if (button != previousButton) {
        if (button != 0) {
            Serial.print("button_");
            Serial.print(button);
            Serial.print(" ");
            Serial.print(1);
            Serial.println("");
        } else {
            Serial.print("button_");
            Serial.print(previousButton);
            Serial.print(" ");
            Serial.print(0);
            Serial.println("");
        }
        previousButton = button;
    }

    int8_t x, y, z;
    float ax, ay, az;
    accelemeter.getXYZ(&x, &y, &z);

    // Convert to float for Kalman filter
    float x_acc = (float)x;
    float y_acc = (float)y;
    float z_acc = (float)z;

    // Assume the rate of change of the angle is zero initially
    float rateX = 0.0;
    float rateY = 0.0;
    float rateZ = 0.0;
    
    // Apply Kalman filter with the rate of change and time delta
    float filteredX = kalmanX.getAngle(x_acc, rateX, 0.01); // 0.01 is the time between updates
    float filteredY = kalmanY.getAngle(y_acc, rateY, 0.01);
    float filteredZ = kalmanZ.getAngle(z_acc, rateZ, 0.01);

    Serial.println("");
    Serial.print("x ");
    Serial.print(filteredX);
    Serial.println("");
    Serial.print("y ");
    Serial.print(filteredY);
    Serial.println("");
    Serial.print("z ");
    Serial.print(filteredZ);

    accelemeter.getAcceleration(&ax, &ay, &az);
    Serial.println("");
    Serial.print(" xg ");
    Serial.print(ax);
    Serial.println("");
    Serial.print(" yg ");
    Serial.print(ay);
    Serial.println("");
    Serial.print(" zg ");
    Serial.print(az);
    Serial.println("");
    delay(100);

    // Slider code
    float voltage = potVal * (3.3 / 1023.0);
    potVal = analogRead(potSlider);
    Serial.print("slider ");
    Serial.print(potVal);
    Serial.println("");
    delay(10);

    int analogReading = analogRead(FORCE_SENSOR_PIN);

    Serial.print("Force_sensor ");
    Serial.print(analogReading);
    Serial.println(""); // Print the raw analog reading

    delay(100);

    if (Serial.available() > 0) {
        value = Serial.read();
        // Serial.println(value);

        if (value == 0) {
            strip.setPixelColor(0, strip.Color(200, 0, 0));
            strip.setPixelColor(1, strip.Color(255, 20, 255));
            strip.show();
        } else if (value == 1) {
            strip.setPixelColor(0, strip.Color(0, 20, 200));
            strip.setPixelColor(1, strip.Color(0, 20, 255));
            strip.show();
        } else if (value == 2) {
            strip.setPixelColor(0, strip.Color(200, 20, 200));
            strip.setPixelColor(1, strip.Color(0, 20, 255));
            strip.show();
        } else if (value == 3) {
            strip.setPixelColor(0, strip.Color(0, 150, 150));
            strip.setPixelColor(1, strip.Color(0, 20, 255));
            strip.show();
        } else if (value == 4) {
            strip.setPixelColor(0, strip.Color(150, 200, 210));
            strip.setPixelColor(1, strip.Color(0, 20, 255));
            strip.show();
        } else if (value == 5) {
            strip.setPixelColor(0, strip.Color(10, 10, 10));
            strip.setPixelColor(1, strip.Color(0, 20, 255));
            strip.show();
        }
    }
}

// Buttons
byte buttonFromValue(int adValue) {
    if (adValue > 300 && adValue < 500) {
        return 1;
    }

    if (adValue > 500 && adValue < 700) {
        return 2;
    }

    if (adValue > 700 && adValue < 900) {
        return 3;
    }

    if (adValue > 900) {
        return 4;
    }

    return 0;
}
