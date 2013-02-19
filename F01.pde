

// Generalized map
float function_GeneralizedLinearMap (float x, float a, float b, float c, float d) {
  functionName = "Generalized Linear Map";
  
  float y = 0;
  if (a < c) {
    if (x <= a) {
      y = b;
    } 
    else if (x >= c) {
      y = d;
    } 
    else {
      y = map(x, a, c, b, d);
    }
  } 
  else {
    if (x <= c) {
      y = d;
    } 
    else if (x >= a) {
      y = b;
    } 
    else {
      y = map(x, c, a, d, b);
    }
  }
  return y;
}





// Double-(Odd) Polynomial Seat
//------------------------------------------------------------------
float function_DoubleOddPolynomialOgee (float x, float a, float b, int n) {
  functionName = "Double Odd-Polynomial Ogee";

  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  float min_param_b = 0.0;
  float max_param_b = 1.0;

  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 
  int p = 2*n + 1;
  float y = 0;
  if (x <= a) {
    y = b - b*pow(1-x/a, p);
  } 
  else {
    y = b + (1-b)*pow((x-a)/(1-a), p);
  }
  return y;
}










