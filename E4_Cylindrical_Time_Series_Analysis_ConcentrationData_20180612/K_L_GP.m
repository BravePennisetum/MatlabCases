function KL_Data=K_L_GP(data,m,tau)
%�ú���������ʱ�����е��ع���ռ����K_L�任
%data:�����ʱ������
%m:�ع���ռ��ά��
%tau:�ع���ռ��ʱ���ӳ�
%KL_lamda:�ع���ռ�Э��������m������ֵ
%KL_Data:����K_L�任���m*mά����

Data=reconstitution2(data,m,tau); %��ʱ�����н�����ռ��ع�
KLX=mean(Data'); %�����ع���ռ����ÿһ�е�ƽ��ֵ
KLdata=Data-KLX'*ones(1,length(data)-(m-1)*tau); %��ռ����ÿһ��Ԫ�ؼ�ȥ���е�ƽ��ֵ
KLData=(KLdata*KLdata')/(length(data)-(m-1)*tau); %��Э�������
[V,D]=eig(KLData);

%����Э��������m������ֵ����������
%KL_lamda=zeros(1,m);
% for ii=1:m
%     KL_lamda(ii)=D(ii,ii); %��Э������������ֵ����KL_D
% end

KL_Data=V'*Data; %����K_L�任��ľ���
