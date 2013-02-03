// Double-Circle sigmoid

//------------------------------------------------------------------
float function_DoubleCircleSigmoid (float x, float a) {
  functionName = "Double-Circular Sigmoid";
  
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  a = constrain(a, min_param_a, max_param_a); 
  
  float y = 0;
  if (x<=a) {
    y = a - sqrt(a*a - x*x);
  } 
  else {
    y = a + sqrt(sq(1.0-a) - sq(x-1.0));
  }
  return y;
}


//------------------------------------------------------------------
float function_CircularEaseIn (float x) {
  functionName = "Circular Ease In";

  float y = 1.0 - sqrt(1.0 - x*x);
  return y;
}

//------------------------------------------------------------------
float function_CircularEaseOut (float x) {
  functionName = "Circular Ease Out";

  float y = sqrt(1.0 - sq(1.0 - x));
  return y;
}


//------------------------------------------------------------------
float function_CircularEaseInOut (float x) {
  functionName = "Penner's Circular Ease InOut";

  float y = 0; 
  x *= 2.0; 
  
  if (x < 1) {
    y =  -0.5 * (sqrt(1.0 - x*x) - 1.0);
  } else {
    x -= 2.0;
    y =   0.5 * (sqrt(1.0 - x*x) + 1.0);
  }
  
  return y;
}




