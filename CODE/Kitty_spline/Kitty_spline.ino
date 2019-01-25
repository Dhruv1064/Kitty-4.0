#include <MatrixMath.h>

int l1 = 26, l2 = 22, a = 20, b = 7;
float w=0.1,alpha;

void setup() {
  // put your setup code here, to run once:

}

void loop() {

  for(int t=0;t<100000;t++)
  {
    float xe=cos(w*t)*a;
    float ye=sin(w*t)*b-40;

    float xef = cos(w*(t+1))*a;
    float yef = sin(w*(t+1))*b -40;

    if(ye<-40)
    ye=-40;

    if(atan(ye/xe)>0)
    {
        alpha = atan(ye/xe)-PI;
    }
    else
    {
          alpha = atan(ye/xe);
    }
    
    float theta1= cosine_rule(l2,l1,sqrt(xe*xe+ye*ye))+alpha;
    float theta2= -PI+cosine_rule(sqrt(xe*xe+ye*ye),l1,l2);

    if(yef<-40)
    yef=-40;

    if(atan(yef/xef)>0)
    {
        alpha = atan(yef/xef)-PI;
    }
    else
    {
          alpha = atan(yef/xef);
    }

   float theta1f = cosine_rule(l2,l1,sqrt(xef*xef+yef*yef))+alpha;
   float theta2f = -PI+cosine_rule(sqrt(xef*xef+yef*yef),l1,l2);

   float xa = l1*cos(theta1) + l2*cos(theta1 + theta2);
   float ya = l1*sin(theta1) + l2*sin(theta1 + theta2);

   float xaf = l1*cos(theta1f) + l2*cos(theta1f + theta2f);
   float yaf = l1*sin(theta1f) + l2*sin(theta1f + theta2f);

   float J1=-l1*sin(theta1)-l2*sin(theta1+theta2);
   float J2=-l2*sin(theta1+theta2);
   float J3=l1*cos(theta1)+l2*cos(theta1+theta2);
   float J4=l2*cos(theta1+theta2);

   float J[2][2]={J1,J2,J3,J4};

   float J1f=-l1*sin(theta1f)-l2*sin(theta1f+theta2f);
   float J2f=-l2*sin(theta1f+theta2f);
   float J3f=l1*cos(theta1f)+l2*cos(theta1f+theta2f);
   float J4f=l2*cos(theta1f+theta2f);

    float Jf[2][2]={J1f, J2f, J3f, J4f};

    float X[2],Xf[2];

    Matrix.Invert((double*)J,2);
    Matrix.Invert((double*)Jf,2);

    Matrix.Multiply((double*)J,       ,2,2,1,(double*)X);
    Matrix.Multiply((double*)Jf,      ,2,2,1,(double*)Xf);

//    for(kbnnbaeaeol)
//    {
    float ti,tf;

    float M[4][4]={1,ti,pow(ti,2),pow(ti,3),0,1,2*ti,3*ti*ti,1,tf,tf*tf,pow(tf,3),0,1,2*tf,3*f*tf};

    float co1[4]={theta1,X[0],theta1f,Xf[0]};
    float co2[4]={theta2,X[1],theta2f,Xf[1]};
    
    Matrix.Invert((double*)M,4);

    Matrix.Invert((double*));
      
//  }
//   float X1=(1/(J1*J4-J2*J3))*(J4*(-(sin(w*t))*a*w)-J2*(cos(w*t))*b*w);
//   float X2=(1/(J1*J4-J2*J3))*(-J3*(-(sin(w*t))*a*w)+J1*(cos(w*t))*b*w);
//   float X1f=(1/(J1f*J4f-J2f*J3f))*(J4f*(-(sin(w*(t+1)))*a*w)-J2f*(cos(w*(t+1)))*b*w);
//   float X2f=(1/(J1f*J4f-J2f*J3f))*(-J3f*(-(sin(w*(t+1)))*a*w)+J1f*(cos(w*(t+1)))*b*w);
  }

}
