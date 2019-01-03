function [ln_r,ln_C,CorrelationDimension_slope]=CorrelationDimension_G_P_6(data,tau,min_m,max_m,ss)
% �����������û���KL�任��G-P ����������������ӹ���ά
% data::�������ʱ������
% tau:  ʱ���ӳ�
% min_m:��СǶ��ά
% max_m:���Ƕ��ά
% ss:�뾶��������

N=length(data);%�������ʱ�����г���
ln_C=zeros((max_m-min_m)/2+1,ss);
ln_r=zeros((max_m-min_m)/2+1,ss);

Hurst_value=[];%��ʼ�����ڴ��Hurst��ֵ�ľ���
CorrelationDimension_slope=[];

for m=min_m:2:max_m,
    YY=K_L_GP(data,m,tau);%�ع���ռ䲢����ռ����KL�任
    Y=YY(fix(m/2.5):end,:);%ע�⣬YY�����е����б�ű���Ϊ�����������
    clear YY;
    
    M=N-(m-1)*tau;%��ռ�����Ŀ
    d=zeros(M-1,M);
    for i=1:M-1,
        for j=i+1:M,
            d(i,j)=max(abs(Y(:,i)-Y(:,j)));%������ռ���ÿ����֮��ľ���
        end
    end
    max_d=max(max(d));%��ռ�������֮���������
    
    for i=1:M-1%������ռ�������֮�����С����
        for j=1:i
            d(i,j)=max_d;
        end
    end
    min_d=min(min(d));%��ռ�������֮�����С����
    delt=(max_d-min_d)/ss;%�����뾶���ӵĲ���
    
    for k=1:ss
        r=min_d+k*delt; %C(k)=correlation_integral(Y,M,r);�����������
        sum_H=0;
        for i=1:M-1
            for j=i+1:M
                if r>d(i,j), %����heaviside(r,d) ����ֵ֮
                    sum_H=sum_H+1;
                end
            end
        end
        C(k)=2*sum_H/(M*(M-1));%�������ֵ�ֵ
        
        ln_C((m-min_m)/2+1,k)=log(C(k));%��lnC(r)
        ln_r((m-min_m)/2+1,k)=log(r);%��lnr
    end
    
    clear d;
    clear Y;
    
    plot(ln_r((m-min_m)/2+1,:),ln_C((m-min_m)/2+1,:)); %����˫����ͼ
    xlabel('ln(r)');
    ylabel('ln(C)');
    hold on;
    
    %% �����������
    rows_m=(m-min_m)/2+1;
    ln_r1=ln_r(rows_m,:); %ln_r1��ʾln_r�еĵ�rows_m��
    ln_C1=ln_C(rows_m,:); %ln_C1��ʾln_C�еĵ�rows_m��
    
    nn4=4;
    LinearZone = 1:nn4;
    F = polyfit(ln_r1(LinearZone),ln_C1(LinearZone),1);
    CorrelationDimension_slope(rows_m)= F(1), %���������б��
    
    yp=polyval(F,ln_r1(LinearZone)); %����������������
    plot(ln_r1(LinearZone),yp,'-r');
    
    Hurst_value=[Hurst_value;['k',num2str(rows_m),'=',num2str(F(1))]];
    
end

text(4.5,-2,['Hurst-value']);
text(5,-2,Hurst_value);
