import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


float circleSize;
float halfH;
float lerpedAverage = 0;
float sum = 0;
float[] lerpedBuffer = new float[1024];

void setup()
{
  size (1000, 1000);
  colorMode(HSB);
  minim = new Minim (this);
  ap = minim.loadFile("groove.mp3", 1024);
  ap.play();
  ab = ap.mix;
  halfH = height/2;
}



Minim minim;
AudioPlayer ap;
AudioInput ai;
AudioBuffer ab;

void draw()
{
  background (0);
  for (int i = 0; i < ab.size (); i++)
  {
    sum += abs(ab.get(i));
  }
  float average = sum/(float)ab.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  drawHeart (width/2, height/2);
}

void drawHeart(int x, int y)
{
  noStroke();
  fill (255, 255, 255);
  triangle (x-(width/5), y, x + (width/5), y, x, y + (lerpedAverage * 9.15));
  circle(x - 100, y - 50, lerpedAverage * 8.5);
  circle(x + 100, y - 50, lerpedAverage * 8.5);
  textAlign (CENTER);
  textSize (lerpedAverage);
  text ("THIS IS LOVE", width/2, height/4);
}
