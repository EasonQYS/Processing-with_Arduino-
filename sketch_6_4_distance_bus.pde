PImage bus;
int x=0,y=150;
import processing.serial.*;
Serial myPort;
int distance=0;
void setup()
{
  size(640,480);
  bus=loadImage("bus.png");
  myPort=new Serial(this,"COM10",9600);
}
void draw()
{
  if(myPort.available()>0)
  {
    distance=myPort.read();
    println(distance);
  }
  background(255);
  fill(30,40,40);
  rect(600,80,30,200);
  x=(450-distance)*(600-bus.width)/450;
  image(bus,x,y);
  text("Distance is "+distance+"CM",400,40);
}
