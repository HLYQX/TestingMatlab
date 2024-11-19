clear;clc;close all
% 测试MATLAB读xml文件

%% xml文件名称
XMLName="XmlWrite.xml";

%% 获取文件节点对象
DocEle=xmlread(XMLName);

%% 获取xml文件根节点
RootEle=DocEle.getDocumentElement();

%% 获取子节点1
% 返回了一个节点列表，仅取第一个（此例也仅有一个），相当其他语言中的firstChildElement("ChildEle1")
ChildEle1=RootEle.getElementsByTagName("ChildEle1").item(0);
% 获取节点名称
disp(['TagName = ',char(ChildEle1.getTagName())]);
% 获取属性值
disp(['Self = ',char(ChildEle1.getAttribute("Self"))]);
% 得到的字符串转数字
Num=str2double(ChildEle1.getAttribute("Self_Num"));
disp(['Self_Num = ',num2str(Num)]);
% 输出空行
disp(newline);

%% 获取子子节点1
ChildChildEle1=ChildEle1.getElementsByTagName("ChildChildEle1").item(0);
ChildChildEle1=ChildEle1.getFirstElementChild();
% 获取节点名称
disp(['TagName = ',char(ChildChildEle1.getTagName())]);
% 获取属性值
disp(['Self = ',char(ChildChildEle1.getAttribute("Self"))]);
% 获取节点值
disp(['Self = ',char(ChildChildEle1.getTextContent())]);
% 输出空行
disp(newline);

%% 获取子节点2
ChildEle2=RootEle.getElementsByTagName("ChildEle2").item(0);
% 获取节点名称
disp(['TagName = ',char(ChildEle2.getTagName())]);
% 获取属性值
disp(['ToBeModified = ',char(ChildEle2.getAttribute("ToBeModified"))]);
% 获取节点值
disp(['TextContent = ',char(ChildEle2.getTextContent())]);
% 输出空行
disp(newline);

%% 获取子节点3
ChildEle3=RootEle.getElementsByTagName("ChildEle3").item(0);
% 获取节点名称
disp(['TagName = ',char(ChildEle3.getTagName())]);
% 获取属性值
disp(['ToBeRemoved = ',char(ChildEle3.getAttribute("ToBeModified"))]);
% 获取节点值
% 需要转置，否则列优先
Mat=transpose(reshape(str2num(ChildEle3.getTextContent()),[3 3]));
disp(['TextContent = ',mat2str(Mat)]);
% 输出空行
disp(newline);

