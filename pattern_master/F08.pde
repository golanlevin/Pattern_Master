// Simplified Double-Cubic Seat

//------------------------------------------------------------------
float function_DoubleCubicOgeeSimplified (float x, float a, float b){
  functionName = "Simplified Double-Cubic Ogee";
  b = 1 - b; //reverse, for intelligibility.
  
  float y = 0;
  if (x<=a){
    if (a <= 0){
      y = 0; 
    } else {
      float val = 1 - x/a;
      y = b*x + (1-b)*a*(1.0- val*val*val);
    }
  } 
  else {
    if (a >= 1){
      y = 1;
    } else {
      float val = (x-a)/(1-a);
      y = b*x + (1-b)*(a + (1-a)* val*val*val);
    }
  }

  return y;
}
