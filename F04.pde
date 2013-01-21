// Double-Elliptic Seat and Double-Circular Seat

//------------------------------------------------------------------
float function_DoubleEllipticSeat (float x, float a, float b, int n){
  functionName = "Double-Elliptic Seat";
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

  // Double-Elliptic Seat
  if (x<=a){
    y = (b/a) * sqrt(sq(a) - sq(x-a));
  } 
  else {
    y = 1- ((1-b)/(1-a))*sqrt(sq(1-a) - sq(x-a));
  }
  return y;
}



