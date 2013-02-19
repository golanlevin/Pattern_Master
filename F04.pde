//------------------------------------------------------------------
float function_DoubleEllipticOgee (float x, float a, float b){
  functionName = "Double-Elliptic Ogee";

  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a); 
  float y = 0;

  if (x<=a){
    y = (b/a) * sqrt(sq(a) - sq(x-a));
  } 
  else {
    y = 1.0 - ((1.0-b)/(1.0-a))*sqrt(sq(1.0-a) - sq(x-a));
  }
  return y;
}

//------------------------------------------------------------------
float function_AdjustableCenterEllipticWindow (float x, float a){
  functionName = "Adjustable-Center Elliptic Window";
  
  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a);
  
  float y = 0;

  if (x<=a){
    y = (1.0/a) * sqrt(sq(a) - sq(x-a));
  } 
  else {
    y = (1.0/(1-a)) * sqrt(sq(1.0-a) - sq(x-a));
  }
  return y;
}


//------------------------------------------------------------------
float function_AdjustableCenterHyperellipticWindow (float x, float a, int n){
  functionName = "Adjustable-Center Hyperelliptic Window";
  
  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a);
  
  float y = 0;
  float pwn = n * 2.0; 

  if (x<=a){
    y = (1.0/a) * pow( pow(a, pwn)     - pow(x-a, pwn), 1.0/pwn);
  } 
  else {
    y =  ((1.0/ (1-a)))  * pow( pow(1.0-a, pwn) - pow(x-a, pwn), 1.0/pwn);
  }
  return y;
}

//------------------------------------------------------------------
float function_AdjustableCenterSquircularWindow (float x, float a, int n){
  functionName = "Adjustable-Center Squircular Window";
  
  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a);
  
  float y = 0;
  float pwn = max(2, n * 2.0); 

  if (x<=a){
    y = (1-a) + pow( pow(a, pwn) - pow(x-a, pwn), 1.0/pwn);
  } 
  else {
    y = a + pow( pow(1.0-a, pwn) - pow(x-a, pwn), 1.0/pwn);
  }
  return y;
}






