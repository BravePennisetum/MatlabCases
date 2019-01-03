function [I,Y,diff_Y_I,Lyapunov1_2,Lyapunov1_e]=Largest_Lyapunov_Rosenstein2(data,fs,t,d,tmax,p)
% �������ʱ������ Lyapunov ָ�� - Logistic ����
% ���� Henon ӳ�� x(n+1) = 1 - a * x(n)^2 + y(n); y(n+1) = b * x(n)
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% clc
% clear all
% close all

% disp('********** Logistic ***********')

%-----------------------------------------------------------------
% % ���� Logistic ����ʱ������
% 
% lambda = 4;
% x = 0.1;
% 
% k1 = 400;                   % ǰ��ĵ�������
% k2 = 3000;                 % ����ĵ�������
% 
% f = zeros(k1+k2,length(lambda));
% for i = 1:k1+k2
%     x = lambda .* x .* (1 - x);
%     f(i,:) = x;
% end
% X = f(k1+1:end,:);

%-----------------------------------------------------------------
% Henon ��ڲ���
X=data;

%-----------------------------------------------------------------
% ���ü��㺯��

tic
Y = Lyapunov_rosenstein_2(X,fs,t,d,tmax,p);
t = toc

I = [0:length(Y)-1]';

linear = [1:5]';  % ��������,����Χ��Ҫ�޸�
F1 = polyfit(I(linear),Y(linear),1);%б��
Y1 = polyval(F1,I(linear),1);%������ϵ�ֱ�ߣ�������Ϊ��I(linear)

%-----------------------------------------------------------------
% �����ʾ

figure
subplot(211); 
plot(I,Y,'k.-'); 
grid; 
xlabel('i'); 
ylabel('y(i)'); 
hold on;
plot(I(linear),Y1,'r-'); 
hold off;

Y_I=[I,Y];

subplot(212); 
plot(I(1:end-1),diff(Y),'k.-'); 
grid; 
xlabel('n'); 
ylabel('slope');

diff_Y=diff(Y);
diff_Y_I=[I(1:end-1),diff_Y];

Lyapunov1_2 = F1(1),
Lyapunov1_e = F1(1)*log(2),
