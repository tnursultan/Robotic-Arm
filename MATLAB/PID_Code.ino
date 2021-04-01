function Output = PID(error)

persistent ept              %holds the exponentials
persistent results          %holds reccorded derivatives
persistent previous_error   %holds input from last execution for derivative calc
persistent integral         %holds the total integral
CF = 10000;                 %ISR frequency
delta_t = 1/CF;             %Will change according to CF, sampling time
size = 8;                   %can change between 5-10
n = 4;                      %Decaying until n*tau, can be 4 or 5
pole = n*CF/size;
P_gain = 3.1;
D_gain = 0.1;
I_gain = 0.1;

%initialize vectors and variables
if isempty(results)
    results = zeros(1,size);
    ept = zeros(1,size);
    sum = 0;
    integral = 0;
    previous_error = 0;
    
    %calculate scale factor for derivative
    for i = 1:size
        sum = sum + pole*exp(-pole*i*delta_t);
    end
    Scale_Factor = 1/(sum);
    
    %properly create ept
    for i = 1:size
        ept(i) = Scale_Factor*pole*exp(-pole*i*delta_t);
    end
end

%Calculating the D(Derivative) of PID
results(2:size)=results(1:size-1);
results(1)=(error - previous_error)/delta_t;
previous_error = error;
derivative = dot(results,ept);

%Calculating the I(Integral) of PID
integral = integral + (error + previous_error)/2*delta_t;

%Calculating the P(Proportional) of PID
proportional = error*P_gain;

Output = proportional + I_gain*integral + D_gain*derivative;
