
% C-C�����ع���ռ� - ������
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½��
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���41670240@qq.com
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% clc
% clear all
% close all

%--------------------------------------------------------------------------
X=xn;

maxLags = 20;      % ���ʱ��

%--------------------------------------------------------------------------
% ����
tic
[S_mean,delta_S_mean,S_cor] = CC_luzhenbo(X,maxLags);
toc

%--------------------------------------------------------------------------
% �����ͼ

figure    
subplot(311)
plot(1:maxLags,S_mean); grid; title('S mean')
subplot(312)
plot(1:maxLags,delta_S_mean); grid; title('delta S mean')
subplot(313)
plot(1:maxLags,S_cor); grid; title('S cor')
