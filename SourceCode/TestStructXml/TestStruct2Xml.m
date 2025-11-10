clear;clc;close all
% 测试MATLAB的xml与Struct之间的交互

%% xml文件名称
XMLName = 'Struct2Xml.xml';

%% Struct对象定义
EleNum=20;
NodeNum=EleNum+1;

% 节点
for i=1:NodeNum
    NodeName = strcat('Node',num2str(i));
    Sys.Nodes.(NodeName) = struct('ID_Attr',-1,...
        'DOF_Attr',-1,...
        'IDSysMat',-1,...
        'Coordinates',-1);
end
IndexSysMat=1;
for i=1:NodeNum
    NodeName = strcat('Node',num2str(i));
    Sys.Nodes.(NodeName).ID_Attr = i;
    Sys.Nodes.(NodeName).DOF_Attr = 6;
    Sys.Nodes.(NodeName).Coordinates = num2str([0.1*(Sys.Nodes.(NodeName).ID_Attr-1);0;0]');
    % 节点所对应的系统矩阵中的列索引
    Sys.Nodes.(NodeName).IDSysMat = num2str(seqN(IndexSysMat,Sys.Nodes.(NodeName).DOF_Attr));

    IndexSysMat = IndexSysMat+Sys.Nodes.(NodeName).DOF_Attr;
end

% 单元
for i=1:EleNum
    EleName = strcat('Ele',num2str(i));
    Sys.Elements.(EleName) = struct('ID_Attr',-1,...
        'EleType_Attr',-1,...
        'NodeI',-1,...
        'NodeJ',-1,...
        'IDSysMat',-1);
end
for i=1:EleNum
    EleName = strcat('Ele',num2str(i));
    Sys.Elements.(EleName).ID_Attr = i;
    Sys.Elements.(EleName).NodeI = i;
    Sys.Elements.(EleName).NodeJ = i+1;
    Sys.Elements.(EleName).EleType_Attr = 'SpatialBeam';
    % 单元所对应的系统矩阵中的列索引
    NodeIName = strcat('Node',num2str(Sys.Elements.(EleName).NodeI));
    NodeJName = strcat('Node',num2str(Sys.Elements.(EleName).NodeJ));
    Sys.Elements.(EleName).IDSysMat =...
        [Sys.Nodes.(NodeIName).IDSysMat,'  ',...
        Sys.Nodes.(NodeJName).IDSysMat];
end

%总自由度
Sys.TotalDOF = IndexSysMat;

%% 写入xml
% Sys = orderfields(Sys);
writestruct(Sys,XMLName,...
    'FileType','xml',...
    'AttributeSuffix','_Attr',...
    'StructNodeName','FEM_Sys')
