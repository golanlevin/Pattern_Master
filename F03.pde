// Symmetric Double-Element Sigmoids

//------------------------------------------------------------------
float function_DoubleExponentialSigmoid (float x, float a){
  functionName = "Double-Exponential Sigmoid";
  
  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a); 
  a = 1-a;
  
  float y = 0;
  if (x<=0.5){
    y = (pow(2.0*x, 1.0/a))/2.0;
  } 
  else {
    y = 1.0 - (pow(2.0*(1.0-x), 1.0/a))/2.0;
  }
  return y;
}

//------------------------------------------------------------------
float function_DoubleQuadraticSigmoid (float x){
  functionName = "Double-Quadratic Sigmoid";

  float y = 0;
  if (x<=0.5){
    y = sq(2.0*x)/2.0;
  } 
  else {
    y = 1.0 - sq(2.0*(x-1.0))/2.0;
  }
  return y;
}


//------------------------------------------------------------------
float function_DoublePolynomialSigmoid (float x, int n){
  functionName = "Double-Polynomial Sigmoid";

  float y = 0;
  if (n%2 == 0){ 
    // even polynomial
    if (x<=0.5){
      y = pow(2.0*x, n)/2.0;
    } 
    else {
      y = 1.0 - pow(2*(x-1.0), n)/2.0;
    }
  } 
  
  else { 
    // odd polynomial
    if (x<=0.5){
      y = pow(2.0*x, n)/2.0;
    } 
    else {
      y = 1.0 + pow(2.0*(x-1.0), n)/2.0;
    }

  }

  return y;
}




