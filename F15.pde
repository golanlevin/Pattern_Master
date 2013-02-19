// Parabola (Quadratic) Through a Point
//------------------------------------------------------------------
float function_ParabolaThroughAPoint (float x, float a, float b){
  functionName = "Quadratic Through a Given Point";
  
  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 
  
  float A = (1-b)/(1-a) - (b/a);
  float B = (A*(a*a)-b)/a;
  float y = A*(x*x) - B*(x);
  y = constrain(y, 0,1); 
  
  return y;
}



