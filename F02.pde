// Double-Linear Interpolator

//------------------------------------------------------------------
float function_DoubleLinear (float x, float a, float b){
  functionName = "Double-Linear";
  
  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 
  
  float y = 0;
  if (x<=a){
    y = (b/a) * x;
  } 
  else {
    y = b + ((1-b)/(1-a))*(x-a);
  }
  return y;
}


//------------------------------------------------------------------
// Generalized map
float function_TripleLinear (float x, float a, float b, float c, float d) {
  functionName = "Triple Linear";

  float y = 0;
  if (a < c) {
    if (x <= a) {
      y = map(x, 0,a, 0,b);
    } 
    else if (x >= c) {
      y = map(x, c,1, d,1);
    } 
    else {
      y = map(x, a, c, b, d);
    }
  } 
  else {
    if (x <= c) {
      y = map(x, 0,c, 0,d);
    } 
    else if (x >= a) {
      y = map(x, a,1, b,1);
    } 
    else {
      y = map(x, c, a, d, b);
    }
  }
  return y;
}

//------------------------------------------------------------------
float function_VariableStaircase (float x, float a, int n){
  functionName = "Variable Staircase";
  
  float aa = (a - 0.5);
  if (aa == 0){
    return x; 
  }
  
  float x0 = (floor (x*n))/ (float) n; 
  float x1 = (ceil  (x*n))/ (float) n;
  float y0 = x0; 
  float y1 = x1; 
  
  float px = 0.5*(x0+x1) + aa/n;
  float py = 0.5*(x0+x1) - aa/n;
  
  float y = 0;
  if ((x < px) && (x > x0)){
    y = map(x, x0,px, y0,py);
  } else {
    y = map(x, px,x1, py,y1);
  }
  
  return y;
}



