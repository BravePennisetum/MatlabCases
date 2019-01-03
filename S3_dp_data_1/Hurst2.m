%Hurstָ������
function [ln_RS,ln_n]=Hurst2(data,n_max)
% data=xn';
% n_max=251;
%����������Hurstָ������ʱ������
%data����������ʱ������
%n_max�������е���󳤶�
%ln_RS�����ص�ln(R/S)��ֵ
%ln_n�����ص�ln(n)��ֵ
N=length(data); %������ʱ�����еĳ���
ln_n=log(10:10:n_max)';  %���ص�ln(n)��ֵ

for n=10:10:n_max
    a=floor(N/n); %ʱ�����зֳ������еĸ���
    X=reshape(data(1:n*a),n,a); %��ʱ�����зֳ�a������Ϊn��������
    aver=mean(X); %����ÿһ�������е�ƽ��ֵ
    cumdev=X-ones(n,1)*aver; %ÿ�������е�Ԫ�ؼ�ȥ���е�ƽ��ֵ
    cumdev=cumsum(cumdev); %����ÿһ�������еĻ������
    stdev=std(X); %����ÿһ�������еľ�����
    RS=(max(cumdev)-min(cumdev))./stdev; %����ÿһ�������е�R/Sֵ
    ln_RS(n/10,1)=log(mean(RS)); %��������������R/Sֵ��ƽ��ֵ
end

% ��ͼ
figure,
plot(ln_n,ln_RS)
xlabel('ln��n��');
ylabel('ln��RS��');