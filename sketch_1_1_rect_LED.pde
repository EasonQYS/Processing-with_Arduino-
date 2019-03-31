import processing.serial.*;
Serial port;
void setup()
{
  port=new Serial(this,"COM10",9600);
  size(300,300);
}
void draw()
{
  rect(100,100,50,50);
}
void mouseClicked()
{
  if((mouseX>=100)&(mouseX<=150)&(mouseY>=100)&(mouseY<=150))
  {
    println("LED turn ON!");
    port.write("a");
  }
  else
  {
    println("LED turn OFF!");
    port.write("b");
  }
}
      
