// Double-Linear Interpolator

//------------------------------------------------------------------
float function_DoubleLinear (float x, float a, float b) {
  functionName = "Double-Linear";

  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = constrain(a, min_param_a, max_param_a); 
  b = constrain(b, min_param_b, max_param_b); 

  float y = 0;
  if (x<=a) {
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
      y = map(x, 0, a, 0, b);
    } 
    else if (x >= c) {
      y = map(x, c, 1, d, 1);
    } 
    else {
      y = map(x, a, c, b, d);
    }
  } 
  else {
    if (x <= c) {
      y = map(x, 0, c, 0, d);
    } 
    else if (x >= a) {
      y = map(x, a, 1, b, 1);
    } 
    else {
      y = map(x, c, a, d, b);
    }
  }
  return y;
}

//------------------------------------------------------------------
float function_VariableStaircase (float x, float a, int n) {
  functionName = "Variable Staircase";

  float aa = (a - 0.5);
  if (aa == 0) {
    return x;
  }

  float x0 = (floor (x*n))/ (float) n; 
  float x1 = (ceil  (x*n))/ (float) n;
  float y0 = x0; 
  float y1 = x1; 

  float px = 0.5*(x0+x1) + aa/n;
  float py = 0.5*(x0+x1) - aa/n;

  float y = 0;
  if ((x < px) && (x > x0)) {
    y = map(x, x0, px, y0, py);
  } 
  else {
    y = map(x, px, x1, py, y1);
  }

  return y;
}


//------------------------------------------------------------------
float function_QuadraticBezierStaircase (float x, float a, int n) {
  functionName = "Quadratic Bezier Staircase";

  float aa = (a - 0.5);
  if (aa == 0) {
    return x;
  }

  float x0 = (floor (x*n))/ (float) n; 
  float x1 = (ceil  (x*n))/ (float) n;
  float y0 = x0; 
  float y1 = x1; 

  float px = 0.5*(x0+x1) + aa/n;
  float py = 0.5*(x0+x1) - aa/n;

  float p0x = (x0 + px)/2.0;
  float p0y = (y0 + py)/2.0;
  float p1x = (x1 + px)/2.0;
  float p1y = (y1 + py)/2.0;
  

  float y = 0;
  float denom = (1.0/n)*0.5;
  
  if ((x <= p0x) && (x >= x0)) {
    // left side
    if (floor (x*n) <= 0){
      y = map(x, x0, px, y0, py);
    } else {
      
      if (abs(x - x0) < EPSILON){
        // problem when x == x0 !
      }
      
      float za = (x0  - (p1x - 1.0/n))/denom; 
      float zb = (y0  - (p1y - 1.0/n))/denom; 
      float zx = ( x  - (p1x - 1.0/n))/denom; 
      float om2a = 1.0 - 2.0*za;
      
      float interior = max (0, za*za + om2a*zx);
      float t = (sqrt(interior) - za)/om2a;
      float zy = (1.0-2.0*zb)*(t*t) + (2*zb)*t;
      zy *= (p1y - p0y);
      zy += p1y; //(p1y - 1.0/n);
      if (x > x0){
        zy -= 1.0/n;
      }
      y = zy;
    }
  } 

  else if ((x >= p1x) && (x <= x1)) {
    // right side
    if (ceil  (x*n) >= n) {
      y = map(x, px, x1, py, y1);
    } 
    else {
      if (abs(x - x1) < EPSILON){
        // problem when x == x1 !
      }
      
      float za = (x1 - p1x)/denom; 
      float zb = (y1 - p1y)/denom; 
      float zx = ( x - p1x)/denom; 
      if (za == 0.5) {
        za += EPSILON;
      }
      float om2a = 1.0 - 2.0*za;
      if (abs(om2a) < EPSILON) {
        om2a = ((om2a < 0) ? -1:1) * EPSILON;
      }
      
      float interior = max (0, za*za + om2a*zx);
      float t = (sqrt(interior) - za)/om2a;
      float zy = (1.0-2.0*zb)*(t*t) + (2*zb)*t;
      zy *= (p1y - p0y);
      zy += p1y;
      y = zy;
    }
  } 

  else {
    // center
    float za = (px - p0x)/denom; 
    float zb = (py - p0y)/denom; 
    float zx = ( x - p0x)/denom; 
    if (za == 0.5) {
      za += EPSILON;
    }
    float om2a = 1.0 - 2.0*za;
    float t = (sqrt(za*za + om2a*zx) - za)/om2a;
    float zy = (1.0-2.0*zb)*(t*t) + (2*zb)*t;
    zy *= (p1y - p0y);
    zy += p0y;
    y = zy;
  }
  return y;

}

