import processing.serial.*;
Serial port=new Serial(this,"COM27",9600);
public static final char HEADER='h';
int water;
int state=0;
float level;
void setup()
{
  size(400,400);
  port.bufferUntil('\n');
}
void Draw()
{
  rectMode(CORNER);
  background(204);
  fill(0,0,255);
  rect(50,300-level,300,level);
  noFill();
  rect(50,100,300,200);
  fill(200,200,0);
  rect(300,50,20,250);
  fill(255,0,0);
  rect(300,130,20,5);
  if(state==1) fill(255,0,0);
  else fill(0,255,0);
  ellipse(50,50,50,50);
}
void serialEvent(Serial port)
{
  String message=port.readStringUntil(LF);
  if(message!=null)
  {
    String [] data=message.split(",");
    if(data[0].charAt(0)==HEADER)
    {
      if(data.length>1)
      {
        water=Integer.parseInt(data[1]);
        if(water<100) water=100;
        if(water>700) water=700;
        level=map(water,100,700,0,200);
        if(level>=170)state=1;
        else state=0;
      }
    }
  }
}
