clear;clc;close all;
% 测试ode45
% 物体有初始速度和位移，阻力和速度平方有关，随时间慢慢静止
% 还有一个正弦分量

%% 设置ode设置
Opts=odeset('Stats','on',...            % 求解器统计信息
            'InitialStep',1E-6,...      % 建议的初始步长
            'MaxStep',2E-1,...          % 最大步长
            'RelTol',1E-6,...           % 相对误差容限 |e(i)| <= max(RelTol*abs(y(i)),AbsTol(i))
            'AbsTol',1E-8,...           % 绝对误差容限 |e(i)| <= max(RelTol*abs(y(i)),AbsTol(i))
            'NormControl','on',...      % 根据范数控制容差而不是解的绝对值 norm(e(i)) <= max(RelTol*norm(y(i)),AbsTol(i))
            'Refine',6,...              % 解细化因子，决定每步中应增加的输出点数
            'NonNegative',[2 3],...     % 指定解向量的第2、3个数(速度和正弦分量)必须为非负数
            'OutputFcn',@outputOde45,...% 输出函数，@odeplot为内置函数，绘出所有解分量-时间曲线
            'OutputSel',[1 2 3],...     % 输出函数的分量选择，这里将解向量的全部分量输出给了OutputFcn
            'Events',@eventsOde45...    % 事件函数，记录、控制积分是否停止
            );

%% 给定常数
Const.Cf=1.0;
Const.S=pi*1^2;

%% 设置求解域和初值
tspan=[0,10];
y0=[-2,2,2.2];% [l v sin]

%% 求解
% 匿名函数 返回单个输出，参数列表为@(t,y)，但可以将Const结构体传入函数
[t,y,te,ye,ie]=ode45(@(t,y) dyOde45(t,y,Const),tspan,y0,Opts);

%% 中间量求值
% 积分后再Evaluate的最简单的方式，对元胞数组中的每个元胞应用函数
% 这种方式本质上还是计算完成后通过得到的解"还原"一遍中间量
[~,ExtraOut1,ExtraOut2]=cellfun(@(t,y) dyOde45(t,y,Const),...
    num2cell(t), num2cell(y,2),...% 创建一个 2×1 元胞数组
    'UniformOutput',false);     % true-必须返回标量，由 cellfun 串联成数组
                                % false-以元胞数组的形式返回输出，输出可以具有任意大小和不同的数据类型。
ExtraOut2=cell2mat(ExtraOut2);  % 元胞数组转数值矩阵
