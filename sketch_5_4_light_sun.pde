PImage img;
import processing.serial.*;
Serial myPort;
void setup()
{
  myPort=new Serial(this,"COM10",9600);
  size(500,500);
  img=loadImage("sunshine.jpg");
  background(255);
  myPort.clear();
}
int data;
void draw()
{
  if(myPort.available()>0)
  {
    data=myPort.read();
    if(data>255)data=255;
    data=255-data;
    println(data);
  }
  sun(data);
}
void sun(int light)
{
  tint(light);
  image(img,0,0);
}
