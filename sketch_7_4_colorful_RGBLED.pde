import processing.serial.*;
Serial port = new Serial(this,"COM10",9600);
int redDisplay,greenDisplay,blueDisplay;
int red,green,blue;
String strRed,strGreen,strBlue;
String message;
void setup()
{
  size(700,500);
}
void draw()
{
  background(204);
  frame();
  RGBDisplay();
  sendMessage();
}
void frame(){
  rectMode(CORNER);
  noFill();
  stroke(255,0,0);
  strokeWeight(2);
  rect(50,100,500,50);
  stroke(0,255,0);
  rect(50,200,500,50);
  stroke(0,0,255);
  rect(50,300,500,50);
}
void RGBDisplay()
{
  rectMode(CORNER);
  noStroke();
  fill(red,0,0);
  rect(50,100,redDisplay,50);
  fill(0,green,0);
  rect(50,200,greenDisplay,50);
  fill(0,0,blue);
  rect(50,300,blueDisplay,50);
  fill(red,green,blue);
  rect(300,400,50,50);
  fill(0);
  rect(400,400,50,50);
}
void mouseClicked()
{
  if(mouseX<=550&&mouseX>=50)
  {
    if(mouseY<=150&&mouseY>=100)
    {
      red=(int)map(mouseX,50,550,0,255);
      redDisplay=mouseX-50;
    }
    if(mouseY<=250&&mouseY>=200)
    {
      green=(int)map(mouseX,50,550,0,255);
      greenDisplay=mouseX-50;
    }
    if(mouseY<=350&&mouseY>=300)
    {
      blue=(int)map(mouseX,50,550,0,255);
      blueDisplay=mouseX-50;
    }
    if(mouseX<=450&&mouseX>=400)
      if(mouseY<=450&&mouseY>=400)
        shut();//turn off LED;
  }
}
void sendMessage()
{
  strRed=red+"";//turn to a string;
  if(red<100)
    strRed="0"+red;
  if(red<10)
    strRed="0"+red;//bu qi san wei?
  strGreen=green+"";//turn to a string;
  if(green<100)
    strGreen="0"+green;
  if(red<10)
    strGreen="0"+green;
  strBlue=blue+"";//turn to a string;
  if(blue<100)
    strBlue="0"+blue;
  if(red<10)
    strBlue="0"+blue;
  message="a"+strRed+strGreen+strBlue+"s";
  port.write(message);
}
void shut()
{
  redDisplay=0;
  greenDisplay=0;
  blueDisplay=0;
  red=0;
  green=0;
  blue=0;
}
