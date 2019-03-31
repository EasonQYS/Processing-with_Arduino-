import processing.serial.*;
Serial myPort;
void setup()
{
  size(300,300);
  fill(0,255,0);
  ellipse(100,100,100,100);//yuanxing
  myPort=new Serial(this,"COM10",9600);
}
void draw()
{
  while(myPort.available()>0)
  {
    char inByte=myPort.readChar();
    println(inByte);
    switch(inByte)
    {
      case 'a':fill(0,255,0);ellipse(100,100,100,100);break;
      case 'b':fill(255,0,0);ellipse(100,100,100,100);break;
      default:break;
    }
  }
}
