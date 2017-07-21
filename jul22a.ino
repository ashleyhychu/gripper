#include <Servo.h>

Servo servo1; 

void setup() {

  pinMode(1,OUTPUT);
  servo1.attach(12); //analog pin 0 
  //servo1.setMaximumPulse(2000);
  //servo1.setMinimumPulse(700);

 
  Serial.begin(115200);
  Serial.println("Ready");

}

void loop() {

  static int v = 0;
  int deg = 90;
  if ( Serial.available()) 
  {
    char ch = Serial.read();

    switch(ch) {
      case '0'...'9':
        v = v * 10 + ch - '0';
        break;
      case 'a':
          deg = 90;
        break;
      case 'd':
          deg = 45;
        break;
      case 's':
          deg = v;
          break;
      default:
        break;
    }    
    
  }
    servo1.write(deg);
}
  //Servo::refresh();
 
