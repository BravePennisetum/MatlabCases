%ʱ�����зֽ�
function Data=disjoint(data,t)
% �˺������ڽ�ʱ�����зֽ��t�����ཻ��ʱ������
% data:����ʱ������
% t:�ӳ٣�Ҳ�ǲ��ཻʱ�����еĸ���
% Data:���طֽ���t�����ཻ��ʱ������

N=length(data); %data�ĳ���
for i=1:t
    for j=1:(N/t)
        Data(j,i)=data(i+(j-1)*t);
    end
end
