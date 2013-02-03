// Double-Elliptic Seat and Double-Circular Seat

//------------------------------------------------------------------
float function_DoubleEllipticSeat (float x, float a, float b){
  functionName = "Double-Elliptic Seat";

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
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
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;

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






