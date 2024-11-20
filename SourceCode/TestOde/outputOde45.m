function Status = outputOde45(t,y,flag)
%% 输出函数

% 图窗句柄
persistent HF;

% 必须返回 0 或 1。如果 status = 1，求解器会停止积分，可使用此机制实现停止
switch flag
    % 求解器在积分开始前调用 outputOde45([tspan(1) tspan(end)],y0,'init')
    % 以便允许初始化输出函数。tspan 和 y0 是 ODE 求解器的输入参数
    case 'init'
        Status=0;
        HF=figure();

        fprintf("time = %+.4fs \t",t(1));
        SingleStr="%+.4f";
        YStr='y= '+strjoin(repmat(SingleStr,[1 length(y)]),', ')+'\n';

        fprintf(YStr,y);

    % t 包含在步长执行过程中生成输出的点，y 是这些点在 t 中的数值解。
    % 如果 t 为向量，则 y 的第 i 个列与 t 的第 i 个元素相对应。
    % 如果ode入参length(tspan) > 2，将在 tspan 中的每个点生成输出。
    % 如果ode入参length(tspan) = 2，将根据 Refine 选项生成输出。
    case ''
        Status=0;

        SingleStr="%+.4f";
        YStr='y= '+strjoin(repmat(SingleStr,[1 length(y(:,1))]),', ')+'\n';
        for i=1:length(t)
            fprintf("time = %+.4fs \t",t(i));
            fprintf(YStr,y(:,i));
        end
        % 让输出慢一点
        pause(1E-3);
    % 积分完成后，求解器调用 outputOde45([],[],'done') 以便允许输出函数执行清除任务。
    case 'done'
        Status=0;
        pause(1);
        close(HF); % 关闭odeplot产生的图窗
end
% 调用内置绘图函数
odeplot(t,y,flag);

end