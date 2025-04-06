void fsr() {
    int analogReading = analogRead(FORCE_SENSOR_PIN);

  Serial.print("Force_sensor ");
  Serial.print(analogReading);
  Serial.println(""); // print the raw analog reading
}