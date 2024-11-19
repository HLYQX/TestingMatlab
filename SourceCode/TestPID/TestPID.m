clear;clc;close all;
% 尝试PID控制算法

%% 问题设定
% 小车质量为10kg, 从0开始加速, 希望其车速保持100m/s
% 阻力项Fr=Cf*v*v
% 控制系统输入实际车速, 输出牵引力(存在上下限)
Paras.M=10;
Paras.Cf=0.1;
Paras.ExpectedVelocity=10;
Paras.InitialDisplacement=0;
Paras.InitialVelocity=0;

%% 计算
TSpan=[0 10];
Y0=[Paras.InitialDisplacement,Paras.InitialVelocity];
CalcStep=0.05;
[Time,Results]=ode4(@(t,y)dySystem(t,y,Paras),TSpan,Y0,CalcStep);

%% 结果后处理
HandleFigure=figure(Name='TestPID',...
    Position=[80 10 1920/1.5 1080/1.5]);
hold on;
plot(Time,Results(:,2),LineWidth=2,Color='b');
plot(Time,Paras.ExpectedVelocity*ones(length(Results(:,2))),LineWidth=1.5,Color='r',LineStyle='--');
ylim([0 2*Paras.ExpectedVelocity]);
legend('ActualVelocity','ExpectedVelocity');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity-Time')

set(findall(HandleFigure,'Type','Axes'),'fontsize',20,'fontname','Times New Roman');

