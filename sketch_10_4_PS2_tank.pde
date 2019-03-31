import processing.serial.*;
Serial myPort;
public static final char HEADER='M';
public static final short LF=10;
public static final short portIndex=2;
public static final short centerX=495;//yao gan jing zhi zhi (need debug)
public static final short centerY=497;
int x=300,y=200;
int speed=3;
char Direction;
class Tank
{
  Tank()
  {}
  void DisplayTank(int px,int py,char direction)
  {
    background(204);
    switch(direction)
    {
      case 'F':
        fill(255,255,0);
        rect(px-10,py,20,40);
        rect(px+30,py,20,40);
        ellipse(px+20,py+20,20,25);
        rect(px+17,py-10,6,19);
        break;
      case 'B':
        fill(255,255,0);
        rect(px-10,py,20,40);
        rect(px+30,py,20,40);
        ellipse(px+20,py+20,20,25);
        rect(px+17,py+30,6,19);
        break;
      case 'L':
        fill(255,255,0);
        rect(px,py-10,40,20);
        rect(px,py+30,40,20);
        ellipse(px+20,py+20,25,20);
        rect(px-10,py+17,19,6);
        break;
      case 'R':
        fill(255,255,0);
        rect(px,py-10,40,20);
        rect(px,py+30,40,20);
        ellipse(px+20,py+20,25,20);
        rect(px+30,py+17,19,6);
        break;
      default: break;
    }
  }
  void boundary(int px,int py)
  {
    if(px<10) x=10;
    if(py<10) y=10;
    if(px>(width-50)) x=width-50;
    if (py>(height-50)) y=height-50;
  }
  char tankDirection(int px,int py)
  {
    if((px<(centerX-30))&&(abs(px-centerX)>abs(py-centerY))) Direction='L';
    if((px>(centerX+30))&&(abs(px-centerX)>abs(py-centerY))) Direction='R';
    if((py<(centerY-30))&&(abs(px-centerX)<abs(py-centerY))) Direction='F';
    if((py<(centerY+30))&&(abs(px-centerX)<abs(py-centerY))) Direction='B';
    if((px>=(centerX-30))&&(px<=(centerX+30))&&(py>=(centerY-30)&&(py<=(centerY+30))))
        Direction='S';
    return Direction;
  }
}
Tank tank;
void setup()
{
  size(640,480);
  tank=new Tank();
  tank.DisplayTank(x,y,'F');
  myPort=new Serial(this,"COM10",9600);
  myPort.clear();
}
void draw()
{
}
void serialEvent(Serial myPort)
{
  String message=myPort.readStringUntil(LF);
  char direction;
  if(message!=null){
    print(message);
    String [] data = message.split(",");
    println(data[1]);
    println(data[2]);
    if(data[0].charAt(0)==HEADER)
    {
      if(data.length>2)
      {
        int tempX=Integer.parseInt(data[1]);
        int tempY=Integer.parseInt(data[2]);
        print(" x = " + tempX );
        print(", y = " + tempY );
        direction=tank.tankDirection(tempX,tempY);
        switch(direction)
        {
          case 'F':
              y=y-speed;
              tank.boundary(x,y);
              tank.DisplayTank(x,y,'F');
              break;
          case 'B':
              y=y+speed;
              tank.boundary(x,y);
              tank.DisplayTank(x,y,'B');
              break;
          case 'L':
              x=x-speed;
              tank.boundary(x,y);
              tank.DisplayTank(x,y,'L');
              break;
          case 'R':
              x=x+speed;
              tank.boundary(x,y);
              tank.DisplayTank(x,y,'R');
              break;
          case 'S': break;
          default:  break;
        }
      }
    }
  }
}
