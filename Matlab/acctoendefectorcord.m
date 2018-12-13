%Link Lengths
l1 = 0.26; l2 = 0.25;

%The 4 origins
P1 = [0, 0, 0.40]; P2 = [0,0.75,0.40]; P4 = [0.45,0.75,0.40]; P3 = [0.45,0,0.40];
o1 = [0,0,0.4]; 
o2 = [0,0,0.4]; 
o3 = [0,0,0.4]; 
o4 = [0,0,0.4];

%Joint Angles for 4 legs
P11= [0 , 0 , 0]; P12= [0 , 0,0];
P21= [0 , 0 , 0]; P22= [0 , 0,0];
P31= [0 , 0 , 0]; P32= [0 , 0,0];
P41= [0 , 0 , 0]; P42= [0 , 0,0];

theta1 = [ pi/4, pi/4];
theta2 = [ pi/4, pi/4];
theta3 = [ pi/4, pi/4];
theta4 = [ pi/4, pi/4];

axis(gca, 'equal');
axis([0 2 -2 10 0 1.5]);
grid on;
% view(2)
view([1 1 1]);

w = 0.1;

x_dot0 = 2;
z = 0.4;
g = 9.81;
Tc = sqrt(z/g);
st_time= 0.21;
origin =[0 0 z];
stride_length = 0.4;
x_0 = -stride_length/2;
a= stride_length;
b = 0.2;
stride_time = Tc*log((-stride_length/2 -Tc*x_dot0)/(stride_length/2 -Tc*x_dot0));
i=1;
flag = 1;
for step= 1:1:1000
if(flag==1)  
for t=0:0.01:1

i = i+1;

x(i)= x_0*cosh(t/Tc) + Tc*x_dot0*sinh(t/Tc);
x1(i)= (1/3)*(x_0*cosh(t/(Tc)) + Tc*x_dot0*sinh(t/(Tc)));
x_dot(i) = x_0*sinh(t/Tc)/Tc + x_dot0*cosh(t/Tc);
       
[theta2(1), theta2(2)] = inverse_kinematics_stance(x1(i)+0.2/3, z, l1, l2);
[theta3(1), theta3(2)] = inverse_kinematics_stance(x1(i) -0.2/3, z, l1, l2);
[theta4(1), theta4(2)] = inverse_kinematics_stance(x1(i) -0.2, z, l1, l2);
%stance leg

%3 Stance Leg
P2 = [0, 0.75+o2(2)+x1(i) ,0.40];
P21 =  P2 + [0, l1*cos(theta2(1)) , -l1*sin(theta2(1))];
P22 = P2 +[0, (-0.2/3)+l1*cos(theta2(1)) + l2*cos(theta2(1)+theta2(2)) , -l1*sin(theta2(1)) - l2*sin(theta2(1) + theta2(2))];

P3 = [0.45,o3(2)+x1(i),0.40];
P31 =  P3 + [0, l1*cos(theta3(1)) , -l1*sin(theta3(1))];
P32 = P3 +[0, (0.2/3)+l1*cos(theta3(1)) + l2*cos(theta3(1)+theta3(2)) , -l1*sin(theta3(1)) - l2*sin(theta3(1) + theta3(2))];

P4 = [0.45,0.75+o4(2)+x1(i),0.40];
P41 =  P4 + [0, l1*cos(theta4(1)) , -l1*sin(theta4(1))];
P42 = P4 +[0, 0.2+l1*cos(theta4(1)) + l2*cos(theta4(1)+theta4(2)) , -l1*sin(theta4(1)) - l2*sin(theta4(1) + theta4(2))];

%1 Swing Leg
x_swing = -x(i)-a*cos(t/stride_time*pi);
y_swing = z - b*sin(t/stride_time*pi);
[theta1(1), theta1(2)] = inverse_kinematics_swing(x_swing, y_swing, l1, l2); %stance leg

P1 = [0, 0+o1(2)+x1(i), 0.40];
P11 = P1 + [0, l1*cos(theta1(1)) , -l1*sin(theta1(1))];
P12 = P1 + [0, l1*cos(theta1(1)) + l2*cos(theta1(1)+theta1(2)) , -l1*sin(theta1(1))-l2*sin(theta1(1) + theta1(2))];
%P5 = [x_swing y_swing]
% plot3(P12(1,1),P12(1,2),P12(1,3))
 
 %Link for Stance Leg
 line2 = line([P1(1) P11(1)],[P1(2) P11(2)],[P1(3) P11(3)] , 'LineWidth',3 ,'Color','green');
 line3 = line([P11(1) P12(1)],[P11(2) P12(2)],[P11(3) P12(3)], 'LineWidth',2,'Color','green');
 
 %Link for swing Leg
 line4 = line([P2(1) P21(1)],[P2(2) P21(2)] ,[P2(3) P21(3)] , 'LineWidth',3 ,'Color','green');
 line5 = line([P21(1) P22(1)],[P21(2) P22(2)],[P21(3) P22(3)], 'LineWidth',2,'Color','green');
 
 line6 = line([P3(1) P31(1)],[P3(2) P31(2)] ,[P3(3) P31(3)] , 'LineWidth',3 ,'Color','green');
 line7 = line([P31(1) P32(1)],[P31(2) P32(2)],[P31(3) P32(3)], 'LineWidth',2,'Color','green');
 
 line8 = line([P4(1) P41(1)],[P4(2) P41(2)] ,[P4(3) P41(3)] , 'LineWidth',3 ,'Color','green');
 line9 = line([P41(1) P42(1)],[P41(2) P42(2)],[P41(3) P42(3)], 'LineWidth',2,'Color','green');
 
 

 %Chassis
 %Chassis
 line10 = line([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)] , 'LineWidth',3);
 line11 = line([P2(1) P4(1)],[P2(2) P4(2)],[P2(3) P4(3)] , 'LineWidth',3);
 line12 = line([P4(1) P3(1)],[P4(2) P3(2)],[P4(3) P3(3)] , 'LineWidth',3);
 line13 = line([P3(1) P1(1)],[P3(2) P1(2)],[P3(3) P1(3)] , 'LineWidth',3);
 
 pause(0.1); 
 %remove previous identifiers
 delete(line2);
 delete(line3);
 delete(line4);
 delete(line5);
 delete(line6);
 delete(line7);
 delete(line8);
 delete(line9);
 delete(line10);
 delete(line11);
 delete(line12);
 delete(line13);
 
  if(x(i)>stride_length/3)
    o1 = o1+ [0 stride_length/3 0];
    o2 = o2+ [0 stride_length/3 0];
    o3 = o3+ [0 stride_length/3 0];
    o4 = o4+ [0 stride_length/3 0];
    flag = 2;
    i=1;
    break;
    
end 
end
end

if(flag==2)  
for t=0:0.01:1

i = i+1;

x(i)= x_0*cosh(t/Tc) + Tc*x_dot0*sinh(t/Tc);
x1(i)= (1/3)*(x_0*cosh(t/(Tc)) + Tc*x_dot0*sinh(t/(Tc)));
   
[theta1(1), theta1(2)] = inverse_kinematics_stance(x1(i)-0.2, z, l1, l2);
[theta3(1), theta3(2)] = inverse_kinematics_stance(x1(i) +0.2/3, z, l1, l2);
[theta4(1), theta4(2)] = inverse_kinematics_stance(x1(i) -0.2, z, l1, l2);

%3 Stance Leg
P1 = [0, 0+o1(2)+x1(i), 0.40];
P11 =  P1 + [0, l1*cos(theta1(1)) , -l1*sin(theta1(1))];
P12 = P1 +[0, 0.2+l1*cos(theta1(1)) + l2*cos(theta1(1)+theta1(2)) , -l1*sin(theta1(1)) - l2*sin(theta1(1) + theta1(2))];

P3 = [0.45,o3(2)+x1(i),0.40];
P31 =  P3 + [0, l1*cos(theta3(1)) , -l1*sin(theta3(1))];
P32 = P3 +[0, (-0.2/3)+l1*cos(theta3(1)) + l2*cos(theta3(1)+theta3(2)) , -l1*sin(theta3(1)) - l2*sin(theta3(1) + theta3(2))];

P4 = [0.45,0.75+o4(2)+x1(i),0.40];
P41 =  P4 + [0, l1*cos(theta4(1)) , -l1*sin(theta4(1))];
P42 = P4 +[0, (0.2/3)+l1*cos(theta4(1)) + l2*cos(theta4(1)+theta4(2)) , -l1*sin(theta4(1)) - l2*sin(theta4(1) + theta4(2))];

%1 Swing Leg
x_swing = -x(i)-a*cos(t/stride_time*pi);
y_swing = z - b*sin(t/stride_time*pi);
[theta2(1), theta2(2)] = inverse_kinematics_swing(x_swing, y_swing, l1, l2); %stance leg

P2 = [0, 0.75+o2(2)+x1(i) ,0.40];
P21 = P2 + [0, l1*cos(theta2(1)) , -l1*sin(theta2(1))];
P22 = P2 + [0, l1*cos(theta2(1)) + l2*cos(theta2(1)+theta2(2)) , -l1*sin(theta2(1))-l2*sin(theta2(1) + theta2(2))];
%P5 = [x_swing y_swing]
%  Traj_identi = viscircles(P12,0.001);
 
 %Link for Stance Leg
 line2 = line([P1(1) P11(1)],[P1(2) P11(2)],[P1(3) P11(3)] , 'LineWidth',3 ,'Color','green');
 line3 = line([P11(1) P12(1)],[P11(2) P12(2)],[P11(3) P12(3)], 'LineWidth',2,'Color','green');
 
 %Link for swing Leg
 line4 = line([P2(1) P21(1)],[P2(2) P21(2)] ,[P2(3) P21(3)] , 'LineWidth',3 ,'Color','green');
 line5 = line([P21(1) P22(1)],[P21(2) P22(2)],[P21(3) P22(3)], 'LineWidth',2,'Color','green');
 
 line6 = line([P3(1) P31(1)],[P3(2) P31(2)] ,[P3(3) P31(3)] , 'LineWidth',3 ,'Color','green');
 line7 = line([P31(1) P32(1)],[P31(2) P32(2)],[P31(3) P32(3)], 'LineWidth',2,'Color','green');
 
 line8 = line([P4(1) P41(1)],[P4(2) P41(2)] ,[P4(3) P41(3)] , 'LineWidth',3 ,'Color','green');
 line9 = line([P41(1) P42(1)],[P41(2) P42(2)],[P41(3) P42(3)], 'LineWidth',2,'Color','green');
 
 %Chassis
 line10 = line([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)] , 'LineWidth',3);
 line11 = line([P2(1) P4(1)],[P2(2) P4(2)],[P2(3) P4(3)] , 'LineWidth',3);
 line12 = line([P4(1) P3(1)],[P4(2) P3(2)],[P4(3) P3(3)] , 'LineWidth',3);
 line13 = line([P3(1) P1(1)],[P3(2) P1(2)],[P3(3) P1(3)] , 'LineWidth',3);
 
 pause(0.1); 
 %remove previous identifiers
 delete(line2);
 delete(line3);
 delete(line4);
 delete(line5);
 delete(line6);
 delete(line7);
 delete(line8);
 delete(line9);
 delete(line10);
 delete(line11);
 delete(line12);
 delete(line13);
 
if(x(i)>stride_length/3)
    o1 = o1+ [0 stride_length/3 0];
    o2 = o2+ [0 stride_length/3 0];
    o3 = o3+ [0 stride_length/3 0];
    o4 = o4+ [0 stride_length/3 0];
    flag =3;
    i=1;
    break;
    
end 
end
end

if(flag==3)  
for t=0:0.01:1

i = i+1;

x(i)= x_0*cosh(t/Tc) + Tc*x_dot0*sinh(t/Tc);
x1(i)= (1/3)*(x_0*cosh(t/(Tc)) + Tc*x_dot0*sinh(t/(Tc)));
x_dot(i) = x_0*sinh(t/Tc)/Tc +x_dot0*cosh(t/Tc);
   
       
[theta2(1), theta2(2)] = inverse_kinematics_stance(x1(i)-0.2 , z, l1, l2); %stance leg
[theta1(1), theta1(2)] = inverse_kinematics_stance(x1(i)+0.2/3, z, l1, l2);
[theta4(1), theta4(2)] = inverse_kinematics_stance(x1(i) +0.2, z, l1, l2);

%3 Stance Leg
P2 = [0, 0.75+o2(2)+x1(i) ,0.40];
P21 =  P2 + [0, l1*cos(theta2(1)) , -l1*sin(theta2(1))];
P22 = P2 +[0, 0.2+l1*cos(theta2(1)) + l2*cos(theta2(1)+theta2(2)) , -l1*sin(theta2(1)) - l2*sin(theta2(1) + theta2(2))];

P1 = [0, 0+o1(2)+x1(i), 0.40];
P11 =  P1 + [0, l1*cos(theta1(1)) , -l1*sin(theta1(1))];
P12 = P1 +[0, (-0.2/3)+l1*cos(theta1(1)) + l2*cos(theta1(1)+theta1(2)) , -l1*sin(theta1(1)) - l2*sin(theta1(1) + theta1(2))];

P4 = [0.45,0.75+o4(2)+x1(i),0.40];
P41 =  P4 + [0, l1*cos(theta4(1)) , -l1*sin(theta4(1))];
P42 = P4 +[0, (-0.2)+l1*cos(theta4(1)) + l2*cos(theta4(1)+theta4(2)) , -l1*sin(theta4(1)) - l2*sin(theta4(1) + theta4(2))];

%1 Swing Leg
x_swing = -x(i)-a*cos(t/stride_time*pi);
y_swing = z - b*sin(t/stride_time*pi);
[theta3(1), theta3(2)] = inverse_kinematics_swing(x_swing, y_swing, l1, l2); %stance leg

P3 = [0.45,o3(2)+x1(i),0.40];
P31 = P3 + [0, l1*cos(theta3(1)) , -l1*sin(theta3(1))];
P32 = P3 + [0, l1*cos(theta3(1)) + l2*cos(theta3(1)+theta3(2)) , -l1*sin(theta3(1))-l2*sin(theta3(1) + theta3(2))];
%P5 = [x_swing y_swing]
%  Traj_identi = viscircles(P12,0.001);
 
 %Link for Stance Leg
 line2 = line([P1(1) P11(1)],[P1(2) P11(2)],[P1(3) P11(3)] , 'LineWidth',3 ,'Color','green');
 line3 = line([P11(1) P12(1)],[P11(2) P12(2)],[P11(3) P12(3)], 'LineWidth',2,'Color','green');
 
 %Link for swing Leg
 line4 = line([P2(1) P21(1)],[P2(2) P21(2)] ,[P2(3) P21(3)] , 'LineWidth',3 ,'Color','green');
 line5 = line([P21(1) P22(1)],[P21(2) P22(2)],[P21(3) P22(3)], 'LineWidth',2,'Color','green');
 
 line6 = line([P3(1) P31(1)],[P3(2) P31(2)] ,[P3(3) P31(3)] , 'LineWidth',3 ,'Color','green');
 line7 = line([P31(1) P32(1)],[P31(2) P32(2)],[P31(3) P32(3)], 'LineWidth',2,'Color','green');
 
 line8 = line([P4(1) P41(1)],[P4(2) P41(2)] ,[P4(3) P41(3)] , 'LineWidth',3 ,'Color','green');
 line9 = line([P41(1) P42(1)],[P41(2) P42(2)],[P41(3) P42(3)], 'LineWidth',2,'Color','green');
 
 

 %Chassis
 %Chassis
 line10 = line([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)] , 'LineWidth',3);
 line11 = line([P2(1) P4(1)],[P2(2) P4(2)],[P2(3) P4(3)] , 'LineWidth',3);
 line12 = line([P4(1) P3(1)],[P4(2) P3(2)],[P4(3) P3(3)] , 'LineWidth',3);
 line13 = line([P3(1) P1(1)],[P3(2) P1(2)],[P3(3) P1(3)] , 'LineWidth',3);
 
 pause(0.1); 
 %remove previous identifiers
 delete(line2);
 delete(line3);
 delete(line4);
 delete(line5);
 delete(line6);
 delete(line7);
 delete(line8);
 delete(line9);
 delete(line10);
 delete(line11);
 delete(line12);
 delete(line13);
 
if(x(i)>stride_length/3)
    o1 = o1+ [0 stride_length/3 0];
    o2 = o2+ [0 stride_length/3 0];
    o3 = o3+ [0 stride_length/3 0];
    o4 = o4+ [0 stride_length/3 0];
    flag =4;
    i=1;
    break;
    
end 
end
end

if(flag==4)  
for t=0:0.01:1

i = i+1;

x(i)= x_0*cosh(t/Tc) + Tc*x_dot0*sinh(t/Tc);
x1(i)= (1/3)*(x_0*cosh(t/(Tc)) + Tc*x_dot0*sinh(t/(Tc)));
x_dot(i) = x_0*sinh(t/Tc)/Tc +x_dot0*cosh(t/Tc);
   
       
[theta3(1), theta3(2)] = inverse_kinematics_stance(x1(i)-0.2, z, l1, l2); %stance leg
[theta2(1), theta2(2)] = inverse_kinematics_stance(x1(i)-0.2/3 , z, l1, l2); %stance leg
[theta1(1), theta1(2)] = inverse_kinematics_stance(x1(i)+0.2/3, z, l1, l2);

%3 Stance Leg
P2 = [0, 0.75+o2(2)+x1(i) ,0.40];
P21 =  P2 + [0, l1*cos(theta2(1)) , -l1*sin(theta2(1))];
P22 = P2 +[0, (0.2/3)+l1*cos(theta2(1)) + l2*cos(theta2(1)+theta2(2)) , -l1*sin(theta2(1)) - l2*sin(theta2(1) + theta2(2))];

P3 = [0.45,o3(2)+x1(i),0.40];
P31 =  P3 + [0, l1*cos(theta3(1)) , -l1*sin(theta3(1))];
P32 = P3 +[0, 0.2+l1*cos(theta3(1)) + l2*cos(theta3(1)+theta3(2)) , -l1*sin(theta3(1)) - l2*sin(theta3(1) + theta3(2))];

P1 = [0, 0+o1(2)+x1(i), 0.40];
P11 =  P1 + [0, l1*cos(theta1(1)) , -l1*sin(theta1(1))];
P12 = P1 +[0, (-0.2/3)+l1*cos(theta1(1)) + l2*cos(theta1(1)+theta1(2)) , -l1*sin(theta1(1)) - l2*sin(theta1(1) + theta1(2))];

%1 Swing Leg
x_swing = -x(i)-a*cos(t/stride_time*pi);
y_swing = z - b*sin(t/stride_time*pi);
[theta4(1), theta4(2)] = inverse_kinematics_swing(x_swing, y_swing, l1, l2); %stance leg

P4 = [0.45,0.75+o4(2)+x1(i),0.40];
P41 = P4 + [0, l1*cos(theta4(1)) , -l1*sin(theta4(1))];
P42 = P4 + [0, l1*cos(theta4(1)) + l2*cos(theta4(1)+theta4(2)) , -l1*sin(theta4(1))-l2*sin(theta4(1) + theta4(2))];
%P5 = [x_swing y_swing]
%  Traj_identi = viscircles(P12,0.001);
 
 %Link for Stance Leg
 line2 = line([P1(1) P11(1)],[P1(2) P11(2)],[P1(3) P11(3)] , 'LineWidth',3 ,'Color','green');
 line3 = line([P11(1) P12(1)],[P11(2) P12(2)],[P11(3) P12(3)], 'LineWidth',2,'Color','green');
 
 %Link for swing Leg
 line4 = line([P2(1) P21(1)],[P2(2) P21(2)] ,[P2(3) P21(3)] , 'LineWidth',3 ,'Color','green');
 line5 = line([P21(1) P22(1)],[P21(2) P22(2)],[P21(3) P22(3)], 'LineWidth',2,'Color','green');
 
 line6 = line([P3(1) P31(1)],[P3(2) P31(2)] ,[P3(3) P31(3)] , 'LineWidth',3 ,'Color','green');
 line7 = line([P31(1) P32(1)],[P31(2) P32(2)],[P31(3) P32(3)], 'LineWidth',2,'Color','green');
 
 line8 = line([P4(1) P41(1)],[P4(2) P41(2)] ,[P4(3) P41(3)] , 'LineWidth',3 ,'Color','green');
 line9 = line([P41(1) P42(1)],[P41(2) P42(2)],[P41(3) P42(3)], 'LineWidth',2,'Color','green');
 
 

 %Chassis
 %Chassis
 line10 = line([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)] , 'LineWidth',3);
 line11 = line([P2(1) P4(1)],[P2(2) P4(2)],[P2(3) P4(3)] , 'LineWidth',3);
 line12 = line([P4(1) P3(1)],[P4(2) P3(2)],[P4(3) P3(3)] , 'LineWidth',3);
 line13 = line([P3(1) P1(1)],[P3(2) P1(2)],[P3(3) P1(3)] , 'LineWidth',3);
 
 pause(0.1);  
 %remove previous identifiers
 delete(line2);
 delete(line3);
 delete(line4);
 delete(line5);
 delete(line6);
 delete(line7);
 delete(line8);
 delete(line9);
 delete(line10);
 delete(line11);
 delete(line12);
 delete(line13);
 
if(x(i)>stride_length/3)
    o1 = o1+ [0 stride_length/3 0];
    o2 = o2+ [0 stride_length/3 0];
    o3 = o3+ [0 stride_length/3 0];
    o4 = o4+ [0 stride_length/3 0]  ;
    flag =1;
    i=1;
    break;
    
end 
end
end
end