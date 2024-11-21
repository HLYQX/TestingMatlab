clear;clc;close all;
% 测试parfor

%% 开启parpool
NumCores=feature('NumCores');
if isempty(gcp('nocreate'))
    parpool(NumCores);
end

%% 生成WaitBar
HandleWaitBars=cell(NumCores,1);
for i=1:NumCores
    HandleWaitBars{i}=waitbar(0,['No. ',num2str(i),' is processing'],Name=num2str(i),WindowStyle="docked");
end

%% 定义消息队列
QueueMessage=parallel.pool.DataQueue;

%% 定义消息处理函数
afterEach(QueueMessage, @(Message) updateWaitBar(Message,HandleWaitBars));

%% 并行计算
parfor i=1:NumCores
    Process=0;
    send(QueueMessage,[i,Process]);
    while(Process<1)
        pause(0.9); % Do something
        Process=Process+0.15;
        send(QueueMessage,[i,Process]);
    end
end

%% CMD启动时关闭并行池
if batchStartupOptionUsed
    delete(gcp);
end
