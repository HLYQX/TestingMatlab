clear;clc;close all
% 测试MATLAB修改xml文件

%% xml文件名称
XMLName="XmlWrite.xml";

%% 重新调写入脚本防止出错
TestXmlWrite();
clearvars -except XMLName;

%% 获取文件节点对象
DocEle=xmlread(XMLName);

%% 获取xml文件根节点
RootEle=DocEle.getDocumentElement();

%% 修改子节点2
ChildEle2=RootEle.getElementsByTagName("ChildEle2").item(0);
% 打印节点名称
disp(['TagName = ',char(ChildEle2.getTagName())]);
% 获取属性值
ChildEle2.setAttribute('ToBeModified','HasBeenModified');
disp(['ToBeModified = ',char(ChildEle2.getAttribute("ToBeModified"))]);
% 修改节点值-两种方式（都须是字符串类型）
% 方式一:setNodeValue()
ChildEle2.getFirstChild().setNodeValue('This is Child 2 but has been modified with setNodeValue()');
disp(['TextContent = ',char(ChildEle2.getTextContent())]);
% 方式二:setTextContent()
ChildEle2.setTextContent('This is Child 2 but has been modified with setTextContent()');
disp(['TextContent = ',char(ChildEle2.getTextContent())]);

%% 删除子节点3
ChildEle3=RootEle.getElementsByTagName("ChildEle3").item(0);
% 移除节点
RootEle.removeChild(ChildEle3);

%% 将修改写入xml文件
xmlwrite(XMLName,DocEle);
