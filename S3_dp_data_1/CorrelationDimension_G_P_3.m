function [ln_r,ln_C,CorrelationDimension]=CorrelationDimension_G_P_3(data,tau,m)
% the function is used to calculate correlation dimension with G-P algorithm
% data:the time series
% N: the length of the time series
% tau: the time delay
% m:Ƕ��ά

% GP�㷨�����ά
%---------------------------------------------------
x = normalize_1(data);  % ��һ��
data=x';             % ע�⣺�˴�ӦΪһ��������
%------------------------------------------------------

disp('---------- GP�㷨�����ά ----------');
logdelt = 0.2;
ln_r = [-7:logdelt:0];
delt = exp(ln_r);
for k=1:length(ln_r)
    r=delt(k);
    C(k)=correlation_interal(m,data,r,tau);%  �������Ϊ��������
    k;
    if (C(k)<0.0001)
        C(k)=0.0001;
    end
    ln_C(k)=log(C(k));%lnC(r)
end
C;

subplot(211)
plot(ln_r,ln_C,'+:');
grid;
xlabel('ln r'); 
ylabel('ln C(r)');
hold on;

subplot(212)
Y = diff(ln_C)./logdelt;
plot(Y,'+:'); 
grid;
xlabel('n'); 
ylabel('slope');
hold on;

%------------------------------------------------------
% �����������
ln_Cr=ln_C;
ln_r=ln_r;
LinearZone = [10:25];
F = polyfit(ln_r(LinearZone),ln_Cr(LinearZone),1);
CorrelationDimension = F(1)
