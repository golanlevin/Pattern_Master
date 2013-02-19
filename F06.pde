//------------------------------------------------------------------
float function_DoubleCircularSigmoid (float x, float a) {
  functionName = "Double-Circular Sigmoid";
  
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
float function_DoubleSquircularSigmoid (float x, float a, int n) {
  functionName = "Double-Squircular Sigmoid";
 
  float pwn = max(2, n * 2.0); 
  float y = 0;
  if (x<=a) {
    y = a - pow( pow(a,pwn) - pow(x,pwn), 1.0/pwn);
  } 
  else {
    y = a + pow(pow(1.0-a, pwn) - pow(x-1.0, pwn), 1.0/pwn);
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




