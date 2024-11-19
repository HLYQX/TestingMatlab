function Fd = funcPID(ExpectedVelocity,ActualVelocity)
% PID控制函数, 输出小车牵引力

%% 变量定义
% 静态变量
persistent LastError;
persistent IntegralError;
if isempty(IntegralError)
    IntegralError=0;
end
% 控制参数
Kp=25;
Ki=10;
Kd=20;

%% 计算误差
Error=ExpectedVelocity-ActualVelocity;
LastError=Error;
IntegralError=IntegralError+Error*0.05;

%% 计算输出的牵引力
Fd=Kp*Error;                        % 比例
Fd=Fd+Kd*(Error-LastError)/0.05;    % 微分
Fd=Fd+Ki*IntegralError;             % 积分

%% 牵引力上下限
if Fd<-100
    Fd=-100;
elseif Fd>100
    Fd=100;
end
%% 打印
disp(['Fd=',num2str(Fd)])
end