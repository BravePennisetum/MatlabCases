function [xn2_x,yy2,xi,ff]=signal_probability_density2(data,n)
%  �����ź����ݵĸ����ܶȺ���������ֱ��ͼ������ͼ
%  ���룺
%     data���������ź�
%     Fs��������Ƶ��
%  �����
%     xn2_x��������ĺ�����
%     yy2���������pdfֵ
%     xi����ͨ��ksdensity()����������ĸ����ܶȺ�����
%     ff����ͨ��ksdensity()����������ĸ����ܶ�pdfֵ

%  Jialong Song
%  E-mail:jlsong20601@163.com

xn_Max=max(data);
xn_Min=min(data);
xn_mean=mean(data);
step=n;
xn2_x=linspace(xn_Min,xn_Max,step);
yy1=hist(data,xn2_x);  %�����������ĸ���
yy2=yy1/length(data); %�����������ı���

%bar(xn2_x,yy2,'g');
% hold on
% grid on



[ff,xi] = ksdensity(data);

plot(xn2_x,yy2,'-b');
%axis([0,0.5,0,0.5]);
% hold on
% plot(xi,ff,'*b','LineWidth',2);
% hold off;
%plot(xn2_x,yy2,'r-',xi,ff,'*b');

%ת��Ϊ������
xn2_x=xn2_x';
yy2=yy2';
xi=xi';
ff=ff';
end