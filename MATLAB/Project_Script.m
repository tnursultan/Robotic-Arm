A=importdata('Multisim_Tf_Data.txt');
Output_CW = A.data(:,1);
Output_CCW = A.data(:,2);
Input = 5.0*ones(length(Output_CW),1);
Data_CW = iddata(Output_CW,Input,1e-08);
Data_CCW = iddata(Output_CCW,Input,1e-08);
Amp_tf_CW = tfest(Data_CW,2,0)
Amp_tf_CCW = tfest(Data_CCW,2,0)
step(Amp_tf_CW)
hold on
step(Amp_tf_CCW)
%L=0.000535;
%R=8.94;
%Km=0.028;
%J=5.44e-07;
%B=5.1284e-07;
%Kb=2.7922e-02;
%Va = 36;
%tf1=tf([1],[L R]);
%tf2=tf([1],[J B]);
%G = tf1*tf2*Km;
%H = Kb;
%Motor_tf = feedback(G,H)
%rad_tf = tf([1],[1 0]);
%sys = Amp_tf*Motor_tf*rad_tf;
%rlocus(sys);
%Ku = 62.4;