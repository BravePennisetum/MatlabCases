%��ռ��ع�
function Data=reconstitution2(data,m,tau)
%�ú��������ع���ռ�
% m:Ƕ��ռ�ά��
% tau:ʱ���ӳ�
% data:����ʱ������
% Data:���,��m*nά����
N=length(data);  % NΪʱ�����г���
M=N-(m-1)*tau;
%��ռ��е�ĸ���
Data=zeros(m,M);
for j=1:M
    for i=1:m
        %��ռ��ع�
        Data(i,j)=data((i-1)*tau+j);
    end
end
