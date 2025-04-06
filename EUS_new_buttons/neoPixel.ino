void neoPixel() {
    if (Serial.available() > 0) {

    value = Serial.read();
    // Serial.println(value);

    if (value == 1) {
      strip.setPixelColor(0, strip.Color(255, 0, 0));
      strip.setPixelColor(1, strip.Color(255, 20, 255));
      // colorWipe(strip.Color(255, 0, 0), 500);
      strip.show();
    } else if (value == 0) {

      strip.setPixelColor(0, strip.Color(0, 20, 255));
      strip.setPixelColor(1, strip.Color(0, 20, 255));
      // colorWipe(strip.Color(255, 0, 0), 500);
      strip.show();
    }
  }
}