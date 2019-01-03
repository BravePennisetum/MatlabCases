function lambda_1=largest_lyapunov_exponent_2(data,m,tau,P)             

%ע�⣺"�������õ���lambda_1���ܵ������lyapunovָ���������������������ѡ��������������ϣ��˴��Ĵ�����Ϊ�˳���ķ���"

%������ʹ��С�����������������lyapunovָ��
%data:ʱ������
%m:Ƕ��ά
%tau:ʱ���ӳ�
%P:ʹ�� FFT�������ʱ������ƽ������
%lambda_1:�������ص�������lyapunovָ��ֵ

N=length(data); %���г���
delt_t=1;
Y=reconstitution2(data,m,tau ); %�ع���ռ�
M=N-(m-1)*tau; %M��mά�ع���ռ����ܵ���
d=zeros(M-1,M);

for j=1:M
    d_min=1e+100;
    for jj=1:M, %Ѱ����ռ���ÿ������������㣬�����¸õ��±� 
        if abs(j-jj)>P,%���ƶ��ݷ���
            d_s=norm(Y(:,j)-Y(:,jj));%������������ľ���
            if d_s<d_min
                d_min=d_s;
                idx_j=jj;
            end           
        end
    end
    max_i=min((M-j),(M-idx_j));%�����j������ݻ�ʱ�䲽��i
    for k=1:max_i, %�����j��������ڵ���i����ɢ����ľ���
       d(k,j)=norm(Y(:,j+k)-Y(:,idx_j+k));
    end
end

%��ÿ���ݻ�ʱ�䲽��i�������е�j��lnd(i,j)ƽ��
[l_i,l_j]=size(d);
for i=1:l_i,
    q=0;
    y_s=0;
    for j=1:l_j,
        if d(i,j)~=0
            q=q+1;
            y_s=y_s+log(d(i,j));
        end
    end
    if q>0
      y(i)=y_s/(q*delt_t);
    end
end

figure,
x1=1:length(y);
plot(x1,y);
hold on

%�����������
x2=1:10;%length(y);
pp=polyfit(x2,y(x2),1);
lambda_1=pp(1);%б��
yp=polyval(pp,x2);

plot(x2,yp,'-r');
text(100,5,['k=',num2str(lambda_1)]);
hold off

