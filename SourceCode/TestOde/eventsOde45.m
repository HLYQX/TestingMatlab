function [Triggerposition,Isterminal,Direction] = eventsOde45(t,y)
%% Events
Triggerposition = [y(1);y(2)-1;y(3)]; % Event triggered if value is 0
Isterminal = [1;0;0];              % Halt integration if 1
Direction = [1;-1;0];              % The Triggerposition can be approached from either direction if 0
                                 % Negative direction only if -1 (Equivalent to derivative)
                                 % Positive direction only if 1 (Equivalent to derivative)

end
