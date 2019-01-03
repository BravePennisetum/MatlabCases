function [Lyapunov1]=Largest_Lyapunov1(data,m,tau,taumax,P)
% ����С���������������ʱ������ Lyapunov ָ��

Y = lyapunov_small(data,tau,m,P);

figure(1)
plot(Y(1:taumax),'-b');
grid on;
xlabel('i');
ylabel('y(i)');
hold on,

n=20; %ͳһ���壬n=20

%% �ֶ�������Ҫ������ϵ�����
%         n=input('������Ҫ��ϳ���n(Ĭ��Ϊ8)=');
%         if isempty(n)
%             n=8;
%         else
%             n;
%         end
%%
linear_zone = [1:n]'; % ��������ָ����������ĳ���
F = polyfit(linear_zone,Y(linear_zone),1);

%%
Lyapunov1 = F(1);
Lyapunov1,%���Lyapunovָ���������

%������ϵ�ֱ��
yp=polyval(F,1:n+20);

plot(1:n+20,yp,'-r');
text(25,11.1,['K=',num2str(Lyapunov1)]);
hold off

