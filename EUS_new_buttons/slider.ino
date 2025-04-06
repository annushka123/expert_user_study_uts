void slider() {
  //slider code
  float voltage = potVal * (3.3 / 1023.0);
  potVal = analogRead(potSlider);
  Serial.print("slider ");
  Serial.print(potVal);
  Serial.println("");
  delay(10);
}