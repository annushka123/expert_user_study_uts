int const potSlider = A0;
int potVal;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println(potVal);
}

void loop() {
  // put your main code here, to run repeatedly:
 //slider code
  float voltage = potVal * (3.3 / 1023.0);
  potVal = analogRead(potSlider);
  Serial.print("slider ");
  Serial.print(potVal);
  Serial.println("");
  delay(10);
}
