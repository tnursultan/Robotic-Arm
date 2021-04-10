%Make sure to run this script before trying to run Simulink.
%If you wanna change the Gains for the controller, double click on the
%MATLAB Function block and a function window in MATLAB will open up. You
%can change the variables there. You can edit P_gain D_gain or I_gain.
%Probably shouldnt touch anything else. Good luck!
A=importdata('Multisim_Tf_Data.txt');
Output_CW = A.data(:,1);
Output_CCW = A.data(:,2);
Input = 5.0*ones(length(Output_CW),1);
Data_CW = iddata(Output_CW,Input,1e-08);
Data_CCW = iddata(Output_CCW,Input,1e-08);
Amp_tf_CW = tfest(Data_CW,2,0)
Amp_tf_CCW = tfest(Data_CCW,2,0)
%Mechanical Model Specs
%First Motor (22S - 24V)
L1=0.000231;
R1=3.69;
Km1=0.0184;
J1=5.55e-07;
B1=5.087e-07;
Kb1=0.0184;
Va = 24;
%Second Motor (22S - 24V)
L2=L1;
R2=R1;
Km2=Km1;
J2=J1;
B2=B1;
Kb2=Kb1;
%Third Motor (22S - 24V)
L3=L1;
R3=R1;
Km3=Km1;
J3=J1;
B3=B1;
Kb3=Kb1;
%Fourth Motor (22S - 24V)
L4=L1;
R4=R1;
Km4=Km1;
J4=J1;
B4=B1;
Kb4=Kb1;
%Motor Angles
%Drop1:
Motor1_D1=0;
Motor2_D1=0;
Motor3_D1=0;
%Drop2:
Motor1_D2=-40.3;
Motor2_D2=-8.77;
Motor3_D2=31.53;
%Drop3:
Motor1_D3=-59.87;
Motor2_D3=-0.54;
Motor3_D3=59.33;
%Marshmallow1:
Motor1_M1=37.08;
Motor2_M1=67.12;
Motor3_M1=30.03;
%Marshmallow2:
Motor1_M2=19.37;
Motor2_M2=61.35;
Motor3_M2=41.98;
%Marshmallow3:
Motor1_M3=8.37;
Motor2_M3=66.45;
Motor3_M3=58.08;
%Motor 4 (Gripper)
Motor4_Open=0;
Motor4_Closed=90;
%Motor Move Times:
Move_Time = 0.007;
M1_Time = Move_Time;
M1_Close = M1_Time + Move_Time;
D1_Time = M1_Close + Move_Time;
D1_Open = D1_Time + Move_Time;
M2_Time = D1_Open + Move_Time;
M2_Close = M2_Time + Move_Time;
D2_Time = M2_Close + Move_Time;
D2_Open = D2_Time + Move_Time;
M3_Time = D2_Open + Move_Time;
M3_Close = M3_Time + Move_Time;
D3_Time = M3_Close + Move_Time;
%ISR Rate
Sample_Time = 10000;
%Optical Encoder Resolution
res = 2*pi/1024;
%Calculating rlocus
tf1=tf([1],[L1 R1]);
tf2=tf([1],[J1 B1]);
G = tf1*tf2*Km1;
H = Kb1;
Motor_tf = feedback(G,H)
rad_tf = tf([1],[1 0]);
sys = Amp_tf_CW*Motor_tf*rad_tf;
z1=3.056+17.33*i;
z2=3.056-17.33*i;
control=tf([1 0 309.76],[1 5000 0]);
sys1=sys*control
rlocus(sys1)
%margin(sys1)
Ku = 2162;
K = Ku*10/100;
Ki = K*z1*z2/5000;
Kp = (K*(z1+z2)-Ki)/5000;
Kd = (K-Kp)/5000;

