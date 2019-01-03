%����ά��Kolmogorov�ؼ���
function [D2,K2]=Kolmogorov_D2_K2(X,Y,m_delt,tau)
%�����������������ά��Kolmogorov��
%X:lnr������������ĵ�
%Y:lnC������������ĵ�
%m_delt:Ƕ��ά������
%tau:ʱ���ӳ�
%D2Ϊ����ά
%K2ΪKolmogorov������

[mm,nn]=size(X);%������ÿ��Ƕ��ά��������������ĵ���mm����Ƕ��ά��nn
X_mean=mean(X); %ÿ��Ƕ��ά���������������lnrƽ��ֵ
Y_mean=mean(Y); %ÿ��Ƕ��ά���������������lmCƽ��ֵ

X_new=X-ones(mm,1)*X_mean;
Y_new=Y-ones(mm,1)*Y_mean;

D2=sum(sum(X_new.*Y_new))/sum(sum(X_new.*X_new)); %�������άD2
KK=Y_mean-D2*X_mean;

for ii=1:nn-1
    KK_delt(ii)=KK(ii)-KK(ii+1);
end

K2=KK_delt/(m_delt*tau); %����Kolmogorov������
