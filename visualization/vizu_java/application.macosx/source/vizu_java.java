import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class vizu_java extends PApplet {


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
 
public void setup () 
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

public void draw () 
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
        absValue[index] = PApplet.parseFloat(inString); 
        
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
 

 



public void conclude(float sum)
{    
      
    background(255);
    
    imageMode(CENTER);
    image(logo, width/2, 3*height/4);
    
    float floatAverage = sum/LENGTH;   
    String strAverage = nf(floatAverage, 2, 2);
    
    
    strokeWeight(3);
    stroke(234, 244, 254);
    float linePos = height - ((floatAverage) / 100) * height;
    println(linePos);
    
    // place a nice line at the average level
    line(0, linePos, width, linePos);
    fill(204, 224, 254);
    text(strAverage + "%", 15, linePos + 15); 
    
    textAlign(CENTER);
    myFont = createFont("OpenSans-Light.ttf", width/25);
    textFont(myFont); 
    fill(0);
    text("On an arbitrary scale, your average skin hydration is ", width/2, height/4);
    

    textFont( myFont, height/4);
    fill(52, 142, 246);
    text(strAverage + "%", width/2, height/2); 
    saveJSONArray(values, "data/new.json");
    

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "vizu_java" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
