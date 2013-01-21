// Symmetric Double-Element Sigmoids

//------------------------------------------------------------------
float function_DoubleExponentialSigmoid (float x, float a){
  functionName = "Double-Exponential Sigmoid";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
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
  useParameterA = false;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float y = 0;
  if (x<=0.5){
    y = sq(2.0*x)/2.0;
  } 
  else {
    y = 1.0 - sq(2*(x-1))/2.0;
  }
  return y;
}


//------------------------------------------------------------------
float function_DoublePolynomialSigmoid (float x, float a, float b, int n){
  functionName = "Double-Polynomial Sigmoid";
  useParameterA = false;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = true;
  

  float y = 0;
  if (n%2 == 0){ 
    // even polynomial
    if (x<=0.5){
      y = pow(2.0*x, n)/2.0;
    } 
    else {
      y = 1.0 - pow(2*(x-1), n)/2.0;
    }
  } 
  
  else { 
    // odd polynomial
    if (x<=0.5){
      y = pow(2.0*x, n)/2.0;
    } 
    else {
      y = 1.0 + pow(2.0*(x-1), n)/2.0;
    }

  }

  return y;
}




