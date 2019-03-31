import processing.serial.*;
Serial myPort;
public static final char HEADER='h';
public static final short LF=10;
float vol;
float offset=100;
float scaleVal=35;
float angleInc=PI/60;
float angle=0;
float dx=0;
float under;
float high=200;
String [] com;
void setup()
{
  println(Serial.list());
  com=Serial.list();
  myPort=new Serial(this,COM10,9600);//duqudiyigekeyongchuangkou
  myPort.bufferUntil('\n');
  size(600,200);
  noStroke();
  frameRate(60);
}
void draw()
{
  scaleVal=map(vol,under,high,0,90);
  background(204);
  fill(255,0,0);
  rect(20,20,20,20);//gaiweizhi Click huoquzaoyinzhi
  fill(0);
  for(int posx=0;posx<=width;posx++)
  {
    float posy=offset+(sin(angle-dx)*scaleVal);
    rect(posx,posy,1,1);
    angle+=angleInc;
  }
  dx+=0.05;
  angle=0;
}
void serialEvent(Serial myPort)
{
  String message=myPort.readStringUntil(LF);
  if(message!=null)
  {
    String []data=message.split(",");
    if(data[0].charAt(0)==HEADER)
    {
      if(data.length>1)
      {
        vol=Integer.parseInt(data[1]);
        if(high<vol)vol=high;
        if(under>vol)vol=under;
      }
    }
  }
}void mouseClicked()
{
  if(mouseX<40&&mouseX>20)
    if(mouseY<40&&mouseY>20)
      under=vol;
}
