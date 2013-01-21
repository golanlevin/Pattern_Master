// Raised Inverted Cosines

//------------------------------------------------------------------
float function_RaisedInvertedCosine (float x) {
  functionName = "Raised Inverted Cosine";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float y = (1.0 - cos(PI*x))/2.0;
  return y;
}

//------------------------------------------------------------------
float function_BlinnWyvillCosineApproximation (float x) {
  functionName = "Blinn/Wyvill's Cosine Approximation";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float x2 = x*x;
  float x4 = x2*x2;
  float x6 = x4*x2;
  float fa = ( 4.0/9.0);
  float fb = (17.0/9.0);
  float fc = (22.0/9.0);
  float y = fa*x6 - fb*x4 + fc*x2;

  return y;
}


//------------------------------------------------------------------
float function_SmoothStep (float x) { 
  // http://en.wikipedia.org/wiki/Smoothstep
  functionName = "Smooth Step";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  // Evaluate polynomial
  return x*x*(3.0 - 2.0*x);
}

//------------------------------------------------------------------
float function_SmootherStep (float x) { 
  // http://en.wikipedia.org/wiki/Smoothstep

  functionName = "Perlin's Smoother Step";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  // Evaluate polynomial
  return x*x*x*(x*(x*6.0 - 15.0) + 10.0);
}

//------------------------------------------------------------------
float function_MaclaurinCos (float x) {
  // http://blogs.ubc.ca/infiniteseriesmodule/units/unit-3-power-series/taylor-series/the-maclaurin-expansion-of-cosx/

  functionName = "Maclaurin Cosine Approximation";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  int nTerms = 6;

  x *= PI;
  float xp = 1;
  float x2 = x*x;

  float sig  = 1;
  float fact = 1;
  float out = xp;

  for (int i=0; i<nTerms; i++) {
    xp   *= x2; 
    sig  = 0-sig;
    fact *= (i*2+1); 
    fact *= (i*2+2);
    out  += sig * (xp / fact);
  }

  out = (1.0 - out)/2.0;
  return out;
}

//------------------------------------------------------------------
// from http://paulbourke.net/miscellaneous/interpolation/
float function_CatmullRomInterpolate (float x, float a, float b) {

  functionName = "Catmull Rom Interpolation";
  useParameterA = true;
  useParameterB = true;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float y0 = a; 
  float y3 = b; 
  float x2 = x*x;

  /*
   float y1 = 0; //1.0/3.0
   float y2 = 1; 
   
   float a0 = -0.5*y0 + 1.5*y1 - 1.5*y2 + 0.5*y3;
   float a1 =      y0 - 2.5*y1 + 2.0*y2 - 0.5*y3;
   float a2 = -0.5*y0          + 0.5*y2;
   float a3 =               y1;
   return (a0*x*x2 + a1*x2 + a2*x + a3);
   */

  float a0 = -0.5*y0 + 0.5*y3 - 1.5 ;
  float a1 =      y0 - 0.5*y3 + 2.0 ;
  float a2 = -0.5*y0          + 0.5 ;

  float out = a0*x*x2 + a1*x2 + a2*x;
  return constrain (out, 0, 1);
}


//------------------------------------------------------------------
// from http://musicdsp.org/showArchiveComment.php?ArchiveID=93
// laurent de soras
float function_Hermite (float x, float y0, float y1, float y2, float y3) {
  float c = (y2 - y0) * 0.5f;
  float v = y1 - y2;
  float w = c + v;
  float a = w + v + (y3 - y1) * 0.5f;
  float b_neg = w + a;

  return ((((a * x) - b_neg) * x + c) * x + y1);
}


//------------------------------------------------------------------
// from http://paulbourke.net/miscellaneous/interpolation/
float function_HermiteAdvanced (float x, float a, float b) {

  functionName = "Hermite Advanced";
  useParameterA = true;
  useParameterB = true;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  /*
   Tension: 1 is high, 0 normal, -1 is low
   Bias: 0 is even, positive is towards first segment, negative towards the other
   */

  float tension = 0;//sin(millis()/300.0); 
  float bias = 0; 

  float y0 = a; //2.0 * (a - 0.5);  //?
  float y1 = 0.0; 
  float y2 = 1.0; 
  float y3 = b;

  float x2 =  x * x;
  float x3 = x2 * x;

  float m0, m1;
  m0  = (y1-y0)*(1.0+bias)*(1.0-tension)/2.0;
  m0 += (y2-y1)*(1.0-bias)*(1.0-tension)/2.0;
  m1  = (y2-y1)*(1.0+bias)*(1.0-tension)/2.0;
  m1 += (y3-y2)*(1.0-bias)*(1.0-tension)/2.0;

  float a0  =  2.0*x3 - 3.0*x2 + 1.0;
  float a1  =      x3 - 2.0*x2 + x;
  float a2  =      x3 -     x2;
  float a3  = -2.0*x3 + 3.0*x2;

  return (a0*y1 + a1*m0 + a2*m1 + a3*y2);
}



//------------------------------------------------------------------
float function_NormalizedErf (float x) {
  // http://en.wikipedia.org/wiki/Error_function
  // Note that this implementation is a shifted, scaled and normalized error function!

  float erfBound = 2.0; // set bounds for artificial "normalization"
  float erfBoundNorm = 0.99532226501; // this = erf(2.0), i.e., erf(erfBound)
  float z = map(x, 0.0, 1.0, 0-erfBound, erfBound); 

  functionName = "Error Function";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float z2 = z*z; 
  float a = (8.0*(PI-3.0)) / ((3*PI)*(4.0-PI)); 
  float out = sqrt (1.0 - exp(0 - z2*(  (a*z2 + 4.0/PI) / (a*z2 + 1.0))));
  if (z < 0.0) out = 0-out;

  out /= erfBoundNorm;
  out = (out+1.0) / 2.0; 

  return out;
}

//------------------------------------------------------------------
float function_NormalizedInverseErf (float x) {
  // http://en.wikipedia.org/wiki/Error_function
  // Note that this implementation is a shifted, scaled and normalized error function!

  functionName = "Inverse Error Function";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float erfBound = 2.0;
  float erfBoundNorm = 0.99532226501; // this = erf(2.0), i.e., erf(erfBound)
  float z = map(x, 0, 1, -erfBoundNorm, erfBoundNorm); 
  float z2 = z*z;
  float a = (8.0*(PI-3.0)) / ((3*PI)*(4.0-PI)); 

  float A = (2.0 / (PI *a)) + (log(1.0-z2) / 2.0);
  float B = (log(1.0-z2) / a);
  float out = sqrt( sqrt(A*A - B) - A );

  if (z < 0.0) out = 0-out;
  out /= erfBound; 
  out = (out+1.0); 
  out /= 2.0;

  out = constrain(out, 0, 1);  // necessary
  return out;
}

//------------------------------------------------------------------
float function_SimpleHalfGaussian (float x) {
  // http://en.wikipedia.org/wiki/Gaussian_function

  functionName = "Simple Gaussian (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float sigma = 0.25; // produces results < 0.001 at f(0); 
  float out = exp(0.0 - (sq(x-1.0) / (2.0*sigma*sigma))); 
  return out;
}

//------------------------------------------------------------------
float function_AdjustableFwhmHalfGaussian (float x, float a) {
  // http://en.wikipedia.org/wiki/Gaussian_function
  // http://en.wikipedia.org/wiki/Full_width_at_half_maximum

  functionName = "Adjustable-FWHM Gaussian (Half)";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float denom = sqrt(2.0*log(2.0));
  float sigma = (1.0 - a) / denom;

  // 68.26894921371
  float out = exp(0.0 - (sq(x-1.0) / (2.0*sigma*sigma))); 
  return out;
}


//------------------------------------------------------------------
float function_HalfGaussianThroughAPoint (float x, float a, float b) {
  // http://en.wikipedia.org/wiki/Gaussian_function
  // http://en.wikipedia.org/wiki/Full_width_at_half_maximum

  functionName = "Gaussian Through A Point (Half)";
  useParameterA = true;
  useParameterB = true;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  b = max(0.0000001, b); 

  float denom = sqrt(2.0*log(1.0/b));
  float sigma = (1.0 - a) / denom;

  // 68.26894921371
  float out = exp(0.0 - (sq(x-1.0) / (2.0*sigma*sigma))); 
  return out;
}


//------------------------------------------------------------------
float function_AdjustableSigmaHalfGaussian (float x, float a) {
  // http://en.wikipedia.org/wiki/Gaussian_function

  functionName = "Adjustable-Sigma Gaussian (Half)";
  useParameterA = true;
  useParameterB = false;
  useParameterC = false;
  useParameterD = false;
  useParameterN = false;

  float sigma = 1.0-a;
  float out = exp(0.0 - (sq(x-1.0) / (2.0*sigma*sigma))); 
  return out;
}

//------------------------------------------------------------------
float function_HalfLanczosSincWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 

  functionName = "Lanczos Sinc Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float y = sinc (1.0 - x);
  return y;
}

float sinc (float x) {
  float pix = PI*x;
  if (x == 0) {
    return 1.0;
  } 
  else {
    return (sin(pix) / pix);
  }
}

//------------------------------------------------------------------
float function_HalfNuttallWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Nuttall Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.355768;
  float a1 = 0.487396;
  float a2 = 0.144232;
  float a3 = 0.012604;

  x *= 0.5;
  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix);
  return y;
}



//------------------------------------------------------------------
float function_HalfBlackmanNuttallWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Blackman–Nuttall Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.3635819;
  float a1 = 0.4891775;
  float a2 = 0.1365995;
  float a3 = 0.0106411;

  x *= 0.5;
  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix);
  return y;
}

//------------------------------------------------------------------
float function_HalfBlackmanHarrisWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Blackman–Harris Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.35875;
  float a1 = 0.48829;
  float a2 = 0.14128;
  float a3 = 0.01168;

  x *= 0.5;
  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix);
  return y;
}

//------------------------------------------------------------------
float function_HalfExactBlackmanWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Exact Blackman Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 7938.0 / 18608.0;
  float a1 = 9240.0 / 18608.0;
  float a2 = 1430.0 / 18608.0;

  x *= 0.5;
  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix);
  return y;
}

//------------------------------------------------------------------
float function_HalfGeneralizedBlackmanWindow (float x, float a) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Generalized Blackman Window (Half)";
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = (1.0 - a)/2.0;
  float a1 = 0.5;
  float a2 = a / 2.0;

  x *= 0.5;
  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix);
  return y;
}

//------------------------------------------------------------------
float function_HalfFlatTopWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Flat Top Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 1.000;
  float a1 = 1.930;
  float a2 = 1.290;
  float a3 = 0.388;
  float a4 = 0.032;

  x *= 0.5;
  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix) + a4*cos(8*pix);
  y /= (a0 + a1 + a2 + a3 + a4); 

  return y;
}

//------------------------------------------------------------------
float function_HalfBartlettHannWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Bartlett-Hann Window (Half)";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.62;
  float a1 = 0.48;
  float a2 = 0.38;

  x *= 0.5;
  float y = a0 - a1*abs(x - 0.5) - a2*cos(2*PI*x);
  return y;
}

//------------------------------------------------------------------
float function_BartlettWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  // Triangular window with zero-valued end-points:
  functionName = "Bartlett (Triangle) Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float y = 2.0 * (0.5 - abs(x - 0.5));
  return y;
}


//------------------------------------------------------------------
float function_TukeyWindow (float x, float a) {
  functionName = "Tukey Window";
  useParameterA = true; 
  useParameterB = useParameterC = useParameterD = useParameterN = false;

  // http://en.wikipedia.org/wiki/Window_function 
  // The Tukey window, also known as the tapered cosine window, 
  // can be regarded as a cosine lobe of width \tfrac{\alpha N}{2} 
  // that is convolved with a rectangle window of width \left(1 -\tfrac{\alpha}{2}\right)N.  
  // At alpha=0 it becomes rectangular, and at alpha=1 it becomes a Hann window.

  float ah = a/2.0; 
  float omah = 1.0 - ah;

  float y = 1.0;
  if (x <= ah) {
    y = 0.5 * (1.0 + cos(PI* ((2*x/a) - 1.0)));
  } 
  else if (x > omah) {
    y = 0.5 * (1.0 + cos(PI* ((2*x/a) - (2/a) + 1.0)));
  } 
  return y;
}


//------------------------------------------------------------------
float function_CosineWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Cosine Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float y = sin (PI*x);
  return y;
}


//------------------------------------------------------------------
float function_AdjustableSigmaGaussian (float x, float a) {
  // http://en.wikipedia.org/wiki/Gaussian_function

  functionName = "Adjustable-Sigma Gaussian Window";
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = useParameterN = false;
  
  x *= 2.0;
  a *= 2.0; 
  float sigma = a;
  float out = exp(0.0 - (sq(x-1.0) / (2.0*sigma*sigma))); 
  return out;
}



//------------------------------------------------------------------
float function_LanczosSincWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 

  functionName = "Lanczos Sinc Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;
  
  x *= 2.0;
  float y = sinc (1.0 - x);
  return y;
}




//------------------------------------------------------------------
float function_NuttallWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Nuttall Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.355768;
  float a1 = 0.487396;
  float a2 = 0.144232;
  float a3 = 0.012604;

  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix);
  return y;
}



//------------------------------------------------------------------
float function_BlackmanNuttallWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Blackman–Nuttall Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.3635819;
  float a1 = 0.4891775;
  float a2 = 0.1365995;
  float a3 = 0.0106411;

  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix);
  return y;
}


//------------------------------------------------------------------
float function_BlackmanHarrisWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Blackman–Harris Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.35875;
  float a1 = 0.48829;
  float a2 = 0.14128;
  float a3 = 0.01168;

  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix);
  return y;
}

//------------------------------------------------------------------
float function_ExactBlackmanWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Exact Blackman Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 7938.0 / 18608.0;
  float a1 = 9240.0 / 18608.0;
  float a2 = 1430.0 / 18608.0;

  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix);
  return y;
}



//------------------------------------------------------------------
float function_GeneralizedBlackmanWindow (float x, float a) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Generalized Blackman Window";
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = (1.0 - a)/2.0;
  float a1 = 0.5;
  float a2 = a / 2.0;

  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix);
  return y;
}


//------------------------------------------------------------------
float function_FlatTopWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Flat Top Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 1.000;
  float a1 = 1.930;
  float a2 = 1.290;
  float a3 = 0.388;
  float a4 = 0.032;

  float pix = PI*x;
  float y = a0 - a1*cos(2*pix) + a2*cos(4*pix) - a3*cos(6*pix) + a4*cos(8*pix);
  y /= (a0 + a1 + a2 + a3 + a4); 

  return y;
}

//------------------------------------------------------------------
float function_BartlettHannWindow (float x) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Bartlett-Hann Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;

  float a0 = 0.62;
  float a1 = 0.48;
  float a2 = 0.38;

  float y = a0 - a1*abs(x - 0.5) - a2*cos(2*PI*x);
  return y;
}

//------------------------------------------------------------------
float function_HannWindow (float x){
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Hann (Raised Cosine) Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;
  
  float y = 0.5 * (1.0 - cos(TWO_PI*x));
  return y;
}

//------------------------------------------------------------------
float function_HammingWindow (float x){
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Hamming Window";
  useParameterA = useParameterB = useParameterC = useParameterD = useParameterN = false;
  
  float y = 0.54 - 0.46*cos(TWO_PI*x);
  return y;
}

//------------------------------------------------------------------
float functionGeneralizedTriangleWindow (float x, float a) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Generalized Triangle Window";
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = useParameterN = false;
  
  float y = 0; 
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = constrain(a, min_param_a, max_param_a); 
  
  if (x < a){
    y = (x / a); 
  } else {
    y = 1.0 - ((x-a)/(1.0-a));
  }
  return y;
}

//------------------------------------------------------------------
float functionPoissonWindow (float x, float a) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Poisson or Exponential Window";
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = useParameterN = false;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float tau = max(a, min_param_a); 
  
  float y = exp (0.0 - (abs(x - 0.5))*(1.0/tau));
  return y; 
}

//------------------------------------------------------------------
float functionHannPoissonWindow (float x, float a) {
  // http://en.wikipedia.org/wiki/Window_function 
  functionName = "Hann-Poisson Window";
  useParameterA = true;
  useParameterB = useParameterC = useParameterD = useParameterN = false;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float tau = max(a, min_param_a); 
  
  float hy = 0.5 * (1.0 - cos(TWO_PI*x));
  float py = exp (0.0 - (abs(x - 0.5))*(1.0/tau));
  return (hy * py); 
}


