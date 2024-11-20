function [Dy,ExtraOutSt,ExtraOut]=dyOde45(t,y,Const)
%% ODEs
% 持久变量(相当于静态变量)，可用于那些需要上一时刻量的ODE
persistent lEx;
if isempty(lEx)
    lEx = 0;    % 初始化
end

% Init
Dy=zeros(length(y),1);
% Constant
Cf=Const.Cf;
S=Const.S;
% Distribute
l=y(1);
v=y(2);
Sin=y(3);


% 假设要保存两组中间变量
% 第1组为t-l-v-f-dl组成的结构体数组
% 第2组为它们的数值矩阵
% 注意额外的输出应放在第1个dy之后
% 因为matlab多输出函数在调用时若只有一个返回值，则会返回第一个数
f=-0.5*Cf*S*v^2;

ExtraOutSt.t=t;
ExtraOutSt.l=l;
ExtraOutSt.v=v;
ExtraOutSt.f=f;
ExtraOutSt.dl=l-lEx;

ExtraOut(1)=t;
ExtraOut(2)=l;
ExtraOut(3)=v;
ExtraOut(4)=f;
ExtraOut(5)=l-lEx;

lEx=l; % 存入当前时刻的l用于下一时刻dl的计算

% Evaluate
dldt=v;
dvdt=f;
% Collect
Dy(1)=dldt;
Dy(2)=dvdt;
Dy(3)=cos(t);

end
