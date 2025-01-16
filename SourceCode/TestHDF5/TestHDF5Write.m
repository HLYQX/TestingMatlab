clear;clc;close all;
% 测试MATLAB写HDF5文件

%% 生成待写的数据
NumRows=6;
NumCols=4;
NumFrames=3;
NumTimeSteps=2;

MatWriteDim4=zeros(NumRows,NumCols,NumFrames,NumTimeSteps);
for t=1:NumTimeSteps
    for z=1:NumFrames
        for x=1:NumRows
            for y=1:NumCols
                % 存入数据的小数点前为帧数，小数点后依次为x、y、z坐标
                MatWriteDim4(x,y,z,t)=t*1E0+x*1E-1+y*1E-2+z*1E-3;
            end
        end
    end
end
MatWriteDim3=zeros(NumRows,NumCols,NumTimeSteps);
for t=1:NumTimeSteps
    for x=1:NumRows
        for y=1:NumCols
            % 存入数据的小数点前为帧数，小数点后依次为x、y坐标
            MatWriteDim3(x,y,t)=t*1E0+x*1E-1+y*1E-2;
        end
    end
end
MatWriteDim2=zeros(NumRows,NumCols);
for x=1:NumRows
    for y=1:NumCols
        % 存入数据的小数点后依次为x、y坐标
        MatWriteDim2(x,y)=x*1E-1+y*1E-2;
    end
end

% 数据的维度数
Rank4=ndims(MatWriteDim4);
Rank3=ndims(MatWriteDim3);
Rank2=ndims(MatWriteDim2);

%% 覆盖写入
H5FileName="H5FileMatlab.h5";
if exist(H5FileName,'file')
    delete(H5FileName);
end

%% 写入H5文件
% Dim4
H5GroupName1="MatWriteDim4";
H5GroupName2="Dim4";
H5DataSetName="Mat";
H5DataSetFullName=strjoin(["",H5GroupName1,H5GroupName2,H5DataSetName],"/");
% 因Matlab"列"优先，H5"行"优先
% 采用permute函数交换维度顺序，使得存入H5的数据符合H5的维度顺序
H5DataWrite=permute(MatWriteDim4,Rank4:-1:1);
H5DataSpace=size(H5DataWrite);
% 创建DataSpace并写入
h5create(H5FileName,H5DataSetFullName,H5DataSpace)
h5write(H5FileName,H5DataSetFullName,H5DataWrite);

% Dim3
H5GroupName1="MatWriteDim3";
H5GroupName2="Dim3";
H5DataSetName="Mat";
H5DataSetFullName=strjoin(["",H5GroupName1,H5GroupName2,H5DataSetName],"/");
% 因Matlab"列"优先，H5"行"优先
% 采用permute函数交换维度顺序，使得存入H5的数据符合H5的维度顺序
H5DataWrite=permute(MatWriteDim3,Rank3:-1:1);
H5DataSpace=size(H5DataWrite);
% 创建DataSpace并写入
h5create(H5FileName,H5DataSetFullName,H5DataSpace)
h5write(H5FileName,H5DataSetFullName,H5DataWrite);

% Dim2-写入一个矩阵序列
H5GroupName1="MatWriteDim2";
H5GroupName2="Dim2";
for i=1:2
    H5DataSetName="Mat"+num2str(i);
    H5DataSetFullName=strjoin(["",H5GroupName1,H5GroupName2,H5DataSetName],"/");
    % 因Matlab"列"优先，H5"行"优先
    % 采用permute函数交换维度顺序，使得存入H5的数据符合H5的维度顺序
    H5DataWrite=permute(MatWriteDim2(1:NumRows/i,1:NumCols/i),Rank2:-1:1);
    H5DataSpace=size(H5DataWrite);
    % 创建DataSpace并写入
    h5create(H5FileName,H5DataSetFullName,H5DataSpace)
    h5write(H5FileName,H5DataSetFullName,H5DataWrite);
end
