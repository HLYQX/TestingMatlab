clear;clc;close all
% 测试MATLAB写xml文件

%% xml文件名称
XMLName="XmlWrite.xml";

%% 文件节点对象
DocEle=com.mathworks.xml.XMLUtils.createDocument('Root');

%% xml文件根节点
RootEle=DocEle.getDocumentElement();

%% 子节点1
% 从文件对象创建节点
ChildEle1=DocEle.createElement("ChildEle1");
% 设置属性
ChildEle1.setAttribute("Self","ChildEle1");
ChildEle1.setAttribute("Self_Num","1.0");% 属性的值须为字符串
% 将子节点1添加到根节点
RootEle.appendChild(ChildEle1);

%% 子子节点1
% 从文件对象创建节点
ChildChildEle1=DocEle.createElement("ChildChildEle1");
% 设置属性
ChildChildEle1.setAttribute("Self","ChildChildEle1");
% 添加文本节点
ChildChildEle1.appendChild(DocEle.createTextNode("This is ChildChildEle1"));
% 将子子节点1添加到子节点1
ChildEle1.appendChild(ChildChildEle1);

%% 子节点2
% 从文件对象创建节点
ChildEle2=DocEle.createElement("ChildEle2");
% 设置属性
ChildEle2.setAttribute("ToBeModified","HasNotBeenModified");
% 添加文本节点
ChildEle2.appendChild(DocEle.createTextNode("This is ChildEle2"));
% 将子节点2添加到根节点
RootEle.appendChild(ChildEle2);

%% 子节点3
% 从文件对象创建节点
ChildEle3=DocEle.createElement("ChildEle3");
% 设置属性
ChildEle3.setAttribute("ToBeRemoved","HasNotBeenRemoved");
% 添加文本节点-3*3矩阵须先转化为字符串
A=rand(3,3)                   % 数值矩阵
A=A';                         % A(:)为列优先，要先转置
AChar=num2str(A(:));          % 字符数组，
AStrArray=string(AChar);      % 字符串数组
AStr=strjoin(AStrArray,",");  % 字符串-用逗号连接字符串数组
ChildEle3.appendChild(DocEle.createTextNode(AStr));
% 将子节点3添加到根节点
RootEle.appendChild(ChildEle3);

%% 写入xml文件
xmlwrite(XMLName,DocEle);
