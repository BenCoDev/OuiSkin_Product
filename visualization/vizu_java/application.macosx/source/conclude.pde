void conclude(float sum)
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
