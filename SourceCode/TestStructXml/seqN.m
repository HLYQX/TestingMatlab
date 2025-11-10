function Seq = seqN(BeginIndex,Size,Increment)
% Sequence of %{Size}% integers starting from %{BeginIndex}% and using %{Increment}% to advance form one index to the next.
if nargin==2
    Increment=1;
end
    Seq=BeginIndex:Increment:BeginIndex+(Size-1)*Increment;
end