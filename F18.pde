// Modified (Normalized) Logistic Sigmoid 

float function_SigmoidLogitCombo (float x, float a){
  
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;
  
  float y = 0; 
  if (a < 0.5){
    y = function_NormalizedLogit (x, 1.0-(2.0*a));
  } else {
    y = function_NormalizedLogisticSigmoid (x, (2.0*(a-0.5)));
  }
  functionName = "Sigmoid-Logit Combination";
  return y;
}

//------------------------------------------------------------------
float function_NormalizedLogisticSigmoid (float x, float a) {
  functionName = "Normalized Logistic Sigmoid";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float epsilon = 0.0001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float emph = 5.0;

  a = constrain(a, min_param_a, max_param_a);
  a = (1/(1-a) - 1); 
  a = emph * a;

  float y    = 1.0 / (1.0 + exp(0 - (x-0.5)*a    ));
  float miny = 1.0 / (1.0 + exp(  0.5*a    ));
  float maxy = 1.0 / (1.0 + exp( -0.5*a    ));
  y = map(y, miny, maxy, 0, 1); 
  return y;
}


//------------------------------------------------------------------
float function_NormalizedLogit (float x, float a) {
  // http://en.wikipedia.org/wiki/Logit
  functionName = "Normalized Logit Function";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float epsilon = 0.0001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float emph = 5.0;

  a = constrain(a, min_param_a, max_param_a); 
  a = (1/(1-a) - 1); 
  a = emph * a;

  float minx = 1.0 / (1.0 + exp(  0.5*a    ));
  float maxx = 1.0 / (1.0 + exp( -0.5*a    ));
  x = map(x, 0,1, minx, maxx);

  float y = log ( x / (1.0 - x)) ;
  y *= 1.0/a; 
  y += 0.5;

  y = constrain (y, 0, 1); 
  return y;
}

