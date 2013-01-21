// Simplified Double-Cubic Seat

//------------------------------------------------------------------
float function_DoubleCubicSeatSimplified (float x, float a, float b){
  functionName = "Simplified Double-Cubic Seat";
  useParameterA = true;
  useParameterB = true;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;

  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 
  b = 1 - b; //massage for intelligibility.
  
  float y = 0;
  if (x<=a){
    y = b*x + (1-b)*a*(1-pow(1-x/a, 3));
  } 
  else {
    y = b*x + (1-b)*(a + (1-a)*pow((x-a)/(1-a), 3));
  }

  return y;
}
