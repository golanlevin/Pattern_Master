
//------------------------------------------------------------------
float function_CubicBezierThrough2Points (float x, float a, float b, float c, float d){
  functionName = "Cubic Bezier (Nearly) Through 2 Points"; 

  float y = 0;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0 + epsilon;
  float max_param_b = 1.0 - epsilon;
  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 

  float x0 = 0;  
  float y0 = 0;
  float x4 = a;  
  float y4 = b;
  float x5 = c;  
  float y5 = d;
  float x3 = 1;  
  float y3 = 1;
  float x1,y1,x2,y2; // to be solved.

  float t1 = 0.3;
  float t2 = 0.7;

  float B0t1 = B0(t1);
  float B1t1 = B1(t1);
  float B2t1 = B2(t1);
  float B3t1 = B3(t1);
  float B0t2 = B0(t2);
  float B1t2 = B1(t2);
  float B2t2 = B2(t2);
  float B3t2 = B3(t2);

  float ccx = x4 - x0*B0t1 - x3*B3t1;
  float ccy = y4 - y0*B0t1 - y3*B3t1;
  float ffx = x5 - x0*B0t2 - x3*B3t2;
  float ffy = y5 - y0*B0t2 - y3*B3t2;

  x2 = (ccx - (ffx*B1t1)/B1t2) / (B2t1 - (B1t1*B2t2)/B1t2);
  y2 = (ccy - (ffy*B1t1)/B1t2) / (B2t1 - (B1t1*B2t2)/B1t2);
  x1 = (ccx - x2*B2t1) / B1t1;
  y1 = (ccy - y2*B2t1) / B1t1;

  x1 = constrain(x1, 0+epsilon,1-epsilon); 
  x2 = constrain(x2, 0+epsilon,1-epsilon); 

  y = function_CubicBezier (x, x1,y1, x2,y2);
  y = constrain(y,0,1); 
  
  functionName = "Cubic Bezier (Nearly) Through 2 Points";  
  return y;

}

//==============================================================
float B0 (float t){
  return (1-t)*(1-t)*(1-t);
}
float B1 (float t){
  return  3*t* (1-t)*(1-t);
}
float B2 (float t){
  return 3*t*t* (1-t);
}
float B3 (float t){
  return t*t*t;
}
float  findx (float t, float x0, float x1, float x2, float x3){
  return x0*B0(t) + x1*B1(t) + x2*B2(t) + x3*B3(t);
}
float  findy (float t, float y0, float y1, float y2, float y3){
  return y0*B0(t) + y1*B1(t) + y2*B2(t) + y3*B3(t);
}


