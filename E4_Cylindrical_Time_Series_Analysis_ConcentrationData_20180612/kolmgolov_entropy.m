function  [Km,Kmean]=kolmgolov_entropy(data0,Fs,p,name11,filepath)
%%%%%%%%%%%%%%%%%%%%%%kolmgolov entropy%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ���ߣ�������
%%%% ���ڣ�2010.07.08
%%%  �������룺
%          AΪ��Ҫ�������������ݣ���������
%          FsΪ����Ĳ����ʣ�
%          p�������1�򻭳�kolmogolov����ʱ��仯������ͼ
%%%  ���������
%         Km����������õ���kolmogolov�ص�����ֵ��ÿwindow_t s����õ�һ��ֵ������ʱÿ���ص�window_t/2 s��
%         AverageΪ���kolmogolov�ص�ƽ��ֵ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
window_t=10;
N=window_t;%ÿ�μ�������г���
m=15;
G=length(data0);
g=Fs*(window_t/2);%ÿ�λ����ĵ���
t=((G-N)/g);
h=floor(t);
LKm=zeros(h,1);

for i=0:h %�����Ĵ���
    data=data0(1+i*g:N+i*g);
    tau=3*0.02;
    %tau=C_C_delay(data,name11,filepath)
    LKm(i+1)=log((CK(data,m,N,tau))./(CK(data,m+13,N,tau)));
    Km=(1/(tau*13))*LKm;
    %Ke=Km(3);
end

if p==1,
    figure,
    plot(Km);
    print(gcf,'-dtiff',[filepath,'Km_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
    close all;
end

Kmean=mean(Km);

