function tau=C_C_delay(xn,name11,filepath)
% C-C�㷨�������ʱ��tau

%% ��һ������ֵΪ 0�����Ϊ 1
X=xn; %ԭʼ�ź�
sig_input=X;
sig_output= normalize_1(sig_input); %��һ��ԭʼ�ź�

%%
%tao_w �������������ʱ�䣻
%tao_d ʱ���ӳ�
X=sig_output; %��һ����ľ������¸�ֵ��X
maxLags = 200;
m_vector = 2:5; %Ƕ��ά����2,3,4,5
sigma = std(X);
r_vector = sigma/2*[1:4]; %�뾶��sigma/2*��1,2,3,4��

S_mean = zeros(1,maxLags); %��ʼ�����ƽ��ֵ����
Sj = zeros(1,length(r_vector)); %��ʼ�����Sj����
delta_S_mean = zeros(1,maxLags); %��ʼ�����delta_S_mean����ľ���
delta_S = zeros(length(m_vector),maxLags); %��ʼ�����delta_S����ľ���

for t = 1:maxLags, %t������t�����ཻ��������
    temp = 0;
    for i = 1:length(m_vector),
        for j = 1:length(r_vector),
            m = m_vector(i);%Ƕ��ά��
            r = r_vector(j);%�뾶��sigma/2*j
            S = ccFunction(m,X,r,t);         % �����еı�׼�㷨
            temp = temp + S;
            Sj(j) = S;
        end
        
        delta_S(i,t) = max(Sj)-min(Sj);%����delta_S(i,t)
    end
    
    %�ֲ����ʱ��������ȡS(m,r,t)�������߶����еİ뾶r�໥�����С��ʱ��㣬��Ϊ�ⰵ������Щ�㼸���Ǿ��ȷֲ���
    %�ֲ����ʱ��tӦΪS(m,r,t)������delta_S(m,t)����Сֵ������S(m,r,t)����������m,rӦ������ȣ�delta_S(m,t)����Сֵ������mӦ������ȣ�
    %ʱ�����tao_d��Ӧ����Щ�ֲ����ʱ��t�еĵ�һ��
    
    % �μ� <<����ʱ�����з�����Ӧ��>> P66 ʽ(3.31)
    S_mean(t) = temp/(length(m_vector)*length(r_vector));%����S_mean(t),��ʽ3.31
    
    delta_S_mean = mean(delta_S);%����delta_S_mean(t)����ʽ3.32
end

S_cor = delta_S_mean + abs(S_mean);%����S_cor����ʽ3.33

%  0<=t<=200
%  delta_S��Сֵ����Ӧ��tao_d=dt*t
%  ��S_mean(t)Ѱ�ҵ�һ��������delta_S_meanѰ�ҵ�һ����Сֵȥ����ʱ�����ж����ĵ�һ���ֲ����ֵ��ʱ�����tao_d=dt*t,��Ӧ�ŵ�һ���ֲ����ʱ�䣬
%  ͬʱ��S_cor��Ѱ����Сֵ��ȥ����ʱ�����ж����ĵ�һ���������ֵʱ�䴰��tao_w=dt*tt
%-----------------------------------------------------------------------
%% S_meam
figure(1),
subplot(311),
plot(1:maxLags,S_mean);%���Ƴ���-S_mean�������
xlabel('Lags');
ylabel('S_mean');
title('S_mean');
grid on;

for S_mean_i=1:maxLags-1,
    temp1=S_mean(S_mean_i);
    temp2=S_mean(S_mean_i+1);
    if (temp1==0)||(temp1>0 &&temp2<0)||(temp1<0 &&temp2>0),
        break
    end
end

S_mean_zero_point_x=S_mean_i; %S_mean�ĵ�һ�����
S_mean_zero_point_x_delay=S_mean_zero_point_x;

%% delta_S_mean
subplot(312),
plot(1:maxLags,delta_S_mean);%���Ƴ���-delta_S_mean�������
xlabel('Lags');
ylabel('LE1');
title('delta_S_mean');
grid on;

diff_delta_S_mean=diff(delta_S_mean,1);%����1�׵���
for delta_S_mean_i=1:maxLags-1,
    temp1= diff_delta_S_mean(delta_S_mean_i);
    temp2= diff_delta_S_mean(delta_S_mean_i+1);
    if (temp1<0 && temp2>0),
        break
    end
end

delta_S_mean_jixiaozhi_point_x=delta_S_mean_i; %S_mean�ĵ�һ�����
delta_S_mean_jixiaozhi_point_x_delay=delta_S_mean_jixiaozhi_point_x;

%% S_cor
subplot(313),
plot(1:maxLags,S_cor);%���Ƴ���-S_cor�������
xlabel('Lags');
ylabel('S_cor');
title('S_cor');
grid on;

[S_cor_min,S_cor_num]=min(S_cor);%�ֱ�Ϊ��Сֵ����ֵ������һ��������Сֵ���ĺ���������
S_cor_delay=S_cor_min;

print(gcf,'-dtiff',[filepath,'Correlation_Dimension_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;

C_C_Method_Lyapunov_delay_temp=[S_mean_zero_point_x_delay,delta_S_mean_jixiaozhi_point_x_delay,S_cor_delay];

tau=min(S_mean_zero_point_x_delay,delta_S_mean_jixiaozhi_point_x_delay);%ʱ�����tao_d��Ӧ����Щ�ֲ����ʱ��t�еĵ�һ��

