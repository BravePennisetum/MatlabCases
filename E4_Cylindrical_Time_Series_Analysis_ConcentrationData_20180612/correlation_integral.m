%�������ּ���
function C_I=correlation_integral(X,M,r)
%�ú������������������
%C_I:�������ֵķ���ֵ
%X:�ع�����ռ�ʸ������һ��m*M�ľ���
%M::M���ع���mά��ռ��е��ܵ���
%r:Heaviside �����е������뾶
sum_H=0;
for i=1:M-1
    for j=i+1:M
        d=norm((X(:,i)-X(:,j)),inf); %������ռ���ÿ����֮��ľ��룬����NORM(V,inf) = max(abs(V)).
        sita=heaviside(r,d);%����heaviside ����ֵ֮n
        sum_H=sum_H+1;
    end
end
C_I=2*sum_H/(M*(M-1));
%�������ֵ�ֵ
