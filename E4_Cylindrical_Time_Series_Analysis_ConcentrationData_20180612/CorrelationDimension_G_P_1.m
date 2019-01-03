function [ln_r,ln_C]=CorrelationDimension_G_P_1(data,N,tau,min_m,max_m,ss)
% ���� G-P�㷨�������ά

% �������ά����G��P�㷨
% data:ʱ������
% N:ʱ�����г���
% tau: ʱ���ӳ�
% min_m:��С��Ƕ��ά��
% max_m:����Ƕ��ά��
% ss:�뾶��������

for m=min_m:max_m,
    Y=reconstitution(data,N,m,tau);%reconstitute state space
    M=N-(m-1)*tau;%the number of points in state space
    for i=1:M-1,
        for j=i+1:M,
            d(i,j)=max(abs(Y(:,i)-Y(:,j)));%����״̬�ռ���ÿ����֮��ľ���     
        end
    end
    max_d=max(max(d));%�õ����е�֮���������
    d(1,1)=max_d;
    min_d=min(min(d));%�õ����е�����̾���
    delt=(max_d-min_d)/ss;%�õ�r�Ĳ���
    
    for k=1:ss
        r=min_d+k*delt;
        C(k)=correlation_integral(Y,M,r);%�����������
        ln_C(m,k)=log(C(k));%����lnC(r)
        ln_r(m,k)=log(r);%����lnr
        
        %fprintf('%d/%d/%d/%d\n',k,ss,m,max_m);%��������k,ss,m,max_m
    end
    plot(ln_r(m,:),ln_C(m,:));
    xlabel('ln r');
    ylabel('ln C(r)');
    grid on;
    hold on;
end

%���ln_r��ln_C���ݵ�.txt�ļ�
% fid=fopen('lnr.txt','w');
% fprintf(fid,'%6.2f %6.2f\n',ln_r);
% fclose(fid);
% fid = fopen('lnC.txt','w');
% fprintf(fid,'%6.2f %6.2f\n',ln_C);
% fclose(fid);

