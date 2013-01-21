// Double-Linear Interpolator

//------------------------------------------------------------------
float function_DoubleLinear (float x, float a, float b){
  functionName = "Double-Linear";
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
  
  float y = 0;
  if (x<=a){
    y = (b/a) * x;
  } 
  else {
    y = b + ((1-b)/(1-a))*(x-a);
  }
  return y;
}



