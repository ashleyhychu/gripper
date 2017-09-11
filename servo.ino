#include <Servo.h>

Servo servo1; 
void setup() {
  // put your setup code here, to run once:
  pinMode(1,OUTPUT);
  //servo1.attach(13,1650,1900); //analog pin 0 
  servo1.attach(13);
  //servo1.setMaximumPulse(1900);
  //servo1.setMinimumPulse(1500);

 
  Serial.begin(115200);
  Serial.println("Ready");
}

void loop() {
  // put your main code here, to run repeatedly:
  static int v = 0;
  static int deg = 2000;
  static int targetdeg = 2000;
  static int flag = 0;
  if ( Serial.available()) 
  {
    char ch = Serial.read();

    switch(ch) {
      case '0'...'9':
        v = v * 10 + ch - '0';
        break;
      case 'a':
          targetdeg = 1500;
        break;
      case 's':
          targetdeg = 1700;
          break;
      case 'd':
          targetdeg = 1900;
        break;
      case 'f':
          targetdeg = 2000;
          break;
      case 'g':
          targetdeg = 2100;
          break;
      case 'h':
          targetdeg = 2200;
          break;
      case 'j':
          targetdeg = 2300;
          break;
      case 'k':
          targetdeg = 2400;
          break;
      case 'l':
          targetdeg = 2500;
          break;
      case 'z':
          targetdeg = v;
          v = 0;
          break;
      
      default:
        break;
    }     
  }


    if(deg > targetdeg)
      deg -= 30;
    else
      deg += 30;
      
    if(deg < 1500)
      deg = 1500;
    else if (deg > 2500)
      deg = 2500;
    else
      deg = deg;
  
    //servo1.write(targetdeg);
    servo1.writeMicroseconds(deg);     //stop
    //String stringTarget =  String(targetdeg);
    //String stringDeg = String(deg);
    //Serial.write("target:");
    //Serial.write(targetdeg);
    //Serial.write(" deg:");
    //Serial.write(deg);
    
  delay(15);
    //servo1.write(90);
    //delay(500);
}

  //Servo::refresh();
