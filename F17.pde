// Double-Circle Seat

//------------------------------------------------------------------
float function_DoubleCircleSeat (float x, float a){
  functionName = "Double-Circular Seat";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;
  
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
