
// Double-(Odd) Polynomial Seat
//------------------------------------------------------------------
float function_DoubleOddPolynomialSeat (float x, float a, float b, int n){
  functionName = "Double-Odd-Polynomial Seat";
  useParameterA = true;
  useParameterB = true;
  useParameterC = false;
  useParameterD = false;
  useParameterN = true;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;

  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 
  int p = 2*n + 1;
  float y = 0;
  if (x <= a){
    y = b - b*pow(1-x/a, p);
  } 
  else {
    y = b + (1-b)*pow((x-a)/(1-a), p);
  }
  return y;
}











