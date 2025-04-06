void buttonPress() {
    // Read button states and invert them since we're using pull-up
  // (LOW when pressed, but we want 1 when pressed)
  int button1 = !digitalRead(BUTTON1_PIN);
  int button2 = !digitalRead(BUTTON2_PIN);
  int button3 = !digitalRead(BUTTON3_PIN);
  int button4 = !digitalRead(BUTTON4_PIN);
  
  // Print the values
 
Serial.print("button_1 ");
Serial.println(button1);
Serial.print("button_2 ");
Serial.println(button2);
Serial.print("button_3 ");
Serial.println(button3);
Serial.print("button_4 ");
Serial.println(button4);

  
  // Small delay to prevent serial buffer overflow
  delay(5);
}