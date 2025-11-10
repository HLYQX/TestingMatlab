clear;clc;close all
% 测试MATLAB的xml与Struct之间的交互

%% 判断xml是否存在，否则先写入xml
if ~exist('Struct2Xml.xml','file')
    TestStruct2Xml();
end

%% xml文件名称
XMLName = 'Struct2Xml.xml';

%% 读取xml
FEM_Sys = readstruct(XMLName,'AttributeSuffix','_Attr');

%% 数据类型转换
% 节点
for i=1:length(fieldnames(FEM_Sys.Nodes))
    NodeName = strcat('Node',num2str(i));
    FEM_Sys.Nodes.(NodeName).IDSysMat = str2num(FEM_Sys.Nodes.(NodeName).IDSysMat);
    FEM_Sys.Nodes.(NodeName).Coordinates = str2num(FEM_Sys.Nodes.(NodeName).Coordinates)';
end

% 单元
for i=1:length(fieldnames(FEM_Sys.Elements))
    EleName = strcat('Ele',num2str(i));
    FEM_Sys.Elements.(EleName).IDSysMat = str2num(FEM_Sys.Elements.(EleName).IDSysMat);
end
