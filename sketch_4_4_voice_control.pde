import processing.serial.*;
import ddf.minim.*;
Minim minim;
AudioPlayer player;
Serial port=new Serial(this,"COM10",9600);
float volume=-40;
void setup()
{
  size(300,300);
  minim=new Minim(this);
  player=minim.loadFile("test.mp3");
  player.play();
  player.loop();
}
void draw()
{
  if(port.read()=='a') volume++;
  if(port.read()=='b') volume--;
  player.setGain(volume);
}
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
