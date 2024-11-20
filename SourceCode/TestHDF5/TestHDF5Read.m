clear;clc;close all;
% 测试MATLAB读HDF5文件

%% 不存在则先行写入
H5FileName="H5FileMatlab.h5";
if ~exist(H5FileName,'file')
    TestHDF5Write();
    clearvars -except H5FileName;
end

%% 读取H5文件
% Dim4
H5GroupName1="MatWriteDim4";
H5GroupName2="Dim4";
H5DataSetName="Mat";
H5DataSetFullName=strjoin(["",H5GroupName1,H5GroupName2,H5DataSetName],"/");
H5DataWrite4=h5read(H5FileName,H5DataSetFullName);
% 因Matlab"列"优先，H5"行"优先
% 采用permute函数交换维度顺序，使得从H5读取的数据符合Matlab的维度顺序
Rank=ndims(H5DataWrite4);
H5DataWrite4=permute(H5DataWrite4,Rank:-1:1);
for t=1:size(H5DataWrite4,Rank)
    for z=1:size(H5DataWrite4,Rank-1)
        for x=1:size(H5DataWrite4,1)
            for y=1:size(H5DataWrite4,2)
                % 存入数据的小数点前为帧数，小数点后依次为x、y、z坐标
                disp(['t=',num2str(t),' x=',num2str(x),' y=',num2str(y),' z=',num2str(z)]);
                disp(['Value=',num2str(H5DataWrite4(x,y,z,t))]);
                disp(newline);
            end
        end
    end
end



% Dim3
H5GroupName1="MatWriteDim3";
H5GroupName2="Dim3";
H5DataSetName="Mat";
H5DataSetFullName=strjoin(["",H5GroupName1,H5GroupName2,H5DataSetName],"/");
H5DataWrite3=h5read(H5FileName,H5DataSetFullName);
% 因Matlab"列"优先，H5"行"优先
% 采用permute函数交换维度顺序，使得从H5读取的数据符合Matlab的维度顺序
Rank=ndims(H5DataWrite3);
H5DataWrite3=permute(H5DataWrite3,Rank:-1:1);
for t=1:size(H5DataWrite3,Rank)
    for x=1:size(H5DataWrite3,1)
        for y=1:size(H5DataWrite3,2)
            % 存入数据的小数点前为帧数，小数点后依次为x、y、z坐标
            disp(['t=',num2str(t),' x=',num2str(x),' y=',num2str(y)]);
            disp(['Value=',num2str(H5DataWrite3(x,y,t))]);
            disp(newline);
        end
    end
end


% Dim2-读取一个矩阵序列
H5GroupName1="MatWriteDim2";
H5GroupName2="Dim2";
for i=1:2
    H5DataSetName="Mat"+num2str(i);
    H5DataSetFullName=strjoin(["",H5GroupName1,H5GroupName2,H5DataSetName],"/");
    H5DataWrite2{i}=h5read(H5FileName,H5DataSetFullName);
    % 因Matlab"列"优先，H5"行"优先
    % 采用permute函数交换维度顺序，使得从H5读取的数据符合Matlab的维度顺序
    Rank=ndims(H5DataWrite2{i});
    H5DataWrite2{i}=permute(H5DataWrite2{i},Rank:-1:1);
end
