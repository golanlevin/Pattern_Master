// Exponential shapers

float function_ExponentialEmphasis (float x, float a) {
  functionName = "Exponential Emphasis";

  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a); 

  if (a < 0.5) {
    // emphasis
    a = 2*(a);
    float y = pow(x, a);
    return y;
  } 
  else {
    // de-emphasis
    a = 2*(a-0.5);
    float y = pow(x, 1.0/(1-a));
    return y;
  }
}

//------------------------------------------------------------------
float function_IterativeSquareRoot (float x) {
  // http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
  // Ancient Babylonian technology
  functionName = "Iterative (Heron's) Square Root";
  float y = 0.5; 
  int n = 6;
  for (int i=0; i<n; i++) {
    y = (y + x/y)/2.0;
  }
  return y;
}

//------------------------------------------------------------------
float function_FastSquareRoot(float x) {
  // http://en.wikipedia.org/wiki/Fast_inverse_square_root
  // http://stackoverflow.com/questions/11513344/how-to-implement-the-fast-inverse-square-root-in-java
  functionName = "FastSquareRoot";
  
  float xhalf = 0.5f * x;
  int i = Float.floatToIntBits(x);
  i = 0x5f3759df - (i>>1);
  x = Float.intBitsToFloat(i);
  x = x*(1.5f - xhalf*x*x);
  return 1.0/x;
}

