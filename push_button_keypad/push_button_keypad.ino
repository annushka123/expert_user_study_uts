const int AD_PIN = A0;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);

}

void loop() {
  // put your main code here, to run repeatedly:
  int adValue = analogRead(AD_PIN);
  Serial.println(buttonFromValue(adValue));
}

byte buttonFromValue(int adValue) {
  if(adValue > 300 && adValue < 500) {
    return 1;
  }

  if(adValue > 500 && adValue < 700) {
    return 2;
  }

  if(adValue > 700 && adValue < 900) {
    return 3;
  }

  if(adValue > 900) {
    return 4;
  }

  return 0;
}

