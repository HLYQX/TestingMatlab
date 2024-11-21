function updateWaitBar(Message,HandleWaitBars)
%% 更新waitbar

%% 分离消息
i=Message(1);
Process=Message(2);
Handle=HandleWaitBars{i};

%% 更新waitbar
if Process==0
    waitbar(0.1,Handle);
elseif Process>=1
    close(Handle)
else
    waitbar(Process,Handle);
end

end