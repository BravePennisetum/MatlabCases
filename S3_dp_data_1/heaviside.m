%Heaviside�����ļ���
function sita=heaviside(r,d)
% �ú�����������Heaviside������ֵ
%sita:Heaviside������ֵ
%r:Heaviside�����������뾶
%d:����֮��ľ���

if (r-d)<0
    sita=0;
else 
    sita=1;
end
