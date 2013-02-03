// A Flexible Quartic Equation

//------------------------------------------------------------------
float function_NiftyQuartic (float x, float a, float b) {
  functionName = "Quartic";

  float min_param_a = 0.0;
  float max_param_a = 1.0;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b);

  a = 1.0-a;
  float w = (1-2*a)*(x*x) + (2*a)*x;
  float y = (1-2*b)*(w*w) + (2*b)*w;
  return y;
}


float function_Identity (float x) {
  functionName = "Identity Function";
  return x;
}

float function_Inverse (float x) {
  functionName = "Inverse Function";
  return 1.0-x;
}


