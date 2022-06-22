// Project 02 

// Note: You Will need the Minim Sound Library added to make this work.

float n4;
float n6;

//MUSIC  
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

float passBand;
float bandWidth;


Minim minim;
AudioPlayer mySound;
BandPass bandFilter;






//MAIN SETUP
void setup () {
  fullScreen(P3D);
  noCursor();
  smooth();
  background (0);
  frameRate(24);

  //Sound added file name 'chase.wav'
  //I created this sample myself by using garage band
  minim = new Minim(this);


  mySound = minim.loadFile("chase.wav");    
  //mySound.play();
  mySound.loop();
  bandFilter = new BandPass(440, 20, mySound.sampleRate());
  mySound.addEffect(bandFilter);

  // send the noise through the filter
}

void draw () {

  fill(0, 50);  
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);

  for (int i = 0; i < mySound.bufferSize() - 1; i++) {

    float angle = sin(i+n4)* 10; 
    float angle2 = sin(i+n6)* 300; 

    float x = sin(radians(i))*(angle2+30); 
    float y = cos(radians(i))*(angle2+30);

    float x3 = sin(radians(i))*(500/angle); 
    float y3 = cos(radians(i))*(500/angle);

    fill (#3ae6fc, 90); //yellow
    ellipse(x, y, mySound.left.get(i)*10, mySound.left.get(i)*10);

    fill ( #ffffff, 60); //wt
    rect(x3, y3, mySound.left.get(i)*20, mySound.left.get(i)*10);

    fill ( #ff9800, 90); //orange
    rect(x, y, mySound.right.get(i)*10, mySound.left.get(i)*10);


    fill( #ffffff, 70); //wt
    rect(x3, y3, mySound.right.get(i)*10, mySound.right.get(i)*20);}
  }


  void mouseMoved(){
    // map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies
    passBand = map(mouseX, 0, width, 100, 2000);
    bandFilter.setFreq(passBand);
    //bandWidth = map(mouseY, 0, height, 50, 500);
    bandWidth = 200;
    bandFilter.setBandWidth(bandWidth);
    n4 += 0.008;
    n6 += 0.04;
}
  
  
  

void stop()
{
  // always close Minim audio classes when you finish with them
  mySound.close();
  // always stop Minim before exiting
  minim.stop();

  super.stop();
}
