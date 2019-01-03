%���������ӹ���ά����
function [ln_r,ln_C]=CorrelationDimension_G_P_5(data,tau,min_m,max_m,ss)
% ������������G-P ����������������ӹ���ά
% data::�������ʱ������
% tau:  ʱ���ӳ�
% min_m:��СǶ��ά
% max_m:���Ƕ��ά
% ss:�뾶��������
                
N=length(data); %�������ʱ�����г���
ln_C=zeros((max_m-min_m)/2+1,ss);
ln_r=zeros((max_m-min_m)/2+1,ss);

for m=min_m:2:max_m
    Y=reconstitution(data,N,m,tau);%�ع���ռ�
    
    M=N-(m-1)*tau;%��ռ�����Ŀ
    d=zeros(M-1,M);
    for i=1:M-1
        for j=i+1:M
            d(i,j)=max(abs(Y(:,i)-Y(:,j)));%������ռ���ÿ����֮��ľ���
        end                                
    end
    
    max_d=max(max(d));%��ռ�������֮���������
     for i=1:M-1 %������ռ�������֮�����С����
        for j=1:i,
            d(i,j)=max_d;
        end                               
     end
     
    min_d=min(min(d));%��ռ�������֮�����С����
    delt=(max_d-min_d)/ss;%�����뾶���ӵĲ���
    
    for k=1:ss,
        r=min_d+k*delt;
        %C(k)=correlation_integral(Y,M,r);����������� 
        sum_H=0;
        for i=1:M-1
            for j=i+1:M      
                 if r>d(i,j)
                 %����heaviside(r,d) ����ֵ֮                  
                    sum_H=sum_H+1;
                 end
            end
        end
         
        C(k)=2*sum_H/(M*(M-1));%�������ֵ�ֵ
        
        ln_C((m-min_m)/2+1,k)=log(C(k)); %��lnC(r)
        ln_r((m-min_m)/2+1,k)=log(r); %��lnr
    end
    
    clear d;
    clear Y;
    
    plot(ln_r((m-min_m)/2+1,:),ln_C((m-min_m)/2+1,:));%����˫����ͼ
    hold on;
    
    %------------------------------------------------------
%     % �����������
%     ln_Cr=ln_C;
%     ln_r=ln_r;
%     LinearZone = [10:25];
%     F = polyfit(ln_r(LinearZone),ln_Cr(LinearZone),1);
%     CorrelationDimension = F(1),
end

