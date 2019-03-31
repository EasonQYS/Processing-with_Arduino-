class Temperature
{
  private int x;
  private int y;
  private int data;
private float warnTem=50;
//?
Temperature(int x,int y)
{
  this.x=x;
  this.y=y;
}
void display()
{
  Shape();
}
void warning()
{
  if(data>warnTem)
    fill(255,0,0);
  else
    fill(0,255,0);
  ellipse(x+100,y,30,30);
}
void Shape()
{
  rectMode(CORNER);
  rect(x,y-10,50,360,10,10,10,10);
  fill(255,0,0);
  ellipse(x+25,y+300,49,30);
  stroke(0);
  fill(255);
  for(int i=0;i<31;i++)
  {
    line(x-15,y+10*i,x-10,y+10*i);
    if(i%5==0)
    {
      line(x-20,y+10*i,x-10,y+10*i);
      fill(0);
      text(50-i+"°C",x-45,y+10*i);
      fill(255);
      continue;
    }
  }
}
void update()
{
  this.data=Integer.parseInt(data);//transform to int;
  noStroke();
  fill(255);
  if(this.data>20)
  {
    rect(x+1,y,49,300);
    fill(255,0,0);
    rect(x+1,y+300-this.data*10+200,49,this.data*10-200);
    stroke(0,255,0);
    line(x+1,y+300-warnTem*10+200,x+49,y+300-warnTem*10+200);
    noStroke();
    warning();
  }
}
}
class Humidity
{
  private int x;
  private int y;
  private int data;
  private float warnHum=50;
  
  Humidity(int x,int y)
  {
    this.x=x;
    this.y=y;
  }
  void setWarnHum(float hum)
  {
    warnHum=hum;
  }
  void warning()
  {
    if(data>warnHum) fill(255,0,0);
    else fill(0,255,0);
    ellipse(x-50,y,30,30);
  }
  void display()
  {
    shape();
  }
  void Shape()
  {
    rectMode(CORNER);
    rect(x,y-10,50,360,10,10,10,10);
    fill(50,50,255);
    ellipse(x+25,y+350,80,80);
    noStroke();
    rect(x+1,y+300,49,30);
    stoke(0);
    fill(255);
    for(int i=0;i<61;i++)
    {
      line(x+60,y+5*i,x+65,y+5*i);
      if(i%10==0)
      {
        line(x+60,y+5*i,x+70,y+5*i);
        fill(0);
        text(90-i,x+85,y+5*i);
        fill(255);
        continue;
      }
      if(i%5==0) line(x+60,y+5*i,x+68,y+5*i);
    }
  }
  void update(String data)
  {
    this.data=Integer.parseInt(data);
    noStroke();
    fill(255);
    if(this.data>30)
    {
      rect(x+1,y,49,300);//cllear
      fill(50,50,255);//red
      rect(x+1,y+300-warnHum*5+150,x+49,y+300-warnHum*5+150);
      noStroke();
      warning();
    }
  }
}




import processing.serial.*;
Serial port;
Temperature myTem=new Temperature(100,50);
Humidity myHum=new Humidity(400,50);
String data;
String [] str;
float resTem=50;
float resHum=90;
void setup()
{
  size(600,500);
  smooth();
  port=new Serial(this,"COM10",9600);
  port.bufferUntil('\n');
  myTem.display();//show the shape
  myHum.display();
}
void draw()
{
  myTem.setWarnTem(resTem);
  myHum.setWarnHum(resHum);
}
void serialEvent(Serial p)
{
  String inString=p.readString();
  data=inString;
  str=data.split(",");//divide them 
  myTem.update(str[1]);
  myHum.update(str[0]);
  println("tem:"+str[1]);
  println("hum:"+str[0]);
}
void mouseClicked()
{
  if(mouseX>100&&mouseX<150)
  if(mouseY>50&&mouseY<350)
  {
    resTem=map(mouseY,50,350,50,20);
    stroke(0);
  }
  if(mouseX>400&&mouseX<450)
  if(mouseY>50&&mouseY<350)
  {
    resHum=map(mouseY,50,350,90,30);
  }
}
