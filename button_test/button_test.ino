// Define pin numbers for the buttons
const int BUTTON1_PIN = 2;  // Connect to Sig0
const int BUTTON2_PIN = 3;  // Connect to Sig1

void setup() {
  // Configure button pins as inputs
  pinMode(BUTTON1_PIN, INPUT);
  pinMode(BUTTON2_PIN, INPUT);
  
  // Start serial communication
  Serial.begin(9600);
}

void loop() {
  // Read button states and invert them since we're using pull-up
  // (LOW when pressed, but we want 1 when pressed)
  int button1 = !digitalRead(BUTTON1_PIN);
  //int button2 = !digitalRead(BUTTON2_PIN);
  
  // Print the values
  Serial.println(button1);
  Serial.print(" ");
  //Serial.println(button2);
  
  // Small delay to prevent serial buffer overflow
  delay(100);
}