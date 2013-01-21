// Exponential shapers

float function_ExponentialEmphasis (float x, float a){
  functionName = "Exponential Emphasis";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = constrain(a, min_param_a, max_param_a); 
  
  if (a < 0.5){
    // emphasis
    a = 2*(a);
    float y = pow(x, a);
    return y;
  } else {
    // de-emphasis
    a = 2*(a-0.5);
    float y = pow(x, 1.0/(1-a));
    return y;
  }
  
}
