// PATTERN MASTER
// Golan Levin, golan@flong.com
// Spring 2006 - March 2013


// Additional functions to consider: 
// http://en.wikipedia.org/wiki/Generalised_logistic_function Richard's Curve
// http://en.wikipedia.org/wiki/Probit_function


// Java imports for introspection, so we know the functions' arguments. 
import java.lang.*;
import java.lang.reflect.Method;
import java.lang.reflect.Type;

// Imports for PDF, to save a vector graphic of the function.
import processing.pdf.*;
boolean doSavePDF=false;

boolean bDrawProbe = true;
boolean bDrawGrayScale = true;
boolean bDrawNoiseHistories = true; 
boolean bDrawModeSpecificGraphics = true;
boolean bDrawAnimatingRadiusCircle = true;

color boundingBoxStrokeColor = color(180); 

//-----------------------------------------------------
float xscale = 300;
float yscale = 300;
float bandTh  = 60;
float margin0 = 10;
float margin1 = 5;
float margin2 = 90;
float xoffset = margin0 + bandTh + margin1;
float yoffset = margin0 + bandTh + margin1;

float param_a = 0.25;
float param_b = 0.75;
float param_c = 0.75;
float param_d = 0.25;
int   param_n = 3;

float probe_x = 0.5;
float probe_y = 0.5;
float animationConstant = 1000.0;

boolean visited = false;
boolean bClickedInGraph = false;
String functionName = "";

int FUNCTIONMODE = 0;
int MAX_N_FLOAT_PARAMS = 4;

DataHistoryGraph noiseHistory;
DataHistoryGraph cosHistory;
DataHistoryGraph triHistory;

//-----------------------------------------------------
void keyPressed() {
  int nFunctions = functionMethodArraylist.size(); 

  if (key == CODED) { 
    if ((keyCode == UP) || (keyCode == RIGHT)) { 
      FUNCTIONMODE = (FUNCTIONMODE+1)%nFunctions;
    } 
    else if ((keyCode == DOWN) || (keyCode == LEFT)) { 
      FUNCTIONMODE = (FUNCTIONMODE-1+nFunctions)%nFunctions;
    }
  } 
  if (key=='P') {
    doSavePDF = true;
  }
}

//-----------------------------------------------------
void setup() {
  int scrW = (int)(margin0 + bandTh + margin1 + xscale + margin0);
  int scrH = (int)(margin0 + bandTh + margin1 + yscale + margin2 + bandTh + margin0 + bandTh + margin0 + bandTh + margin1 + 30);
  // surface.setSize(scrW, scrH); // @jeffThompson's good idea
  size (385,700); 
  
  initHistories();
  introspect();
}



//-----------------------------------------------------
void mouseMoved() {
  visited = true;
}

int whichButton = 0; 
void mousePressed() {
  bClickedInGraph = false;
  if ((mouseX >= xoffset) && (mouseX <= (xoffset + xscale)) && 
    (mouseY >= yoffset) && (mouseY <= (yoffset + yscale))) {

    if (mouseButton == LEFT) {
      whichButton = 1;
    } 
    else if (mouseButton == RIGHT) {
      whichButton = 2;
    } 
    else {
      whichButton = 0;
    }

    bClickedInGraph = true;
  }
}

void mouseReleased() {
  whichButton = 0;
}



//====================================================
void drawPDF() {


  String pdfFilename = functionName;
  /*
  if (useParameterA) { 
   pdfFilename += "_a=" + nf(param_a, 1, 2);
   }
   if (useParameterB) { 
   pdfFilename += "_b=" + nf(param_b, 1, 2);
   }
   if (useParameterC) { 
   pdfFilename += "_c=" + nf(param_c, 1, 2);
   }
   if (useParameterD) { 
   pdfFilename += "_d=" + nf(param_d, 1, 2);
   }
   if (useParameterN) { 
   pdfFilename += "_n=" + nf(param_n, 1, 2);
   }
   */
  pdfFilename += ".pdf";


  beginRecord(PDF, pdfFilename); 

  strokeJoin(MITER);
  strokeCap(ROUND);
  strokeWeight(1.0);
  noFill();
  stroke(0);
  rect(0, 0, width, height);

  background (255, 255, 255);
  stroke(128);
  fill(255);
  rect(xoffset, yoffset, xscale, yscale);
  drawModeSpecificGraphics();

  // draw the function's curve
  float x = 0;
  float y = 1 - function (x, param_a, param_b, param_c, param_d, param_n);
  float qx = xoffset + xscale * x;
  float qy = yoffset + yscale * y;
  float px = qx;
  float  py = qy;
  stroke(0);
  noFill();
  beginShape();
  vertex(px, py);
  for (float i=0; i<=xscale; i+=0.1) {
    x = (float)i/xscale;
    y = 1 - function (x, param_a, param_b, param_c, param_d, param_n);
    px = xoffset + (xscale * x);
    py = yoffset + (yscale * y);
    //line (qx, qy, px, py);
    vertex(px, py);
    qx = px;
    qy = py;
  }
  endShape();

  //---------------------------
  // draw the function's gray levels
  py = yoffset-(bandTh+margin1);
  qy = yoffset-margin1;
  beginShape(QUAD_STRIP);
  for (float j=0; j<=xscale; j++) {
    float j1 = j; 
    float x1 = j1/(float)xscale;
    float y1 = function (1-x1, param_a, param_b, param_c, param_d, param_n);
    float g1 = 255.0 * y1;
    float px1 = xoffset + xscale - j1;

    noStroke();
    fill(g1, g1, g1);
    vertex(px1, py); 
    vertex(px1, qy);
  }
  endShape();
  noFill();
  stroke(128);
  rect(xoffset, yoffset-(bandTh+margin1), xscale, bandTh);

  endRecord();
  strokeWeight (1); 
  doSavePDF=false;
}



//-----------------------------------------------------
void draw() {

  updateParameters(); 

  if (doSavePDF) {
    drawPDF();
    doSavePDF = false;
  }  
  else {

    background (255);

    //---------------------------
    // Draw the animating probe
    if (bDrawProbe) {
      drawAnimatingProbe();
    }
    //---------------------------
    // Draw the animating circle 
    if (bDrawAnimatingRadiusCircle) {
      drawAnimatingRadiusCircle();
    }
    //---------------------------
    // Extra mode-specific graphics for Bezier, etc.
    if (bDrawModeSpecificGraphics) {
      drawModeSpecificGraphics();
    }
    //---------------------------
    // Draw the function's curve
    drawMainFunctionCurve();

    //---------------------------
    // Draw the function's gray levels
    if (bDrawGrayScale) {
      drawGrayLevels();
    }
    //---------------------------
    // Draw a noise signal, and a filtered version.
    if (bDrawNoiseHistories) {
      drawNoiseHistories();
    }
    //---------------------------
    // Draw labels
    drawLabels();
  }
}

//-----------------------------------------------------
void updateParameters() {

  float acf = animationConstant;
  probe_x = abs(millis()%(2*(int)acf) - acf)/acf;

  if (mousePressed && bClickedInGraph) {
    if (visited) {
      if (whichButton == 1) {
        // Use the left mouse button for parameters a & b
        param_a =   (float)(mouseX - xoffset)/xscale;
        param_b = 1-(float)(mouseY - yoffset)/yscale;
        param_a = constrain(param_a, 0, 1); 
        param_b = constrain(param_b, 0, 1);
      } 
      else if (whichButton == 2) {
        // Use the left mouse button for parameters c & d
        param_c =   (float)(mouseX - xoffset)/xscale;
        param_d = 1-(float)(mouseY - yoffset)/yscale;
        param_c = constrain(param_c, 0, 1); 
        param_d = constrain(param_d, 0, 1);
      }
    }
  }
}


//-----------------------------------------------------
void drawMainFunctionCurve() {
  float x, y;
  float px, py;
  float qx, qy;

  noFill(); 
  stroke(boundingBoxStrokeColor);
  rect(xoffset, yoffset, xscale, yscale);

  x = 0;
  y = 1 - function (x, param_a, param_b, param_c, param_d, param_n);
  qx = xoffset + xscale * x;
  qy = yoffset + yscale * y;
  px = qx;
  py = qy;

  for (int i=0; i<=xscale; i++) {
    x = (float)i/xscale;
    y = 1 - function (x, param_a, param_b, param_c, param_d, param_n);

    stroke(0);
    if ((y < 0) || (y > 1)) {
      stroke(boundingBoxStrokeColor);
    } 

    px = xoffset + round(xscale * x);
    py = yoffset + round(yscale * y);
    line (qx, qy, px, py);
    qx = px;
    qy = py;
  }
}


//-----------------------------------------------------
void drawAnimatingProbe() {

  // inspired by @marcinignac & @soulwire 
  // from http://codepen.io/vorg/full/Aqyre 

    float x = constrain (probe_x, 0, 1);
  float y = probe_y = 1 - function (x, param_a, param_b, param_c, param_d, param_n);
  float px = xoffset + round(xscale * x);
  float py = yoffset + round(yscale * y);
  float qy = yoffset + yscale;

  // draw bounding box
  noFill();
  stroke(boundingBoxStrokeColor);
  rect(margin0, yoffset, bandTh, yscale);

  // draw probe element
  stroke(255, 128, 128);
  line (px, qy, px, py);
  stroke(128, 128, 255);
  line (px, py, xoffset, py);
  fill(0);
  noStroke();
  ellipseMode (CENTER);
  ellipse(margin0+bandTh/2.0, py, 11, 11);
}


//-----------------------------------------------------
void drawAnimatingRadiusCircle() {
  // Draw a circle whose radius is linked to the function value. 
  // Inspired by @marcinignac & @soulwire: http://codepen.io/vorg/full/Aqyre   

    float blooperCx = margin0+bandTh/2.0;
  float blooperCy = margin0+bandTh/2.0;
  float val = function (probe_x, param_a, param_b, param_c, param_d, param_n);
  float blooperR = bandTh * val;

  smooth(); 
  float grayBg = map(val, 0, 1, 220, 255);
  fill (grayBg); 
  ellipse (blooperCx, blooperCy, bandTh, bandTh);

  noStroke();
  fill (160);
  float grayFg = map(val, 0, 1, 127, 160);
  fill (grayFg);
  ellipse (blooperCx, blooperCy, blooperR, blooperR);
}

//-----------------------------------------------------
void drawGrayLevels() {

  smooth();
  for (int j=0; j<=xscale; j++) {
    float x = (float)j / (float)xscale;
    float y = function (1.0-x, param_a, param_b, param_c, param_d, param_n);
    float g = 255.0 * y;

    float py = yoffset-(bandTh+margin1);
    float qy = yoffset-margin1;
    float px = xoffset + xscale - j;

    stroke(g, g, g);
    line (px, py, px, qy);
  }

  // draw the bounding box
  noFill();
  stroke(boundingBoxStrokeColor);
  rect(xoffset, yoffset-(bandTh+margin1), xscale, bandTh);
}


//===========================================================
class DataHistoryGraph {
  float rawHistory[];
  int nData;

  //-------------------------
  DataHistoryGraph (int len) {
    nData = len;
    rawHistory      = new float[nData];
    for (int i=0; i<nData; i++) {
      rawHistory[i] = 0.5;
    }
  }

  //-------------------------
  void update (float newVal) {
    // update noise history
    for (int i=0; i<(nData-1); i++) {
      rawHistory[i] = rawHistory[i+1];
    }
    rawHistory[nData-1] = newVal;
  }

  //-------------------------
  void draw (float xoffset, float nhy) {

    // draw bounding rectangles
    noFill(); 
    stroke(boundingBoxStrokeColor);
    rect (xoffset, nhy, xscale, bandTh);

    // draw raw noise history
    noFill(); 
    stroke(180); 
    beginShape(); 
    for (int i=0; i<nData; i++) {
      float x = xoffset + i;
      float valRaw = 1.0 - constrain(rawHistory[i], 0, 1);
      float y = nhy + bandTh * valRaw;
      vertex(x, y);
    }
    endShape(); 

    // draw filtered noise history
    noFill(); 
    stroke(0); 
    beginShape(); 
    for (int i=0; i<nData; i++) {
      float x = xoffset + i;
      float valRaw = rawHistory[i];
      float valFiltered = 1.0 - function (valRaw, param_a, param_b, param_c, param_d, param_n);
      valFiltered = constrain(valFiltered, 0, 1); 
      float y = nhy + bandTh * valFiltered;
      vertex(x, y);
    }
    endShape();
  }
}


//-----------------------------------------------------
void initHistories() {

  noiseHistory = new DataHistoryGraph ((int)xscale);
  cosHistory   = new DataHistoryGraph ((int)xscale);
  triHistory   = new DataHistoryGraph ((int)xscale);
}


//-----------------------------------------------------
void drawNoiseHistories() {

  // update with the latest incoming values
  int nData = (int)xscale;
  float noiseVal = noise(millis()/ (nData/2.0));
  float cosVal   = 0.5 + (0.45 * cos(PI * millis()/animationConstant));
  
  float ac = animationConstant;
  
  float tv = (((int)(millis()/ac))%2 == 0) ? (millis()%ac) : (ac - (millis()%ac));
  float triVal = 1.0 - tv/ac;
  
  
  noiseHistory.update( noiseVal ); 
  cosHistory.update  ( cosVal );  
  triHistory.update  ( triVal ); 

  float nhy = margin0 + bandTh + margin1 + yscale + margin2;
  
  noiseHistory.draw ( xoffset, nhy); 
  nhy += (bandTh + margin1); 
  cosHistory.draw   ( xoffset, nhy);
  nhy += (bandTh + margin1); 
  triHistory.draw   ( xoffset, nhy);
}



//-----------------------
void drawLabels() {

  int nCurrentFunctionArgs = getCurrentFunctionNArgs() - 1; // we subtract 1, for x itself
  boolean bHasFinalIntArg = doesCurrentFunctionHaveFinalIntegerArgument(); 

  float grayEnable = 64;
  float grayDisable = 192;
  float textLineHeight = 13; 
  float yBase = 15; 

  float params[] = {
    param_a, param_b, param_c, param_d
  }; 

  //------------------
  fill(grayEnable);
  text(functionName, xoffset, yoffset+yscale+yBase);
  text("Press L/R arrow keys to switch functions.", 10, height-10); 
  int lastArgIndex = (bHasFinalIntArg) ? (nCurrentFunctionArgs-1) : nCurrentFunctionArgs; 

  float yPos; 
  for (int i=0; i<MAX_N_FLOAT_PARAMS; i++) {
    char argName = (char)('a'+i);
    yPos = yoffset+yscale+ yBase+((i+1)*textLineHeight);

    if (i<lastArgIndex) {
      fill (grayEnable);
      text(argName + ": " + nf(params[i], 1, 3), xoffset, yPos);
    } 
    else {
      fill (grayDisable);
      text(argName + ": -----", xoffset, yPos);
    }
  }

  //------------------
  yPos = yoffset+yscale+ yBase + ((MAX_N_FLOAT_PARAMS+1)*textLineHeight);
  if (bHasFinalIntArg) {
    fill (grayEnable);
    text("n: " + param_n, xoffset, yPos);
  } 
  else {
    fill (grayDisable);
    text("n: -----", xoffset, yPos);
  }
}

//-----------------------------------------------------
void drawModeSpecificGraphics() {

  int whichFunction = FUNCTIONMODE%nFunctionMethods;  
  Method whichMethod = functionMethodArraylist.get(whichFunction); 
  String methodName = whichMethod.getName(); 

  Type[] params = whichMethod.getGenericParameterTypes();
  int nParams = params.length;

  // determine if the current function has an integer argument.
  String lastParamString = params[nParams-1].toString();
  boolean bHasIntegerArgument = (lastParamString.equals("int"));

  float x,  y;
  float xa, yb;
  float xc, yd;
  float K = 12;
  float cr = 7;

  noFill();
  stroke(180, 180, 255);

  switch (nParams) {
  case 2:
    if ( methodName.equals("function_AdjustableFwhmHalfGaussian") ||
        methodName.equals("function_AdjustableSigmaHalfGaussian")) {
      x = xoffset + param_a * xscale;
      float val = 1.0 - function (param_a, param_a, param_b, param_c, param_d, param_n);
      y = yoffset + yscale * val; 
      line (x, yoffset+yscale, x, y); 
      line (xoffset, y, x, y);
    }
    break;

  case 3:
    if (bHasIntegerArgument == false) {
      // through a point
      x = xoffset + param_a * xscale;
      y = yoffset + (1-param_b) * yscale;

      if (methodName.equals("function_QuadraticBezier")) {
        line (xoffset, yoffset + yscale, x, y);
        line (xoffset + xscale, yoffset, x, y);
      }

      line(x-K, y, x+K, y); 
      line(x, y-K, x, y+K);
      fill (255, 255, 255); 
      ellipse(x, y, cr, cr);
    } 
    else {
      
    }
    break;

  case 4:
    if (methodName.equals("function_CircularFillet")) {
      x = xoffset + arcCenterX * xscale;
      y = yoffset + (1-arcCenterY) * yscale;
      float d = 2.0 * arcRadius * xscale;
      ellipseMode(CENTER);
      ellipse(x, y, d, d);

      x = xoffset + param_a * xscale;
      y = yoffset + (1-param_b) * yscale;
      line(x-K, y, x+K, y); 
      line(x, y-K, x, y+K);
      fill (255, 255, 255); 
      ellipse(x, y, cr, cr);
    } 
    else {
      x = xoffset + param_a * xscale;
      y = yoffset + (1-param_b) * yscale;
      line(x-K, y, x+K, y); 
      line(x, y-K, x, y+K);
      fill (255, 255, 255); 
      ellipse(x, y, cr, cr);
    }
    break;

  case 5: // (including x itself)
    if (bHasIntegerArgument == false) {
      // two crosses
      xa = xoffset + param_a * xscale;
      yb = yoffset + (1-param_b) * yscale;
      xc = xoffset + param_c * xscale;
      yd = yoffset + (1-param_d) * yscale;
      line(xa-K, yb, xa+K, yb); 
      line(xa, yb-K, xa, yb+K); 
      line(xc-K, yd, xc+K, yd); 
      line(xc, yd-K, xc, yd+K);

      if ((methodName.equals("function_CubicBezier")) || 
          (methodName.equals("function_DoubleQuadraticBezier"))) {
        line (xoffset, yoffset + yscale, xa, yb);
        line (xc, yd, xa, yb);
        line (xoffset + xscale, yoffset, xc, yd);
      }
      

      fill (255, 255, 255); 
      ellipse(xa, yb, cr, cr); 
      ellipse(xc, yd, cr, cr);
    }
    break;
  }

}


//===============================================================
int getCurrentFunctionNArgs() {
  int whichFunction = FUNCTIONMODE % nFunctionMethods;  
  Method whichMethod = functionMethodArraylist.get(whichFunction); 
  Type[] params = whichMethod.getGenericParameterTypes();
  int nParams = params.length;
  return nParams;
}

//===============================================================
boolean doesCurrentFunctionHaveFinalIntegerArgument() {
  // determine if the current function has a (final) integer argument.

  int whichFunction = FUNCTIONMODE % nFunctionMethods;  
  Method whichMethod = functionMethodArraylist.get(whichFunction); 
  Type[] params = whichMethod.getGenericParameterTypes();
  int nParams = params.length;

  boolean bHasFinalIntegerArgument = false;
  for (int p=0; p<nParams; p++) {
    String paramString = params[p].toString();
    if (paramString.equals("int")) {
      bHasFinalIntegerArgument = true;
    }
  }
  return bHasFinalIntegerArgument;
}

//===============================================================
float function (float x, float a, float b, float c, float d, int n) {
  float out = 0; 
  nFunctionMethods = functionMethodArraylist.size(); 
  if (nFunctionMethods > 0) {
    int whichFunction = FUNCTIONMODE%nFunctionMethods;  
    Method whichMethod = functionMethodArraylist.get(whichFunction); 

    int nParams = getCurrentFunctionNArgs(); 
    boolean bHasFinalIntegerArgument = doesCurrentFunctionHaveFinalIntegerArgument();

    // Invoke() the current shaping function, 
    // with the correct number and type(s) of arguments. 
    // Note: we don't have any 1-argument functions with an integer arg.
    // Note: we don't have any 6-argument functions without an integer arg.
    try {
      Float F = 0.0;

      if (bHasFinalIntegerArgument) {
        switch(nParams) {
        case 2: 
          F = (Float) whichMethod.invoke(this, x, n);
          break;

        case 3: 
          F = (Float) whichMethod.invoke(this, x, a, n);
          break;

        case 4: 
          F = (Float) whichMethod.invoke(this, x, a, b, n);
          break;

        case 5: 
          F = (Float) whichMethod.invoke(this, x, a, b, c, n);
          break;

        case 6: 
          F = (Float) whichMethod.invoke(this, x, a, b, c, d, n);
          break;
        }
      }

      else if (bHasFinalIntegerArgument == false) {
        switch(nParams) {
        case 1: 
          F = (Float) whichMethod.invoke(this, x); 
          break;

        case 2: 
          F = (Float) whichMethod.invoke(this, x, a);
          break;

        case 3: 
          F = (Float) whichMethod.invoke(this, x, a, b);
          break;

        case 4: 
          F = (Float) whichMethod.invoke(this, x, a, b, c);
          break;

        case 5: 
          F = (Float) whichMethod.invoke(this, x, a, b, c, d);
          break;
        }
      }
      out = F.floatValue();
    } 

    catch (Exception e) {
      // Print out what went wrong.
      println("Problem calling method: " + whichMethod.getName());
      println(e +  ": " + e.getMessage() );
      e.printStackTrace(); 
      Throwable cause = e.getCause();
      println (cause.getMessage());
    }
  }

  return out;
}




/////////////////////////////////////////////////////////////////////////
//
// Notes for introspection 
// Documentation here: 
// http://docs.oracle.com/javase/1.5.0/docs/api/java/lang/Object.html
// http://docs.oracle.com/javase/1.5.0/docs/api/java/lang/reflect/Method.html
// http://docs.oracle.com/javase/1.5.0/docs/api/java/lang/Class.html
//
// Be sure to import the following: 
// import java.lang.*;
// import java.lang.reflect.Method;
// import java.lang.reflect.Type;
//
// Other notes:
// Method.invoke(..) // allows calling of a function!
// String rts = m.getReturnType().toString(); // assumed to be float, for us.

ArrayList<Method> functionMethodArraylist; 
int nFunctionMethods;

void introspect() {
  // Examine the current class, extract the names of the functions,  
  // then compile an ArrayList containing all the shaper functions. 
  functionMethodArraylist = new ArrayList<Method>();
  nFunctionMethods = 0; 

  try {
    // This fetches the class name for the current (PApplet) class, 
    // which happens to contain all of the functions. For Processing, if the functions
    // were instead inside an inner class (say, "FunctionManager", we would  
    // add the following to the fullClassName: // + "$" + "FunctionManager";
    String fullClassName = this.getClass().getName(); 
    Class myClassName = Class.forName(fullClassName);

    int funcCount = 0; 
    Method[] methods = myClassName.getMethods();

    if (methods.length>0) {
      // count (specifically) the shaper functions.
      // copy into local arraylist data structure
      for (int i=0; i<methods.length; i++) {
        Method m = methods[i];
        String methodName = m.getName(); 
        if (methodName.startsWith ("function_")) { 
          println ('"' + methodName + '"'); 
          funcCount++;
          functionMethodArraylist.add(m);
        }
      }
      nFunctionMethods = functionMethodArraylist.size(); 
      println("nFunctionMethods = " + nFunctionMethods);
    }
  }
  catch (Exception e) {
    println (e);
  }
}

