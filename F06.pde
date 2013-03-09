//------------------------------------------------------------------
float function_DoubleCircularSigmoid (float x, float a) {
  functionName = "Double-Circular Sigmoid";
  
  float y = 0;
  if (x<=a) {
    y = a - sqrt(a*a - x*x);
  } 
  else {
    y = a + sqrt(sq(1.0-a) - sq(x-1.0));
  }
  return y;
}

//------------------------------------------------------------------
float function_DoubleSquircularSigmoid (float x, float a, int n) {
  functionName = "Double-Squircular Sigmoid";
 
  float pwn = max(2, n * 2.0); 
  float y = 0;
  if (x<=a) {
    y = a - pow( pow(a,pwn) - pow(x,pwn), 1.0/pwn);
  } 
  else {
    y = a + pow(pow(1.0-a, pwn) - pow(x-1.0, pwn), 1.0/pwn);
  }
  return y;
}


//------------------------------------------------------------------
float function_CircularEaseIn (float x) {
  functionName = "Circular Ease In";

  float y = 1.0 - sqrt(1.0 - x*x);
  return y;
}

//------------------------------------------------------------------
float function_CircularEaseOut (float x) {
  functionName = "Circular Ease Out";

  float y = sqrt(1.0 - sq(1.0 - x));
  return y;
}


//------------------------------------------------------------------
float function_CircularEaseInOut (float x) {
  functionName = "Penner's Circular Ease InOut";

  float y = 0; 
  x *= 2.0; 
  
  if (x < 1) {
    y =  -0.5 * (sqrt(1.0 - x*x) - 1.0);
  } else {
    x -= 2.0;
    y =   0.5 * (sqrt(1.0 - x*x) + 1.0);
  }
  
  return y;
}


//------------------------------------------------------------------
float function_DoubleQuadraticBezier (float x, float a, float b, float c, float d) {
  functionName = "Double Quadratic Bezier";
  // also see http://engineeringtraining.tpub.com/14069/css/14069_150.htm
  
  float xmid = (a + c)/2.0; 
  float ymid = (b + d)/2.0; 
  
  float y = 0;
  float om2a;
  float t; 
  float xx; 
  float aa; 
  float bb;

  if (x <= xmid){
    xx = x / xmid;
    aa = a / xmid; 
    bb = b / ymid; 
    om2a = 1.0 - 2.0*aa;
    if (om2a == 0) {
       om2a = EPSILON; 
    }   
    t = (sqrt(aa*aa + om2a*xx) - aa)/om2a;
    y = (1.0-2.0*bb)*(t*t) + (2*bb)*t;
    y *= ymid;
  }
  if (x > xmid){
     xx = (x - xmid)/(1.0-xmid);
     aa = (c - xmid)/(1.0-xmid); 
     bb = (d - ymid)/(1.0-ymid); 
     om2a = 1.0 - 2.0*aa;
     if (om2a == 0) {
       om2a = EPSILON; 
     }     
     t = (sqrt(aa*aa + om2a*xx) - aa)/om2a;
     y = (1.0-2.0*bb)*(t*t) + (2*bb)*t;
     y *= (1.0 - ymid); 
     y += ymid;
  }

  return y; 
}
