// Penner's Equations


//------------------------------------------------------------------
float function_PennerEaseInBack (float x) {
  functionName = "Penner's Ease-In Back";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float s = 1.70158;
  float y = x*x*((s+1.0)*x - s);
  return y;
}

//------------------------------------------------------------------
float function_PennerEaseOutBack (float x) {
  functionName = "Penner's Ease-Out Back";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float s = 1.70158;
  x = x-1.0;
  float y = (x*x*((s+1.0)*x + s) + 1.0);
  return y;
}

//------------------------------------------------------------------
float function_PennerEaseInOutBack (float x) {

  functionName = "Penner's EaseInOut Back";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float s = 1.70158 * 1.525;
  x /= 0.5;

  float y = 0; 
  if (x < 1) {
    y = 1.0/2.0* (x*x*((s+1.0)*x - s));
  } 
  else {
    x -= 2.0;
    y = 1.0/2.0* (x*x*((s+1.0)*x + s) + 2.0);
  } 
  return y;
}



//------------------------------------------------------------------
float function_PennerEaseInQuadratic (float t) {
  functionName = "Penner's EaseIn Quadratic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return t*t;
}
//------------------------------------------------------------------
float function_PennerEaseOutQuadratic (float t) {
  functionName = "Penner's EaseOut Quadratic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return -1.0 *(t)*(t-2);
}
//------------------------------------------------------------------
float function_PennerEaseInOutQuadratic (float t) {
  functionName = "Penner's EaseInOut Quadratic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if ((t/=1.f/2) < 1) return 1.f/2*t*t;
  return -1.f/2 * ((--t)*(t-2) - 1);
}

//------------------------------------------------------------------
float function_PennerEaseInCubic (float x) {
  functionName = "Penner's EaseIn Cubic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return x*x*x;
}

//------------------------------------------------------------------
float function_PennerEaseOutCubic (float x) {
  functionName = "Penner's EaseOut Cubic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  x = x-1.0;
  return (x*x*x + 1);
}


//------------------------------------------------------------------
float function_PennerEaseInOutCubic (float x) {

  functionName = "Penner's EaseInOut Cubic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  x *= 2.0; 
  float y = 0; 

  if (x < 1) {
    y = 0.5 * x*x*x;
  } 
  else {
    x -= 2.0;
    y = 0.5 * (x*x*x + 2.0);
  }
  return y;
}


//------------------------------------------------------------------
float function_PennerEaseInQuartic (float t) {
  functionName = "Penner's EaseIn Quartic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return t*t*t*t;
}
//------------------------------------------------------------------
float function_PennerEaseOutQuartic (float t) {
  functionName = "Penner's EaseOut Quartic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return -1 * ((t=t-1)*t*t*t - 1);
}

//------------------------------------------------------------------
float function_PennerEaseInOutQuartic (float t) {
  functionName = "Penner's EaseInOut Quartic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if ((t/=1.f/2) < 1) return 1.f/2*t*t*t*t;
  return -1.f/2 * ((t-=2)*t*t*t - 2);
}

//------------------------------------------------------------------
float function_PennerEaseInQuintic (float t) {
  functionName = "Penner's EaseIn Quintic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return t*t*t*t*t;
}
//------------------------------------------------------------------
float function_PennerEaseOutQuintic (float t) {
  functionName = "Penner's EaseOut Quintic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  t = t-1;
  return (t*t*t*t*t + 1.0);
}

//------------------------------------------------------------------
float function_PennerEaseInOutQuintic (float t) {
  functionName = "Penner's EaseInOut Quintic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if ((t/=1.f/2) < 1) return 1.f/2*t*t*t*t*t;
  return 1.f/2*((t-=2)*t*t*t*t + 2);
}



//------------------------------------------------------------------
float function_PennerEaseInSine (float t) {
  functionName = "Penner's EaseIn Sine";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return -1.0 * cos(t * (PI/2)) + 1;
}
//------------------------------------------------------------------
float function_PennerEaseOutSine(float t) {
  functionName = "Penner's EaseOut Sine";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return sin(t * (PI/2));
}

//------------------------------------------------------------------
float function_PennerEaseInOutSine(float t) {
  functionName = "Penner's EaseInOut Sine";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return -0.5 * (cos(PI*t) - 1);
}




//------------------------------------------------------------------
float function_PennerEaseInExpo(float t) {
  functionName = "Penner's EaseIn Exponential";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return (t==0) ? 0 : pow(2, 10 * (t - 1));
}
//------------------------------------------------------------------
float function_PennerEaseOutExpo(float t) {
  functionName = "Penner's EaseOut Exponential";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return (t==1) ? 1 : (-pow(2, -10 * t) + 1);
}

//------------------------------------------------------------------
float function_PennerEaseInOutExpo(float t) {
  functionName = "Penner's EaseInOut Exponential";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if (t==0) return 0;
  if (t==1) return 1;
  if ((t/=1.f/2) < 1) return 1.f/2 * pow(2, 10 * (t - 1));
  return 1.f/2 * (-pow(2, -10 * --t) + 2);
}




//------------------------------------------------------------------
float function_PennerEaseInElastic (float t) {

  functionName = "Penner's EaseIn Elastic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if (t==0) return 0; 
  if (t==1) return 1;
  float p=.3f;

  float s=p/4;
  float postFix = pow(2, 10.0 * (t-=1)); // this is a fix, again, with post-increment operators
  return -(postFix * sin((t-s)*(2*PI)/p ));
}

//------------------------------------------------------------------
float function_PennerEaseOutElastic(float t) {

  functionName = "Penner's EaseOut Elastic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if (t==0) return 0; 
  if ((t)==1) return 1;
  float p = 0.3f;
  float s = p/4;

  return (pow(2, -10*t) * sin( (t-s)*(2*PI)/p ) + 1);
}

//------------------------------------------------------------------
float function_PennerEaseInOutElastic (float t) {

  functionName = "Penner's EaseInOut Elastic";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if (t==0) return 0; 
  if ((t/=0.5)==2) return 1;
  float p=(.3f*1.5f);
  float a=1;
  float s=p/4;

  if (t < 1) {
    float postFix = pow(2, 10*(t-=1)); // postIncrement is evil
    return -.5f*(postFix* sin( (t-s)*(2*PI)/p ));
  } 
  float postFix = pow(2, -10*(t-=1)); // postIncrement is evil
  return postFix * sin( (t-s)*(2*PI)/p )*.5f + 1;
}



//------------------------------------------------------------------
float function_PennerEaseOutBounce(float t) {
  functionName = "Penner's EaseOut Bounce";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if ((t) < (1/2.75f)) {
    return (7.5625f* t*t);
  } 
  else if (t < (2/2.75f)) {
    float postFix = t-=(1.5f/2.75f);
    return (7.5625f*(postFix)*t + .75f);
  } 
  else if (t < (2.5/2.75)) {
    float postFix = t-=(2.25f/2.75f);
    return (7.5625f*(postFix)*t + .9375f);
  } 
  else {
    float postFix = t-=(2.625f/2.75f);
    return (7.5625f*(postFix)*t + .984375f);
  }
}

//------------------------------------------------------------------
float function_PennerEaseInBounce (float t) {
  functionName = "Penner's EaseIn Bounce";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  return 1.0 - function_PennerEaseOutBounce (1.0-t);
}

//------------------------------------------------------------------
float function_PennerEaseInOutBounce(float t) {
  functionName = "Penner's EaseInOut Bounce";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  if (t < 0.5) return function_PennerEaseInBounce (t*2) * .5f;
  else return function_PennerEaseOutBounce (t*2-1) * .5f + .5f;
}

//------------------------------------------------------------------
float function_Staircase (float x, int n) {
  functionName = "Staircase";
  useParameterA = useParameterB = useParameterC = useParameterD = false; 
  useParameterN = true;

  float y = floor(x*n) / (float)(n-1);
  return y;
}

//------------------------------------------------------------------
float function_ExponentialSmoothedStaircase (float x, float a, int n) {
  functionName = "Smoothed Exponential Staircase";
  // http://web.mit.edu/fnl/volume/204/winston.html
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = false; 
  useParameterN = true;
  
  
  float fa =  sq(map(a,0,1, 5,30));
  

  float y = 0; 
  for (int i=0; i<n; i++){
    y += (1.0/(n-1.0))/ (1.0 + exp(fa*(((i+1.0)/n) - x)));
  }
  y = constrain(y, 0,1); 
  return y;
}



//------------------------------------------------------------------
float function_Gompertz (float x, float a) {
  // http://en.wikipedia.org/wiki/Gompertz_curve
  functionName = "Gompertz Function";
  useParameterA = true; 
  useParameterB = useParameterC = useParameterD = useParameterN = false; 

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  a = max(a, min_param_a); 

  float b = -8.0;
  float c = 0 - a*16;
  float y = exp( b * exp(c * x));

  float maxVal = exp(b * exp(c));
  float minVal = exp(b );
  y = map(y, minVal, maxVal, 0, 1); 

  return y ;
}




