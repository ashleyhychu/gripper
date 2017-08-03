#include <Servo.h>

Servo servo1; 
void setup() {
  // put your setup code here, to run once:
  pinMode(1,OUTPUT);
  servo1.attach(12,1600,1900); //analog pin 0 
  //servo1.setMaximumPulse(1900);
  //servo1.setMinimumPulse(1500);

 
  Serial.begin(115200);
  Serial.println("Ready");
}

void loop() {
  // put your main code here, to run repeatedly:
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
    servo1.write(130);
    delay(500);
    //servo1.write(80);
    //delay(500);
}

  //Servo::refresh();
 
