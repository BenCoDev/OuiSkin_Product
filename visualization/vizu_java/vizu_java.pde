/*
*  This program takes analogic input between 0 and 1023
*  from the serial port at 9600 baud and graphs them
*
*  It has been adapted for OuiSkin product which uses a moisture sensor
*  and nead to upload moisture or moistureSens scripts through the Arduino IDE  
*
*  based on Tom Igoe script
*  
*  @file vizu_java.pde
*  @author Benoit Cotte
*/

import processing.serial.*;
 
Serial myPort;       // The serial port
int xPos = 1;         // horizontal position of the graph
 
void setup () 
{
  // set the window size:
  size(1200, 600);        
   
  //Check in Serial.list()[index] that index is the port used for the Arduino board 
  // List all the available serial ports:
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background color:
  background(255);
}

void draw () 
{
 // everything happens in the serialEvent()
}
 
void serialEvent (Serial myPort) 
{
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
     
  if (inString != null) 
  {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an float:
    float inByte = float(inString); 
    // convert from 0 to 1023 to 0 to height:
    inByte = map(inByte, 0, 1023, 0, height);
     
    // draw the point:
    line(xPos, height, xPos, height - inByte);
     
    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) 
    {
      xPos = 0;
      background(0); 
    } 
    else 
    {
      // increment the horizontal position:
      xPos++;
    }
  }
}
 



