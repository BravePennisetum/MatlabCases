function average_cycle_time_t = calcualte_average_cycle_time(xn,Fs)
%  �����źŵ�ƽ��ѭ��ʱ�䣬ͨ������ѹ��ʱ�������д�����ƽ��ֵ�Ĵ�����ȷ��
%  ����ͨ����ͨ�˲����й��˴���

%  xn����ԭʼ����
%  Fs��������Ƶ��

%  �ο����ף�Time-series analysis of pressure fluctuations in gas -solid fluidized beds - Areview,van Ommen,2011
%  Jialong Song
%  E-mail:jlsong20601@163.com

data=xn-mean(xn);
cross_mean_line_points=0;
N=length(xn);

for i=1:(N-1),
    if (data(i)*data(i+1)==0)||(data(i)*data(i+1)<0)
        cross_mean_line_points=cross_mean_line_points+1;
    end
end

average_cycle_time_t=(N-1)/(Fs*cross_mean_line_points);%ƽ��ѭ��ʱ��

end