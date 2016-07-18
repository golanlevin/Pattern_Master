// Double-Elliptic Sigmoid

//------------------------------------------------------------------
float function_DoubleEllipticSigmoid (float x, float a, float b){
  functionName = "Double-Elliptic Sigmoid";

  float y = 0;
  if (x<=a){
    if (a <= 0){
      y = 0;
    } else {
      y = b * (1.0 - (sqrt(sq(a) - sq(x))/a));
    }
  } 
  else {
    if (a >= 1){
      y = 1.0;
    } else {
      y = b + ((1.0-b)/(1.0-a))*sqrt(sq(1.0-a) - sq(x-1.0));
    }
  }
  return y;
}
