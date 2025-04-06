void accel() {
    int8_t x;
    int8_t y;
    int8_t z;
    float ax, ay, az;
    accelemeter.getXYZ(&x, &y, &z);
    
    Serial.println("");
    Serial.print("x ");
    Serial.print(x );
    Serial.println("");
    Serial.print(" y ");
    Serial.print(y );
    Serial.println("");
    Serial.print(" z ");
    Serial.print(z );

    accelemeter.getAcceleration(&ax, &ay, &az);
    Serial.println("");
    Serial.print(" xg ");
    Serial.print(ax );
    Serial.println("");
    Serial.print(" yg ");
    Serial.print(ay );
    Serial.println("");
    Serial.print(" zg ");
    Serial.print(az );
    Serial.println("");
    delay(100);

  //SDA (data line): A4

//SCL (clock line): A5



}