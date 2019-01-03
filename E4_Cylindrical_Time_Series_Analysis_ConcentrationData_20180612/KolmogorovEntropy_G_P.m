function [Log2R,Log2Cr2,xSlope,Slope2,D_KE,KE]=KolmogorovEntropy_G_P(data,name11,filepath,fs,t,dd,D,p)
% G-P �㷨ͬʱ�����ά��Kolmogorov�� (����ʱ����������)
% ʹ��ƽ̨ - Matlab7.0
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://luzhenbo.88uu.com.cn
% �ο�����: �Թ��,ʯ�׸�,���ķ��.�ӻ�������ͬʱ�������ά��Kolmogorov��[J].��������,1999;16(5):309~315

%--------------------------------------------------------------------------
% G-P�㷨�������ά
X=data;
rr = 0.5;
Log2R = -6:rr:0;        % log2(r)
R = 2.^(Log2R);

tic 
Log2Cr = log2(CorrelationIntegral(X,t,D,R,p));   % ���ÿһ�ж�Ӧһ��Ƕ��ά
toc

%--------------------------------------------------------------------------
% �����ͼ
figure
plot(Log2R,Log2Cr','k.-'); 
axis tight; 
hold on; 
grid on;
xlabel('log2(r)'); 
ylabel('log2(C(r))');
% title(['Lorenz, length = ',num2str(k2)]);

Log2Cr2=Log2Cr';

%--------------------------------------------------------------------------
% ��С�������

Linear = [3:9];                            % �����ƺ�����
[a,B] = LM2(Log2R,Log2Cr,Linear);           % ��С������б�ʺͽؾ�

disp(sprintf('Correlation Dimension = %.4f',a));

for i = 1:length(D)
    Y = polyval([a,B(i)],Log2R(Linear),1);
    plot(Log2R(Linear),Y,'r');
end
hold off;

print(gcf,'-dtiff',[filepath,'K��_��С�������_G_P_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;

%--------------------------------------------------------------------------
% ���ݶ�

Slope = diff(Log2Cr,1,2)/rr;                % ���ݶ�
xSlope = Log2R(1:end-1);                    % �ݶ�����Ӧ��log2(r)

figure;
plot(xSlope,Slope','k.-'); 
axis tight; 
grid on;
xlabel('log2(r)'); 
ylabel('Slope');
% title(['Lorenz, length = ',num2str(k2)]);
Slope2=Slope';

print(gcf,'-dtiff',[filepath,'K��_Slope_G_P_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;

%--------------------------------------------------------------------------
% �����K��

KE = -diff(B)/(dd*t)*fs*log(2);             % �ò���Ƶ�� fs �͹�ʽ log(x) = log2(x)*log(2) ����λת���� nats/s
D_KE = D(1:end-1);                          % K������Ӧ��Ƕ��ά

figure;
plot(D_KE,KE,'k.-'); grid on; hold on;
xlabel('m'); 
ylabel('Kolmogorov Entropy (nats/s)');
% title(['Lorenz, length = ',num2str(k2)]);

print(gcf,'-dtiff',[filepath,'K��_K_G_P_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
close all;

%--------------------------------------------------------------------------
% �����ʾ

disp(sprintf('Kolmogorov Entropy = %.4f',min(KE)));



