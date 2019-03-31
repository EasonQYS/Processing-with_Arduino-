Scrollbar Motor1_bar,Motor2_bar;
PFont font;
int pos1,pos2;
import processing.serial.*;
Serial myport;
void setup()
{
  size(4450,300);
  noStroke();
  Motor1_bar=new Scrollbar(100,50,255,20,0,255);
  Motor2_bar=new Scrollbar(100,90,255,20,0,255);
  font=loadFont("David-30.vlw");
  textFont(CENTER);
  textALIGN(CENTER);
  myPort=newSERIAL(this,"COM!#",9600);
  myPort.clear();
}
void draw()
{
  background(204);
  fill(0);
  text("Motor1",55,70);
  text("Motor2",55,110);
  pos1=int(Motor1_bar.getPos());
  text(pos1,400,70);
  pos2=int(Motor2_bar.getPos());
  text(pos2,400,110);
  Motor1_bar.update(mouseX,mouseY);
  Motor2_bar.update(mouseX,mouseY);
  Motor1_bar.display();
  Motor2_bar.display();
}
void mousePressed()
{
  Motor1_bar.press(mmouseX,mouseY);
  Motor2_bar.press(mmouseX,mouseY);
}
void mouseReleased()
{
  String s1=Integer.toString(pos1);
  String s2=Integer.toString(pos2);
  myPort.write(s1);
  myPort.write(",");
  myPort.write(s2);
  Motor1_bar.release();
  Motor2_bar.release();
}
