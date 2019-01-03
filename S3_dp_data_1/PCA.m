%���������ʶ��
function sigma= PCA(data,m,tau)
%�ú���������������(PCA)����ʶ�����������������źŵ���������ͼӦ��һ������
%����б��Ϊ��ֵ��ֱ�ߣ��������źŵ���������ͼӦ��һ����X��ӽ�ƽ�е�ֱ�ߣ���
%�������������ֲ���׼������Ϊʶ������������һ��������
%data������Ĵ�����ʱ������
%m���ع���ռ��ά��
%tau:�ع���ռ��ʱ���ӳ�
%sigma���������ֲ��ı�׼����

Data=reconstitution2(data,m,tau);%��ʱ�����н�����ռ��ع�
KLX=mean(Data');%�����ع���ռ����ÿһ�е�ƽ��ֵ
KLdata=Data-KLX'*ones(1,length(data)-(m-1)*tau);%��ռ����ÿһ��Ԫ�ؼ�ȥ���е�ƽ��ֵ
A=(KLdata*KLdata')/(length(data)-(m-1)*tau);%��Э�������
%A=(Data*Data');

lamda=eig(A);%����Э������������ֵ
lamda=-sort(-lamda);%������ֵ�Ӵ�С����
lamda_PCA=log(lamda/sum(lamda));

plot(lamda_PCA);%����������ͼ
ylabel('����������(PCA)')
title('��������ͼ')
sigma=std(lamda_PCA);%�����������ֲ��ı�׼����
