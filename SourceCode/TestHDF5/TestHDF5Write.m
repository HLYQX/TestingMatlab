clear;clc;close all;
% 测试MATLAB写HDF5文件

%% 生成待写的数据
NumRows=6;
NumCols=5;
NumFrames=4;
NumTimeSteps=3;
Rank4=4;
Rank3=3;
Rank2=2;

MatWriteDim4=zeros(NumRows,NumCols,NumFrames,NumTimeSteps);
MatWriteDim3=zeros(NumRows,NumCols,NumFrames);
MatWriteDim2=zeros(NumRows,NumCols);

