// Symmetric Double-Exponential Seat

//------------------------------------------------------------------
float function_DoubleExponentialSeat (float x, float a){
  functionName = "Double-Exponential Seat";

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = constrain(a, min_param_a, max_param_a); 

  float y = 0;
  if (x<=0.5){
    y = (pow(2.0*x, 1.0-a))/2.0;
  } 
  else {
    y = 1.0 - (pow(2.0*(1.0-x), 1.0-a))/2.0;
  }
  return y;
}
