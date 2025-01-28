// Pin definition at the top
const int ROTARY_PIN = A1;  // Choose an available analog pin
const int NUM_READINGS = 5;  // Number of readings to average

void setup() {
    Serial.begin(9600);  // Initialize serial communication
    // Note: analog pins don't need pinMode()
}

void loop() {
    // Take multiple readings and average them
    int total = 0;
    for(int i = 0; i < NUM_READINGS; i++) {
        total += analogRead(ROTARY_PIN);
        delay(1);  // Brief delay between readings
    }
    int rotaryValue = total / NUM_READINGS;
    
    Serial.print("rotary ");
    Serial.println(rotaryValue);
    
    delay(100);
}