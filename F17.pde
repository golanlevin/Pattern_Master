//------------------------------------------------------------------
float function_DoubleCircularOgee (float x, float a){
  functionName = "Double-Circular Ogee";
  
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  
  a = constrain(a, min_param_a, max_param_a); 
  float y = 0;
  if (x<=a){
    y = sqrt(sq(a) - sq(x-a));
  } 
  else {
    y = 1 - sqrt(sq(1-a) - sq(x-a));
  }
  return y;
}


float function_DoubleSquircularOgee (float x, float a, int n){
  // http://en.wikipedia.org/wiki/Squircle
  functionName = "Double-Squircular Ogee";
  
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  a = constrain(a, min_param_a, max_param_a); 
  float pown = 2.0 * n; 
  
  float y = 0;
  if (x<=a){
    y = pow( pow(a,pown) - pow(x-a, pown), 1.0/pown);
  } 
  else {
    y = 1.0 - pow( pow(1-a,pown) - pow(x-a, pown), 1.0/pown);
  }
  return y;
}
