function  tau=Mutual_Information_main(data)
% %����Ϣ����tau
% %data;     % ʱ�����У�������
% max_t = 20;  % ������Ĭ�����ʱ��
% %Part = 128;     % ������Ĭ��box��С
% 
% [entropy]=mutual(data,max_t);
% for i = 1:length(entropy)-1           
%     if (entropy(i)<=entropy(i+1))
%         tau = i;            % ��һ���ֲ���Сֵλ��
%         break;
%     end
% end
% tau = tau -1 ;              
% plot(0:length(entropy)-1,entropy)
% xlabel('Lag');
% title('����Ϣ����ʱ��');

maxLags = 100;          % ���ʱ��
Part = 128;             % ÿһ���껮�ֵķ���
r = Amutual_lzb(data,maxLags,Part);

%--------------------------------------------------------------------------
% Ѱ�ҵ�һ���ֲ���С��

tau = [];
for i = 1:length(r)-1           
    if (r(i)<=r(i+1))
        tau = i;            % ��һ���ֲ���Сֵλ��
        break;
    end
end
if isempty(tau)
    tau = length(r);
end
optimal_tau = tau -1    % r �ĵ�һ��ֵ��Ӧ tau = 0,����Ҫ�� 1

%--------------------------------------------------------------------------
% ͼ����ʾ

plot(0:length(r)-1,r,'.-')
xlabel('Lag');
title('����Ϣ����ʱ��');