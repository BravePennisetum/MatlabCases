function [data] = pressure_increments(xn,Fs,delay_time)
%�����źŵ�����
%  xn����ԭʼ����
%  Fs��������Ƶ��
%  N_step���������ź�����ʱ�ļ��
%  data�������������ź���������

%  �ο����ף�Time-series analysis of pressure fluctuations in gas -solid fluidized beds - Areview,van Ommen,2011
%  Jialong Song
%  E-mail:jlsong20601@163.com

N=length(xn);
dt=1/Fs;%�������
N_delay=floor(delay_time/dt); %�ӳٲ���,����ȡ��
data=[];

for i=1:(N-N_delay),
    delta=xn(i+N_delay)-xn(i);
    data=[data;delta];
end
end