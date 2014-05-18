
/*
*  This program takes analogic input between 0 and 1023
*  from the serial port at 9600 baud and graphs them
*
*  It has been adapted for OuiSkin product which uses a moisture sensor
*  and nead to upload moisture or moistureSens scripts through the Arduino IDE  
*
*  
*  @file vizu_java.pde
*  @author Benoit Cotte
*/

import processing.serial.*;
 
// The serial port
Serial myPort;       
    

// diameter of the ellipse
int d = 10;
PFont myFont;
PImage logo;

// number of measures per screen
int LENGTH = 10;
// space between measures
int space = 0;

// calibration
int CAL = 500;

// index of measures
int i = 0;  // for any input
int index = 0;  // only for valid measures
float sum = 0;  // to sum valid measures to get an average
 
float[] absValue = new float[LENGTH];
float[] percValue = new float[LENGTH];
float[] relValue = new float[LENGTH];
float[] calValue = new float[LENGTH];
int[] xPos = new int[LENGTH + 1];
float[] yPos = new float[LENGTH];
String[] label = new String[LENGTH];

JSONArray values = new JSONArray();
 
void setup () 
{
  // dim of the window
  size(1200, 800);   
  space = width / (LENGTH + 1);
  xPos[0] = space;
  
  //Check in Serial.list()[index] that index is the port used for the Arduino board 
  // List all the available serial ports:
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600);
  // clear buffer if any remaining values
  myPort.clear();
  // set inital background color:
  background(255);
  // default fill
  fill(0);  
  // load image for conclusion
  logo = loadImage("logo.gif");
}

void draw () 
{
  if(myPort.available() > 0)
  {
    // once the LENGTH valid measures taken 
    if (index >= LENGTH) 
    {
      conclude(sum);
      // clear buffer
      myPort.clear();
      // Close the port
      myPort.stop();
    }
    
    else // check if all valid measures have been taken
    {
      // get the ASCII string
      String inString = myPort.readStringUntil('\n'); 
      
      if (inString != null)   // check if there is something
      {
        // trim off any whitespace
        inString = trim(inString);
        // convert to an float
        absValue[index] = float(inString); 
        
        // calibration
        calValue[index] = absValue[index] + CAL;
        
        // convert from 0 to 1023 to 0 to height
        relValue[index] = map(calValue[index], 0, 1023, 0, height);
        
        // convert to percentage
        percValue[index] = relValue[index] / height * 100;
              
        // yPos function of percValue
        yPos[index] = height - relValue[index];
  
        
        if (absValue[index] > 0) // draw and increment only if measure is valid
        {
            // draw the points if valid measure
            fill(52, 142, 246);
            noStroke();
            ellipse(xPos[index], yPos[index], d, d);
            // add text above the point
            label[index] = nf(percValue[index], 2, 2);
            text(label[index] + "%" ,xPos[index], yPos[index] - 25);
            
            // after first measure, draw a line between points
            if (index != 0) 
            {
              stroke(52, 142, 246);
              line(xPos[index - 1], yPos[index - 1], xPos[index], yPos[index]);
            }
    
          // save in the object
          JSONObject measure = new JSONObject();
          measure.setInt("index", index);
          measure.setFloat("percValue", percValue[index]);
          measure.setInt("xPos", xPos[index]);
          measure.setFloat("yPos", yPos[index]);      
          
          values.setJSONObject(index, measure);
          
          // prepare the sum for giving back an average at the end of the LENGTH measures
          sum = sum + percValue[index];
          
          // cool measure, increment index for next valid measure
          index ++; 
          
          // cool measure, increment x coord for next valid measure 
          xPos[index] = xPos[index - 1] + space;
        }
      }     
      // increment inputs intake 
      i ++;
    }
  }
}
 

 



