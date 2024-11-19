function D1y = dySystem(t,y,Paras)
% 小车运动微分方程

%% 定义函数输出
D1y=zeros(2,1);

%% 变量拆分
Displacement=y(1);
Velocity=y(2);

%% 计算合外力
FR=funcPID(Paras.ExpectedVelocity,Velocity)-Paras.Cf*Velocity*Velocity;

%% 小车运动方程
D1y(1)=Velocity;
D1y(2)=FR/Paras.M;

end