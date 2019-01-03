function [whole_cycle_time_sum,half_cycle_time_sum] = cycle_time_distribution(xn,Fs)
%����ʱ�����е�ѭ��ʱ��ֲ�
%  xn����ԭʼ����
%  Fs��������Ƶ��

%  �ο����ף�Time-series analysis of pressure fluctuations in gas -solid fluidized beds - Areview,van Ommen,2011
%  Jialong Song
%  E-mail:jlsong20601@163.com

%%
data=xn-mean(xn);%��������251*1���������
N=length(data);%���ݳ���ΪN
dt=1/Fs;%�������
diff_data=diff(xn);%���ݳ���Ϊ(N-1),��������250*1

for cycle_time=1:1,
    whole_cycle_time=1;%��������ѭ��ʱ��
    half_cycle_time=1;%������ѭ��ʱ��
end

%%
whole_num_i=0;  %�ź�ѭ���Ĵ�����ʼ��Ϊ0
whole_cycle_continue_time=0; %���ڴ�ŵ�������ѭ��������ʱ�䣬��ʼ��Ϊ0
whole_cycle_time_sum=[]; %�������ÿ���ź������������ڼ�����������
half_num_i=0;  %�ź�ѭ���Ĵ�����ʼ��Ϊ0
half_cycle_continue_time=0; %���ڴ�ŵ�����ѭ��������ʱ�䣬��ʼ��Ϊ0
half_cycle_time_sum=[]; %�������ÿ���ź����ݰ�����ڼ�����������


for i=2:N,
    %% ����������������
    if whole_cycle_time==1,
        if (data(i)*data(i-1)<=0)&&(diff_data(i-1)>0),%������������ʼ�����ź�����
            if (whole_num_i>0), %�����ڸ�������0ʱ������ǰһ����������
                temp1=[whole_num_i,whole_cycle_continue_time];
                whole_cycle_time_sum=[whole_cycle_time_sum;temp1];
                
                whole_cycle_continue_time=0; %���������ݺ��ʼ��ѭ��ʱ��Ϊ0
            end
            
            whole_num_i=whole_num_i+1;
            whole_cycle_continue_time=whole_cycle_continue_time+dt;
            
        elseif (data(i)*data(i-1)>0)||((data(i)*data(i-1)<=0)&&(diff_data(i-1)<0)),%���߱�����ƽ��ֵ�Ϸ����߱�����ƽ��ֵ�·������ߴ����½�״̬����ƽ��ֵ�ߵ�����£��ۼƼ������ʱ��
            whole_cycle_continue_time=whole_cycle_continue_time+dt;
        end
    end
    
    %% ��������������
    if half_cycle_time==1,
        if (data(i)*data(i-1)<=0),%�������������½�����ƽ��ֵ�߿�ʼ�����źŰ�����
            if (half_num_i>0), %�����ڸ�������0ʱ������ǰһ����������
                temp2=[half_num_i,half_cycle_continue_time];
                half_cycle_time_sum=[half_cycle_time_sum;temp2];
                
                half_cycle_continue_time=0; %���������ݺ��ʼ��ѭ��ʱ��Ϊ0
            end
            
            half_num_i=half_num_i+1;
            half_cycle_continue_time=half_cycle_continue_time+dt;
            
        elseif (data(i)*data(i-1)>0),%���߱�����ƽ��ֵ�Ϸ����߱�����ƽ��ֵ�·������ߴ����½�״̬����ƽ��ֵ�ߵ�����£��ۼƼ������ʱ��
            half_cycle_continue_time=half_cycle_continue_time+dt;
        end
    end
end
end