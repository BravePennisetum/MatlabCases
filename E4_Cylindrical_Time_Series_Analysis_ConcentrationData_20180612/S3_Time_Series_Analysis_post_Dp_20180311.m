%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ���ܣ�1���Դ��㲻ͬλ�ò�ѹʱ���źŵ�ԭʼ�źţ�ͳ����Ϣ���㣨ƽ��ֵ����׼�ƫ�ȡ���ȣ���Ƶ�׷������������ܶȡ�С�������������ֲ������ϵ���ȼ���
%%% ������K:\SimulationResults\UgpressureFB\UgpressureFBpost20180129
%%% ע�⣺1��������Ǻ���������ȡ�ķ������ݣ�����9��ѹ����������£�ͨ�����ñ���numiֵ��ȷ��������ļ��㡣
%%%       2���ó���ͬ��Ҳ�������ڼ��㵥������Ĺ�����
%%%
%%% �μ���
%%% ���ڣ�2018��03��17��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear all; close all; clc;
Path='K:\SimulationResults\UgpressureFB\UgpressureFBpost20180129';

%% ����ȷ��Ҫ���еļ��㷽��
for i0=1:1,
    %
    Output_Original_Signal=0; %ԭʼ�ź�
    %% ͳ�Ʒ���
    %
    Output_Statistical_Information=0; %ͳ����Ϣ���㣬����ƽ��ֵ����׼�ƫ�ȣ����
    Output_Original_Singal_Probability_density=0; %����ԭʼ�źŵĸ����ܶȺ���
    
    %% Ƶ�����
    %
    Output_Frequency_Analysis=0; % Ƶ�׷���
    Output_Power_Spectrum_Density_Analysis=0; % �������ܶȷ���
    PSD_Method=1; %�����õļ���PSD������%1-PSD_WELCH������%2-���ֹ����׼��㷽���Ա�
    %%
    %
    Output_Wavelet_Analysis=0; %С������
    Output_Wavelet_Packet_Transform=0; %С��������
    %
    Output_AutoCorrelation_Function =0;% ����غ�������
    %% �������
    %
    %ʱ���ӳ���Ҫһֱ���ڱ�ѡ��״̬
    Output_tau=1;%����ʱ���ӳ�tau
    Tau_Method=4;
    %���㷽����1�����û���Ϣ����ʱ���ӳ�tau
    %2:C-C����tau
    %3:C-C����tau
    %4��C-C����tau��m
    %
    Output_m=0;%����Ƕ��ά��m
    m_method=2;%1��Cao�ϼ��㷨��2��Cao�ϼ��㷨(old)
    %
    HunDun_Analysis=0;%����%���������ʶ��
    %
    Output_Period_Mean=0;%��������ƽ������
    Period_Mean_Method=1;%1:���ٸ���Ҷ�任����fft
    %
    Output_R_S_Hurst_Analysis=0; %R/S����������Hustָ��
    R_S_Hurst_Analysis_Method=4; %1:����ı����������򣬵ȳ���������2�������㲢��չ��һ��������
    %
    Output_Correlation_Dimension=0; %����ά����
    Correlation_Dimension_Method=2; %G-P�㷨���������ά,����4���Խ�����ά�����������excel��,����6����KL�任
    %
    Output_Kolmogorov_entropy=0; %����K��
    Kolmogorov_entropy_Method=2; %1:G-P�㷨��2�� ��3:STB�㷨
    %Kolmogorov��������ռ��п̻������˶���һ����Ҫ���ȣ�����ӳ��ϵͳ��̬��������Ϣ��ƽ����ʧ�ʡ�
    %
    Output_Both_Kolmogorov_and_CrosslationsDimension=0;%ͬʱ����K�غ͹���ά,��Ҫ�ṩ������������ĵ�
    Both_Kolmogorov_and_CrosslationsDimension_Method=1;%case 1����������������
    %
    Output_Largest_Lyapunov_Exponent=1;%���lyapunovָ������
    Largest_Lyapunov_Exponent_Method=4;
    %����,
    %1:��С��������1�������Lyapunovָ����
    %2:��С��������2����������Lyapunovָ����
    %3��%��Դ������ʱ�����з���Դ����.docx��G-P�㷨��
    %4��%wolf�㷨
    %
    Output_Lyapunov_Exponents=0; %����Lyapunovָ����
    Lyapunov_Exponents_Method=1; %1������BBA�㷨����Lyapunovָ���ף�
end

%%
count=0; %����ͳ�Ƽ���Ĺ�������
Excel_title=cell(21,1); %���ڴ�Ź���������
Bubble2_Sum=[]; %���ڻ���ͳ�Ƽ�����
Wavelet_Energy_Distribution_Sum=[]; %���ڻ���С������������
Wavelet_Packet_Energy_Distribution_Sum=[]; %���ڻ���С��������������

for i=1:1, %��Ӧ21������
    name1=Casename(i);%ͨ������Casename�������幤������
    
    loadpath_mat=strcat(Path,'\','post����','\',name1,'-PgLocals.mat'); %'.mat'�ļ�������·��
    load(loadpath_mat);%���롰.mat���ļ���Ϣ
    DpressureVsTime=PgLocalsvsTime; %DPbedvsTime������Ϣ��ֵ��DpressureVsTime����
    
    %% ��������Ҫ�޸ĵĲ���
    numi=5; %��2-10��Ϊ��ѹ�ź�����,��9�飬��9�����У��ֶ��޸ģ��ֱ�Ϊ2,3,4,5,6,7,8,9,10,���벼���ľ���ֱ�Ϊ20��40,60,80,100,120,140,160,180mm,��(numi-1)*20mm
    
    Bubble1=DpressureVsTime(:,1);  %��1��Ϊʱ������
    Bubble20=DpressureVsTime(:,numi);  %��ѹ�ź�����,��9�飬��9�����У��ֶ��޸ģ��ֱ�Ϊ2,3,4,5,6,7,8,9,10
    name11=strcat(name1,'_',num2str(numi)); %������ļ�����
    
    Path2=strcat('K:\SimulationResults\UgpressureFB\UgpressureFBpost20180129','\������','\ѹ������');
    mkdir(Path2,num2str(numi)); %���ڴ����21����������ͬλ�ô��ļ���������
    Path3=strcat(Path2,'\',num2str(numi));
    mkdir(Path3,'����ͼ��'); %��Path3�ļ����´�����Ϊ������ͼ���ļ���
    
    Bubble21=Bubble20-mean(Bubble20); %��ѹ�ź�����,ȥ��ƽ��ֵ�������
    xn=Bubble21;%ȥ����ѹ��ķ�ֵ���ݸ�ֵ��xn
    xn2=Bubble20;%���ȥ����ֵ֮ǰ������
    abs_xn=abs(xn);%
    
    Fs=50;%����Ƶ��Ϊ50Hz
    N=251;
    dt=1/Fs;%����ʱ����
    n=0:N-1;
    t=n*dt;%����ʱ��ֲ�
    
    %% ���ڶ���������ı���·��
    for i1=1,
        %
        Excel_Output_Path_Image=strcat(Path2,'\',num2str(numi),'\','����ͼ��\');%���屣��ԭʼ�ź�ͼ��·��
        %
        Excel_outputpath_Original_Signal_data=strcat(Path2,'\',num2str(numi),'\','ԭʼ�ź���Ϣ����.xlsx');%���屣�湤��ԭʼ���ݵ�·��
        %
        Excel_outputpath_Statistical_Information_data=strcat(Path2,'\',num2str(numi),'\','ͳ����Ϣ����.xlsx');%���幤���ļ���ͳ������·��
        Excel_outputpath_Original_Singal_Probability_density_data=strcat(Path2,'\',num2str(numi),'\','ԭʼ�źŸ����ܶȺ�������.xlsx');%���幤������ԭʼ�źŸ����ܶȺ�����·��
        %
        Excel_outputpath_Frequency_Analysis_data=strcat(Path2,'\',num2str(numi),'\','�ź�Ƶ�׻���.xlsx');
        %
        Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data=strcat(Path2,'\',num2str(numi),'\','�źŹ����׻���.xlsx');
        %
        Excel_Outputpath_Wavelet_Sum_data=strcat(Path2,'\',num2str(numi),'\','С���任��Ƶ�ηֲ��������.xlsx');%���屣��С���任�����ֲ�����·��
        Excel_outputpath_Wavelet_Analysis_Energy_data=strcat(Path2,'\',num2str(numi),'\','С���任�����ֲ�����.xlsx');%���屣��С���任�����ֲ�����·��
        %
        Excel_Outputpath_Wavelet_Packet_Transform_Sum_data=strcat(Path2,'\',num2str(numi),'\','С�����任��Ƶ�ηֲ��������.xlsx');%���屣��С���任�����ֲ�����·��
        Excel_outputpath_Wavelet_Packet_Energy_data=strcat(Path2,'\',num2str(numi),'\','С�����任�����ֲ�����.xlsx');%���屣��С���任�����ֲ�����·��
        %
        Excel_outputpath_AutoCorrelation_Function_data=strcat(Path2,'\',num2str(numi),'\','����غ�������.xlsx');%���屣��С���任�����ֲ�����·��
        Excel_outputpath_R_S_Hurst_data=strcat(Path2,'\',num2str(numi),'\','RS����Hurstָ������.xlsx');%���屣��С���任�����ֲ�����·��
        %
        Excel_outputpath_Correlation_Dimension_C_C_Method_data=strcat(Path2,'\',num2str(numi),'\','�ӳ�ʱ��C_C����.xlsx');%���屣��С���任�����ֲ�����·��
        %
        Excel_Outputpath_Correlation_Dimension_data=strcat(Path2,'\',num2str(numi),'\','����ά������.xlsx');%���屣�����Ĺ���ά����·��
        %
        Excel_Outputpath_Kolmogorov_Entropy_STB_data=strcat(Path2,'\',num2str(numi),'\','K�ػ���_STB.xlsx');%���屣��STB�㷨�����K������·��
    end
    
    %% ԭʼ�ź�
    if  Output_Original_Signal==1;
        Original_data=[Bubble1,Bubble20,Bubble21];%���ڴ��ʱ�����ݣ�ԭʼ��ֵ���ݣ�ȥ����ѹ��ķ�ֵ����
        m1={'ʱ��','ԭʼ��ֵ','ȥ����ֵ���ֵ'};
        
        xlswrite(Excel_outputpath_Original_Signal_data,m1,name11,'A1');
        disp(strcat('Excel_outputpath_Original_Signal_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Original_Signal_data,Original_data,name11,'A2');
        disp(strcat('Excel_outputpath_Original_Signal_data_Exceldata:',name11)); %Excel���ݱ�����������������
    end
    
    %% ͳ�Ʒ���������ƽ��ֵ����׼���ȣ�ƫ��
    if Output_Statistical_Information==1,
        Bubble20_mean=mean(Bubble20);
        Bubble20_length=length(Bubble20);
        
        %�����׼��
        Bubble20_std=std(Bubble20);%��׼ƫ��
        
        %����ƽ������ƫ��
        Bubble21_Average_Absolute_Deviation=mean(abs(xn));%ƽ������ƫ��,���м���
        
        %���֥, ����ѭ������������¯��������������CPFD��ֵģ���ʵ���о�, 2015, �й���ѧԺ�о���Ժ(�����������о���).P43
        %����ƫ��
        Bubble20_Sk_sum=0;
        for j=1:Bubble20_length,
            Bubble20_Sk_sum=Bubble20_Sk_sum+xn(j)^3;
        end
        Bubble20_Sk=Bubble20_Sk_sum/(N*Bubble20_std^3);
        
        %���֥, ����ѭ������������¯��������������CPFD��ֵģ���ʵ���о�, 2015, �й���ѧԺ�о���Ժ(�����������о���).P43
        %������
        Bubble20_K_sum=0;
        for j=1:Bubble20_length,
            Bubble20_K_sum=Bubble20_K_sum+xn(j)^4;
        end
        
        Bubble20_K=Bubble20_K_sum/(N*Bubble20_std^4);
        
        Bubble2_Temp=[Bubble20_mean,Bubble20_std,Bubble21_Average_Absolute_Deviation,Bubble20_Sk,Bubble20_K];%�ֱ�Ϊƽ��ֵ����׼�����ƫ��ƽ��ֵ��ƫ��Sk�����K
        Bubble2_Sum=[Bubble2_Sum;Bubble2_Temp];%���ܼ���Ľ���������Excel�Ĵ�����������ڻ��ܺ������
    end
    
    %% ����ԭʼ�źŵĸ����ܶȺ���
    %�ο����ף����ٷ壬Һ��������ѭ��������ѹ�������źŵ�ͳ�Ƽ�Ƶ�׷��������̹���ѧ����2006.
    if Output_Original_Singal_Probability_density==1,
        xn2=xn2;
        xn2Max=max(xn2);
        xn2Min=min(xn2);
        meanS=mean(xn2);
        xn2_x=linspace(xn2Min,xn2Max,180);
        yy=hist(xn2,xn2_x);  %�����������ĸ���
        yy=yy/length(xn2); %�����������ı���
        
        bar(xn2_x,yy,'g');
        hold on
        
        [ff,xi] = ksdensity(xn2);
        plot(xi,ff,'*b','LineWidth',2);
        hold off
        
        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Original_Singal_Probability_density_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
        close all;
        
        %����������
        Original_Singal_Probability_density_Temp1=[xn2_x,yy];
        Original_Singal_Probability_density_Temp2=[xi,ff];
        m_Original_Singal_Probability_density={'ѹ��1(Pa)','(��״ͼ-��ɢ�ź�)Ƶ��','ѹ��2��Pa��','(����ͼ-�����ź�)�����ܶ�'};
        
        %������ؽ����ָ��Excel��
        xlswrite(Excel_outputpath_Original_Singal_Probability_density_data,m_Original_Singal_Probability_density,name11,'A1');
        disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Original_Singal_Probability_density_data,Original_Singal_Probability_density_Temp1,name11,'A2');
        disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
        
        xlswrite(Excel_outputpath_Original_Singal_Probability_density_data,Original_Singal_Probability_density_Temp2,name11,'C2');
        disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
    end
    
    %% Ƶ�׷���
    if Output_Frequency_Analysis==1,
        y=fft(xn,N);%����Ҷ�任
        mag=abs(y);
        f=(0:length(y)-1)'*Fs/length(y);%������Ƶ�ʵı��ʽΪf=(0:M-1)*Fs/M;
        frequency_data=[f(1:N/2),mag(1:N/2)];
        
        m2={'Ƶ��/Hz','��ֵ'};
        xlswrite(Excel_outputpath_Frequency_Analysis_data,m2,name11,'A1');
        disp(strcat('Excel_outputpath_Frequency_Analysis_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Frequency_Analysis_data,frequency_data,name11,'A2');
        disp(strcat('Excel_outputpath_Frequency_Analysis_data_Exceldata:',name11)); %Excel���ݱ�����������������
        
        figure,
        plot(f(1:N/2),mag(1:N/2),'LineWidth',2);%����Ƶ��ͼ
        %axis([0,25,0,40000])
        title('Ƶ��ͼ');
        xlabel('Ƶ��/Hz');
        ylabel('��ֵ');
        grid on;
        
        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Frequency_Analysis_Image_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
        close all;
    end
    
    %% �������ܶȷ���
    if  Output_Power_Spectrum_Density_Analysis==1,
        switch PSD_Method,
            case 1, %PSD_WELCH����(�Ľ�������ͼ�����׹��Ʒ���)����������
                %Matlab�У�����psd()�ͺ���pwelch()����ʵ��Welch�����Ĺ����׹��ƣ��ο��̲ģ�����źŷ�������3�棩֣΢�����ӹ�ҵ�����磬2017��
                
                nfft=251; %FFT�任����
                Nseg=251; %�ֶμ��
                window1=hamming(length(xn)); %ѡ�õĴ���-����������
                %window1=hanning(length(xn)); %ѡ�õĴ���-����������
                noverlap=100; %�ֶ������ص��Ĳ�������(����)
                range='half'; %Ƶ�ʼ��Ϊ[0 Fs/2]��ֻ����һ���Ƶ��
                f=(0:Nseg/2)*Fs/Nseg; %Ƶ��������
                
                Sx1=psd(xn,Nseg,Fs,window1,noverlap,'none');
                %Sx1=10*log10(Sx1);
                Plot_Pxx11=Sx1;
                Plot_Pxx12=10*log10(Sx1);
                
                Sx2=pwelch(xn,window1,noverlap,nfft,Fs,'oneside')*Fs/2; %pwelch()���صĵ��߹����������Fs/2
                %Sx2=10*log10(Sx2);
                Plot_Pxx21=Sx2;
                Plot_Pxx22=10*log10(Sx2);
                
                window2=boxcar(length(xn));      %PSD_WELCH�����������δ�����
                Sx3=pwelch(xn,window2,noverlap,N,Fs,'oneside')*Fs/2;
                Plot_Pxx31=Sx3;
                Plot_Pxx32=10*log10(Sx3);
                
                %���ƹ���������ͼ���Ƕ������꣩
                figure,
                subplot(3,1,1),
                plot(f,Sx1,'LineWidth',2);
                grid on;
                xlabel('Ƶ��/Hz');
                ylabel('������');
                title('������-Welch��-psd()����');
                
                subplot(3,1,2),
                plot(f,Plot_Pxx21,'LineWidth',2);  %���ƹ�����
                %axis([0,25,0,300000])
                xlabel('Ƶ��/Hz');
                ylabel('������');
                title('������-Welch��-������-pwelch()����');
                grid on
                
                subplot(3,1,3),
                plot(f,Plot_Pxx31,'LineWidth',2);
                %axis([0,25,0,300000]);
                xlabel('Ƶ��/Hz');
                ylabel('������');
                title('������-Welch��-���δ�-pwelch()����');
                grid on
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Power_Spectrum_Density_Analysis_',name11,'_1.tiff'])   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                data1_Pxx1=[f',Plot_Pxx21];
                data2_Pxx1=[f',Plot_Pxx22];
                
                m3={'Ƶ��/Hz','pwelch()��ֵ','Ƶ��','pwelch()����ֵ'};
                xlswrite(Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data,m3,name11,'A1');
                disp(strcat('Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data1_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data,data1_Pxx1,name11,'A2');
                disp(strcat('Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data1_Exceldata:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data,data2_Pxx1,name11,'C2');
                disp(strcat('Excel_outputpath_Output_Power_Spectrum_Density_Analysis_data2_Exceldata:',name11)); %Excel���ݱ�����������������
                
                %���ƹ���������ͼ���������꣩
                figure,
                subplot(3,1,1),
                plot(f,Plot_Pxx12,'LineWidth',2);  %���ƹ�����
                %axis([0,25,0,300000])
                xlabel('Ƶ��/Hz');
                ylabel('������');
                title('������-Welch��-psd()����');
                grid on;
                
                subplot(3,1,2),
                plot(f,Plot_Pxx22,'LineWidth',2);  %���ƹ�����
                %axis([0,25,0,300000])
                xlabel('Ƶ��/Hz');
                ylabel('������');
                title('������-Welch��-������-pwelch()����');
                grid on;
                
                subplot(3,1,3),
                plot(f,Plot_Pxx32,'LineWidth',2);
                %axis([0,25,0,300000]);
                title('������-Welch��-���δ�-pwelch()����');
                xlabel('Ƶ��/Hz');
                ylabel('������');
                grid on;
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Power_Spectrum_Density_Analysis_Log_',name11,'_2.tiff'])   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                %���д��ڵĳ���N��ʾÿ�δ���ķֶ����ݳ��ȣ�Noverlap��ָ������������֮����ص����ֳ��ȡ�
                %NԽ��õ��Ĺ����׷ֱ���Խ��(Խ׼ȷ)��������Ӵ�(�����������߲�̫ƽ��)��NԽС������ķ�����С��
                %�������׷ֱ��ʽϵ�(���ƽ����̫׼ȷ)��
                %pwelch����NFFT,��FFT�ĸ������ǿ��Ա仯�ġ�������󳤶Ȳ��ܳ���ÿһ�εĵ�����
                %��Ȼ���ܶ���������ǰ�NFFT����ÿһ�εĵ������������Եõ���ߵ�Ƶ��ֱ��ʡ�
                %���NFFT = ÿһ�ε�һ�룬Ƶ��ֱ��ʵ�һ����
                
            case 2, %�������㹦�����ܶȵķ���
                %% �ֶ�ƽ������ͼ����Bartlett����
                %�����źŲ��ص��ֶι��ƹ�����
                Nsec=251;
                pxx1=abs(fft(xn(1:50),Nsec).^2)/Nsec;    %��һ�ι�����
                pxx2=abs(fft(xn(51:100),Nsec).^2)/Nsec;  %�ڶ��ι�����
                pxx3=abs(fft(xn(101:150),Nsec).^2)/Nsec; %�����ι�����
                pxx4=abs(fft(xn(151:200),Nsec).^2)/Nsec; %���Ķι�����
                pxx5=abs(fft(xn(201:251),Nsec).^2)/Nsec; %���Ķι�����
                Pxx=(pxx1+pxx2+pxx3+pxx4+pxx5)/5;      %ƽ���õ��������й�����
                f=(0:length(Pxx)-1)*Fs/length(Pxx);    %���������׶�Ӧ��Ƶ��
                
                figure,
                subplot(4,2,1),
                plot(f(1:Nsec/2),Pxx(1:Nsec/2),'LineWidth',2);       %���ƹ���������
                xlabel('Ƶ��/Hz');
                ylabel('������ /dB');
                title('ƽ������ͼ');
                grid on
                
                %% �����ź��ص��ֶι��ƹ�����
                pxx1=abs(fft(xn(1:100),Nsec).^2)/Nsec;   %��һ�ι�����
                pxx2=abs(fft(xn(51:150),Nsec).^2)/Nsec; %�ڶ��ι�����
                pxx3=abs(fft(xn(101:200),Nsec).^2)/Nsec; %�����ι�����
                pxx4=abs(fft(xn(151:251),Nsec).^2)/Nsec; %���Ķι�����
                Pxx=(pxx1+pxx2+pxx3+pxx4)/4; %������ƽ����ת��ΪdB
                f=(0:length(Pxx)-1)*Fs/length(Pxx);  %Ƶ������
                
                subplot(4,2,2),
                plot(f(1:Nsec/2),Pxx(1:Nsec/2),'LineWidth',2);   %���ƹ���������
                xlabel('Ƶ��/Hz');
                ylabel('������/dB');
                title('ƽ������ͼ(�ص�һ��) N=251');
                grid on
                
                %% ���ò��ص��Ӵ������Ĺ����׹���
                w=hanning(50);   %���õĴ�������
                pxx1=abs(fft(w.*xn(1:50),Nsec).^2)/norm(w)^2; %��һ�μӴ������ƽ��
                pxx2=abs(fft(w.*xn(51:100),Nsec).^2)/norm(w)^2; %�ڶ��μӴ������ƽ��
                pxx3=abs(fft(w.*xn(101:150),Nsec).^2)/norm(w)^2; %�����μӴ������ƽ��
                pxx4=abs(fft(w.*xn(151:200),Nsec).^2)/norm(w)^2; %���ĶμӴ������ƽ��
                pxx5=abs(fft(w.*xn(201:250),Nsec).^2)/norm(w)^2; %����μӴ������ƽ��
                Pxx=(pxx1+pxx2+pxx3+pxx4+pxx5)/5;    %���ƽ�������ף�ת��ΪdB
                f=(0:length(Pxx)-1)*Fs/length(Pxx);  %���Ƶ������
                
                subplot(4,2,3),
                plot(f(1:Nsec/2),Pxx(1:Nsec/2),'LineWidth',2); %���ƹ���������
                xlabel('Ƶ��/Hz');
                ylabel('������/dB');
                title('�Ӵ�ƽ������ͼ(���ص�) N=4*256');
                grid on
                
                %% �����ص��Ӵ������Ĺ����׹���
                w=hanning(100);   %���õĴ�������
                pxx1=abs(fft(w.*xn(1:100),Nsec).^2)/norm(w)^2; %��һ�μӴ������ƽ��
                pxx2=abs(fft(w.*xn(51:150),Nsec).^2)/norm(w)^2; %�ڶ��μӴ������ƽ��
                pxx3=abs(fft(w.*xn(101:200),Nsec).^2)/norm(w)^2; %�����μӴ������ƽ��
                pxx4=abs(fft(w.*xn(151:250),Nsec).^2)/norm(w)^2; %���ĶμӴ������ƽ��
                Pxx=(pxx1+pxx2+pxx3+pxx4)/4;%ƽ��������ת��ΪdB
                f=(0:length(Pxx)-1)*Fs/length(Pxx); %Ƶ������
                
                subplot(4,2,4),
                plot(f(1:Nsec/2),Pxx(1:Nsec/2),'LineWidth',2); %���ƹ���������
                xlabel('Ƶ��/Hz');
                ylabel('������/dB');
                title('�Ӵ�ƽ������ͼ(�ص�һ��)N=251');
                grid on
                
                %% PSD_WELCH����1
                %����Ƶ��
                Nfft=251;
                window=hanning(251);%ѡ�õĴ���
                noverlap=125;%�ֶ������ص��Ĳ������������ȣ�
                dflag='none';%�������ƴ���
                [Pxx,Pxxc,f]=psd(xn,Nfft,Fs,window,noverlap,0.95);   %�����׹���,����0.95�����Ŷȸ����������䣬�޷���ֵ�ǻ��Ƴ���������
                
                subplot(4,2,5),
                plot(f,Pxx,'LineWidth',2);  %���ƹ�����
                xlabel('Ƶ��/Hz');
                ylabel('������/dB');
                title('PSD��Welch����1');
                grid on
                
                %% welch method2
                window=boxcar(length(xn)); %���δ�
                noverlap=20; %�������ص�
                range='half'; %Ƶ�ʼ��Ϊ[0 Fs/2]��ֻ����һ���Ƶ��
                [Pxx,f]=pwelch(xn,window,noverlap,N,Fs,range);
                %plot_Pxx=10*log10(Pxx);
                
                subplot(4,2,6),
                plot(f,Pxx,'LineWidth',2),
                title('PSD��Welch����2');
                grid on
                
                %% ����ط���MEM����
                [Pxx1,f]=pmem(xn,20,Nfft,Fs);   %��������ط��������˲�������20�����ƹ�����
                
                subplot(4,2,7),
                plot(f,Pxx1,'LineWidth',2);   %���ƹ�����
                xlabel('Ƶ��/Hz');ylabel('������/dB');title('����ط� Order=20ԭʼ�źŹ�����');
                grid on
                
                %% �öര�ڷ�(MTM)
                [Pxx1,f]=pmtm(xn,2,Nfft,Fs); %�öര�ڷ�(NW=4)���ƹ�����
                
                subplot(4,2,8),
                plot(f,Pxx1,'LineWidth',2);  %���ƹ�����
                xlabel('Ƶ��/Hz');ylabel('������/dB');title('�ര�ڷ�(MTM) nw=2ԭʼ�źŹ�����');
                grid on
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Power_Spectrum_Density_Analysis_MultiMethods_',name1,'.tiff'])   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
        end
    end
    
    %% С���任����
    if Output_Wavelet_Analysis==1,
        [C,L]=wavedec(xn,7,'db2');%%����db2С�����źŽ���4��ֽ⣻'db2'ΪС��������,
        %  �ο����ף�db2�������ڷ�ñѹ��������������������̬�������о�������������ѧ����ѧ��ʿ���ģ�2013
        
        %  �ֱ��Ӧ��Ƶ��Ϊ��25����50Hz��12.5����25Hz��6.25����12.5Hz��3.125����6.25Hz��0����3.125Hz��
        %  [C,L]=wavedec(xn,N,��wname��)�з��صĽ��ƺ�ϸ�ڶ������C�У���CL=[C,L]��
        %  L����ǽ��ƺ͸���ϸ��ϵ����Ӧ�ĳ��ȣ�xn��ʾԭʼ�źţ�N�ֽ�Ĳ�����wnameС��������
        
        %�ź��ع�
        %a4=wrcoef('type',cA,cD,'wname',N); %type=a�ǶԵ�Ƶ���ֽ����ع���type=d�ǶԸ�Ƶ���ֽ����ع���NΪ�źŵĲ���
        
        a7=wrcoef('a',C,L,'db2',7); %0-0.390625Hz��      �ع���7���Ƶ�ź�
        d7=wrcoef('d',C,L,'db2',7); %0.390625-0.78125Hz���ع���7���Ƶ�ź�
        d6=wrcoef('d',C,L,'db2',6); %0.78125-1.5625Hz��  �ع���6���Ƶ�ź�
        d5=wrcoef('d',C,L,'db2',5); %1.5625-3.125Hz��    �ع���5���Ƶ�ź�
        d4=wrcoef('d',C,L,'db2',4); %3.125-6.25Hz��      �ع���4���Ƶ�ź�
        d3=wrcoef('d',C,L,'db2',3); %6.25-12.5Hz��       �ع���3���Ƶ�ź�
        d2=wrcoef('d',C,L,'db2',2); %12.5-25Hz��         �ع���2���Ƶ�ź�
        d1=wrcoef('d',C,L,'db2',1); %25-50Hz��           �ع���1���Ƶ�ź�
        
        wavelet_sum_signals=[t',a7,d7,d6,d5,d4,d3,d2,d1,xn];%ע�������t������������ת��Ϊ������
        
        m5={'t','a7','d7','d6','d5','d4','d3','d2','d1','xn'};
        xlswrite(Excel_Outputpath_Wavelet_Sum_data,m5,name11,'A1');
        disp(strcat('Excel_Outputpath_Wavelet_Sum_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_Outputpath_Wavelet_Sum_data,wavelet_sum_signals,name11,'A2');
        disp(strcat('Excel_Outputpath_Wavelet_Sum_data_Exceldata:',name11)); %Excel���ݱ�����������������
        
        %���������ź���Ϣ
        figure,
        subplot(9,1,1),
        plot(t,a7,'linewidth',2);
        %axis([0,5,-200,200]);
        ylabel('a7');
        grid on;%��4���Ƶ�ź�
        
        subplot(9,1,2),
        plot(t,d7,'linewidth',2);
        %axis([0,5,-500,500]);
        ylabel('d7');
        grid on;%��4���Ƶ�ź�
        
        subplot(9,1,3),
        plot(t,d6,'linewidth',2);
        %axis([0,5,-1000,1000]);
        ylabel('d6');
        grid on;%��3���Ƶ�ź�
        
        subplot(9,1,4),
        plot(t,d5,'linewidth',2);
        %axis([0,5,-1000,1000]);
        ylabel('d5');
        grid on;%��2���Ƶ�ź�
        
        subplot(9,1,5),
        plot(t,d4,'linewidth',2);
        %axis([0,5,-200,200]);
        ylabel('d4');
        grid on;%��1���Ƶ�ź�
        
        subplot(9,1,6),
        plot(t,d3,'linewidth',2);
        %axis([0,5,-200,200]);
        ylabel('d3');
        grid on;%��1���Ƶ�ź�
        
        subplot(9,1,7),
        plot(t,d2,'linewidth',2);
        %axis([0,5,-200,200]);
        ylabel('d2');
        grid on;%��1���Ƶ�ź�
        
        subplot(9,1,8),
        plot(t,d1,'linewidth',2);
        %axis([0,5,-200,200]);
        ylabel('d1');
        grid on;%��1���Ƶ�ź�
        
        subplot(9,1,9),
        plot(t,xn,'linewidth',2);
        %axis([0,5,-1000,1000]);
        ylabel('xn');
        grid on;%ԭʼ�ź�
        xlabel('t/s');
        
        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Wavelet_Analysis_',name11,'.tiff'])   %����tiff��ʽ��ͼƬ��ָ��·��
        close all;
        
        %�źŵ���������
        [Ea,Ed]=wenergy(C,L);%Ea��ʾ��Ƶ�����ٷֱȣ�%Ed��ʾ��Ƶ�����ٷֱ�
        %Ea,which is the percentage of energy corresponding to the approximation.�����Ƶ�ε�����,a7
        %Ed,which is the vector containing the percentages of energy corresponding to the details. �����Ƶ�ε�������d1,d2,d3,d4,d5,d6,d7
        
        Wavelet_Energy_Distribution=[Ed,Ea];%˳��Ϊd1,d2,d3,d4,d5,d6,d7,a7
        Wavelet_Energy_Distribution_Sum=[Wavelet_Energy_Distribution_Sum;Wavelet_Energy_Distribution];%����������ܵ�Wavelet_Energy_Distribution_sum������
    end
    
    %% С�����任����
    if Output_Wavelet_Packet_Transform==1,
        %��������С���任ֻ���źŵĵ�Ƶ��������һ���ֽ⣬���Ը�Ƶ����Ҳ���źŵ�ϸ�ڲ��ֲ��ټ����ֽ⣬
        %����С���任�ܹ��ܺõر���һ�����Ե�Ƶ��ϢΪ��Ҫ�ɷֵ��źţ��������ܺܺõطֽ�ͱ�ʾ��������
        %ϸ����Ϣ��ϸС��Ե���������źţ����ƽ�Ȼ�е���źš�ң��ͼ�󡢵����źź�����ҽѧ�źŵȡ�
        %��֮��ͬ���ǣ�С�����任���ԶԸ�Ƶ�����ṩ����ϸ�ķֽ⣬�������ַֽ�������࣬Ҳ����©��
        %���Զ԰��������С���Ƶ��Ϣ���ź��ܹ����и��õ�ʱƵ�ֲ���������
        
        wpt = wpdec(xn,3,'db2','shannon'); %ʹ��db2С������xn����3��ֽ⣬ʹ��shannon��
        %�ڵ����Ϊ0//1,2//3,4,5,6//7,8,9,10,11,12,13,14//
        
        wpttree_figure=plot(wpt);% ����С������
        print(wpttree_figure,'-dtiff',[Excel_Output_Path_Image,'Wavelet_Packet_Transform_Tree_',name11,'.tiff'])   %����tiff��ʽ��ͼƬ��ָ��·��
        close all hidden; %������д��ڣ��������ش���
        
        %�ع�������С���ź�
        xn30=wprcoef(wpt,[3,0]);   %0-6.25��    %�ع�С�����ֽ�ϵ��(3,0)����ͬ��wpcoef(wpt,7);������7�����7���ڵ�
        xn31=wprcoef(wpt,[3,1]);   %6.25-12.5�� %�ع�С�����ֽ�ϵ��(3,1)����ͬ��wpcoef(wpt,8);
        xn32=wprcoef(wpt,[3,2]);   %12.5-18.75��%�ع�С�����ֽ�ϵ��(3,2)����ͬ��wpcoef(wpt,9);
        xn33=wprcoef(wpt,[3,3]);   %18.75-25��  %�ع�С�����ֽ�ϵ��(3,3)����ͬ��wpcoef(wpt,10);
        xn34=wprcoef(wpt,[3,4]);   %25-31.25��  %�ع�С�����ֽ�ϵ��(3,4)����ͬ��wpcoef(wpt,11);
        xn35=wprcoef(wpt,[3,5]);   %31.25-37.5��%�ع�С�����ֽ�ϵ��(3,5)����ͬ��wpcoef(wpt,12);
        xn36=wprcoef(wpt,[3,6]);   %37.5-43.75��%�ع�С�����ֽ�ϵ��(3,6)����ͬ��wpcoef(wpt,13);
        xn37=wprcoef(wpt,[3,7]);   %43.75-50��  %�ع�С�����ֽ�ϵ��(3,7)����ͬ��wpcoef(wpt,14);
        
        Wavelet_Packet_Sum_Signals=[t',xn30,xn31,xn32,xn33,xn34,xn35,xn36,xn37,xn];
        
        m6={'t','xn30','xn31','xn32','xn33','xn34','xn35','xn36','xn37','xn'};
        xlswrite(Excel_Outputpath_Wavelet_Packet_Transform_Sum_data,m6,name11,'A1');
        disp(strcat('Excel_Outputpath_Wavelet_Packet_Sum_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_Outputpath_Wavelet_Packet_Transform_Sum_data,Wavelet_Packet_Sum_Signals,name11,'A2');
        disp(strcat('Excel_Outputpath_Wavelet_Packet_Sum_data_Exceldata:',name11)); %Excel���ݱ�����������������
        
        figure,
        subplot(9,1,1);
        plot(t,xn30);
        ylabel('xn130');
        
        subplot(9,1,2);
        plot(t,xn31);
        ylabel('xn131');
        
        subplot(9,1,3);
        plot(t,xn32);
        ylabel('xn132');
        
        subplot(9,1,4);
        plot(t,xn33);
        ylabel('xn133');
        
        subplot(9,1,5);
        plot(t,xn34);
        ylabel('xn134');
        
        subplot(9,1,6);
        plot(t,xn35);
        ylabel('xn135');
        
        subplot(9,1,7);
        plot(t,xn36);
        ylabel('xn136');
        
        subplot(9,1,8);
        plot(t,xn37);
        ylabel('xn137');
        
        subplot(9,1,9);
        plot(t,xn);
        ylabel('xn');
        
        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Wavelet_Packet_Transform_',name11,'.tiff'])   %����tiff��ʽ��ͼƬ��ָ��·��
        close all;
        
        E_wpt=wenergy(wpt);%����С������,E_wpt�е�ֵ�ǰ��մ����ҵ�˳����ʾ
        %wpt1 = wpjoin(wpt,[1,1]); % ����С����(1,1)����2
        %plot(wpt1); % ����С������wpt1
        
        Wavelet_Packet_Energy_Distribution_Temp=E_wpt;%˳��ΪE(3,0),E(3,1),E(3,2),E(3,3),E(3,4),E(3,5),E(3,6),E(3,7)
        Wavelet_Packet_Energy_Distribution_Sum=[Wavelet_Packet_Energy_Distribution_Sum;Wavelet_Packet_Energy_Distribution_Temp];%����������ܵ�Wavelet_Packet_Energy_Distribution_Sum������
    end
    
    %% ����غ�������
    if Output_AutoCorrelation_Function==1,
        [acor,lag] = xcorr(xn,'unbiased');%��ȡ����غ�����lag���Ӳ�����acor���ϵ��
        
        lag_t=lag(251:501)*dt;%Ϊ������
        acor_t=acor(251:501);%Ϊ������
        AutoCorrelation_Function_data=[lag_t',acor_t];
        
        m4={'����ʱ��','���ϵ��'};
        xlswrite(Excel_outputpath_AutoCorrelation_Function_data,m4,name11,'A1');
        disp(strcat('Excel_outputpath_AutoCorrelation_Function_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_AutoCorrelation_Function_data,AutoCorrelation_Function_data,name11,'A2');
        disp(strcat('Excel_outputpath_Output_AutoCorrelation_Function_data_Exceldata:',name11)); %Excel���ݱ�����������������
        
        figure,
        plot(lag(251:501)*dt,acor(251:501),'LineWidth',2);
        title('�����ϵ��'); xlabel('����ʱ��/s'); ylabel('�����ϵ��');
        %axis([0,5,-100000,100000]);
        grid on;
        
        acor2=abs(acor);
        [A_max,L_max] = max(acor2);%��������ֵ��Ӧ��ֵAm������ֵLm
        Delay = lag(L_max)*dt; %����ʱ��timedelay
        text(Delay,A_max,['(',num2str(Delay),',',num2str(A_max),')'],'color','b');%������ֵ
        
        print(gcf,'-dtiff',[Excel_Output_Path_Image,'AutoCorrelation_Function_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
        close all;
    end
    
    %% ����ʱ�����tau
    if  Output_tau==1,
        data=xn;
        tau_max=100;
        n=1;
        
        switch Tau_Method,
            case 1,%���û���Ϣ����ʱ���ӳ�tau
                %data���������ʱ������
                %tau_max�����ʱ���ӳ�
                %n���ȼ��С���ӻ�����
                
                
                [tau,I_sq]=tau_mutual_information(data,tau_max,n);%���㷵��tau ��tau �µĻ���Ϣ����
                
            case 2, %C-C�㷨�������ʱ��tau
                % �������������ӳ�ʱ��tau��ʱ�䴰��tw
                % data������ʱ������
                % tau_max�����ʱ���ӳ�
                % Smean��Sdeltmean,ScorΪ����ֵ
                % tau������õ����ӳ�ʱ��
                % tw��ʱ�䴰��
                data=xn;
                [Smean,Sdeltmean,Scor,tau,tw]=C_C_Method2(data,tau_max);
                
            case 3, % C-C�㷨�������ʱ��tau
                tau=C_C_delay(xn,name11,Excel_Output_Path_Image);
                
            case 4,%ͬʱ�����tau��m
                [tau,m]=CC_Method_tau_m(data,tau_max);
        end
    end
    
    %% ����Ƕ��ά��m
    if Output_m==1,
        switch m_method,
            case 1,%Cao��������embed_m
                min_m=1;
                max_m=10;% min_m,max_m�ֱ�Ϊ��С�����Ƕ��ά��
                data=xn;% dataΪԭʼ����,��������n��1��
                embed_m=embed_m_Cao(data,min_m,max_m,tau);
                
            case 2,%Cao-old��������embed_m
                data=xn; % dataΪԭʼ����
                min_m=1;
                max_m=12;% min_m,max_m�ֱ�Ϊ��С�����Ƕ��ά��
                [embed_m]=embed_m_Cao_Old(data,min_m,max_m,tau);%embed_m:cao����m
                
        end
    end
    
    %% ���л��������ʶ��
    if  HunDun_Analysis==1,

        %�ú���������������(PCA)����ʶ������������
        %�����źŵ���������ͼӦ��һ����������б��Ϊ��ֵ��ֱ�ߣ��������źŵ���������ͼӦ��һ����X��ӽ�ƽ�е�ֱ�ߣ�
        %�ʿ������������ֲ���׼������Ϊʶ������������һ��������
        
        %data������Ĵ�����ʱ������
        %m���ع���ռ��ά��
        %tau:�ع���ռ��ʱ���ӳ�
        %sigma���������ֲ��ı�׼����
        data=xn;
        m=3;
        sigma= PCA(data,m,tau);
    end
    
    %% �������е�ƽ������
    if Output_Period_Mean==1,
        data=xn2;
        T_mean=period_mean_fft(data);%����ƽ������
    end
    
    %% Hurst������ͨ�������о���������Ϊ�ĳ�����ԣ���������ʶ���ź��е����ڳɷ�
    if Output_R_S_Hurst_Analysis==1,
        %ͨ���ڶ�������ϵ�жԼ���(log(n), log(R/S)n)���л��ƣ��Ե㼯������ϣ����Է�����Щ�����λ��һ��ֱ���ϣ���ֱ�ߵ�б��H����Hurstϵ��ֵ��
        %R/S������Ҫ���Ȼ��������̵����еĹ۲�ֵ����˶��� H ������Ԥ�Ⲣ���ʺϡ�
        
        %R/S�������ܽ�һ�����������һ��������������ֿ���������ͨ��R/S�������ܽ��з�����ϵͳ���ڼ�����̵�̽Ѱ
        %��H=0.5ʱ��ʱ�����о��Ǳ�׼��������ߣ������ʳ���̬�ֲ���������Ϊ���ڵļ۸���Ϣ��δ���������Ӱ�죬���г�����Ч�ġ�
        %��0.5��H<1ʱ������״̬�����ԣ�ʱ��������һ���־��ԵĻ�������ǿ�����У���������ѭһ����ƫ��������̣�ƫ�еĳ���������H��0.5����٣�������״̬�£��������ǰһ���������ߵģ���һ��Ҳ����������ߵġ�
        %��0<H��0.5ʱ��ʱ�������Ƿ��־��ԵĻ���״̬�����Եģ���ʱ����������ǰһ���ڼ������ߣ���ô��һ�ڶ�������ߡ�
        
        switch R_S_Hurst_Analysis_Method,
            
            case 1, %�ֳ���ͬ���ȵ������䣬�ٷֱ���м���
                Xtimes=xn(1:250);%����ȡ250�����ݣ�����Ϊ������250��Լ��
                LengthX=length(Xtimes);
                
                %% ����ó�FactorMatrix��FactorNum
                for HurstFactorization=1:1,
                    %���ӷֽ�, ��4��ʼ��LengthX/4����
                    N=LengthX;
                    %N=floor(LengthX); %floor������ʾ��������
                    FactorNum=0; %����������ʼΪ0
                    
                    for i=3:N, %���ӷֽ�, ��4��ʼ��LengthX/4����
                        if mod(LengthX,i)==0, %i���Ա�LengthX����,���õ�һ��ֽⷽ��
                            FactorNum=FactorNum+1;%��������+1
                            FactorMatrix(FactorNum,:)=[i,LengthX/i];%�����з����洢��FactorMatrix��
                        end
                    end
                end
                
                LogRS=zeros(FactorNum,1);%����LogRS��Ϊ�����������ĳ�ʼһ��Ϊ0
                LogN=zeros(FactorNum,1);%����LogN
                
                %% �������
                %������ʽ�ֽⷽ�������������з��飬���� FactorMatrix(i,:)=[8 30]����240��Ԫ�ص���������ת��Ϊ8X30�ľ���
                for i=1:FactorNum, %��������
                    dataM=reshape(Xtimes,FactorMatrix(i,:));
                    MeanM=mean(dataM); %�������ÿ�еľ�ֵ
                    SubM =dataM-repmat( MeanM,FactorMatrix(i,1),1) ;%repmatΪ�ѵ�����,��MeanMֵת��ΪFactorMatrix(i,1)��1�еľ���Ϊ�˷��㱻dataM��ȥ
                    
                    RVector=zeros(FactorMatrix(i,2),1);%FactorMatrix(i,2)�����i�е�2�У����е�i������Ϊ��Լ�����͡����������������(i,2)�������������
                    SVector=zeros(FactorMatrix(i,2),1);
                    
                    %���㣨R/S��n���ۼ�
                    for j=1:FactorMatrix(i,2), %1-���з����б��
                        %SubVector=zeros(FactorMatrix(i,1),1);
                        SubVector=cumsum( SubM(:,j)); %ͨ�����ڼ���һ��������е��ۼ�ֵ,�����÷��������鲻ͬά�����ۼӺ͡�%�������ڵ��ۼƾ�ֵ���
                        RVector(j)=max(SubVector)-min(SubVector); %�ۼ�����е����ֵ����Сֵ֮��
                        SVector(j)=std( dataM(:,j),1); %��������׼����ź����ȡ0����������N-1�������1������ǳ���N
                    end
                    
                    %�ֱ����LogRS��LogN
                    LogRS(i)=log10( sum( RVector./SVector)/ FactorMatrix(i,2) );% LogRS(i)=log10(sum��R/S/ÿ��ĳ��ȣ�)
                    LogN(i)=log10( FactorMatrix(i,1) );% LogN(i)=log10(Լ��)
                end
                
                figure,
                plot(LogN,LogRS);
                hold on
                
                %ʹ����С���˷����лع飬�����˹��ָ��HurstExponent
                HurstExponent=polyfit(LogN,LogRS,1);
                
                %polyfit()���ڶ���ʽ�������,p=polyfit(x,y,m),����, x, yΪ��֪���ݵ�����, �ֱ��ʾ��,������, mΪ��϶���ʽ�Ĵ���, �������m����϶���ʽϵ��, �Ӹߴε��ʹδ��������p��.
                %y0=polyval(p,x0)������ö���ʽ��x0����ֵy0
                testX=1:0.1:ceil(max(LogN));%������
                textY=polyval(HurstExponent,testX);%��Ӧ������϶���ʽ�е�Yֵ
                
                plot(LogN,LogRS,'o',testX,textY)
                hold off
                
            case 2, %����2,��������xn(1:tau)���м��㣬�ı������ĳ��ȣ��Ӷ������ص�ϵ��
                m2=length(xn);%����Ժʿ���ݵĳ���
                
                %��ʼ����ż������ľ���
                lgN=zeros(1,m2);
                lgH=zeros(1,m2);
                lgRS=zeros(1,m2);
                
                for tau=3:m2, %�߶ȴ�3��length(data)�������ӳ߶ȳ���
                    X2=zeros(1,tau); %Ԥ�������䷶Χ
                    data_sr=mean(xn(1:tau)); %�����������ڵľ�ֵ
                    
                    for i=1:tau, %��������
                        X2(i)=sum(xn(1:i)-data_sr);%�������ڵ��ۼƾ�ֵ���
                    end;
                    
                    R=max(X2)-min(X2); %�ۼ�����е����ֵ����Сֵ֮��
                    S=std(xn(1:tau),1); %���ź����ȡ0����������N-1�������1������ǳ���N
                    
                    H=log10(R/S)/log10(tau/2); %Ϊ���Ƕ���֮tau ??'H-track'
                    
                    lgN(tau)=log10(tau);%lg(N)
                    lgH(tau)=H; %H-track
                    lgRS(tau)=log10(R/S); %R/S����
                end;
                
                plot(lgN,lgH,'r--','LineWidth',2);
                hold on
                
                plot(lgN,lgRS,'k-','LineWidth',2);
                legend('H-track','R/S-track','Location','South')
                xlabel('lg(N)'),
                ylabel('lg(R/S)')
                axis([lgN(1) lgN(end) -inf +inf]),
                hold off
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'R_S_Hurst_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                data_Hurst=[lgN',lgH',lgRS'];%�ֱ�Ϊlg(N),H,lg(R/S)
                
                m_Hurst={'lg(N)','lg(R/S)'};
                xlswrite(Excel_outputpath_R_S_Hurst_data,m_Hurst,name11,'A1');
                disp(strcat('Excel_outputpath_R_S_Hurst_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_R_S_Hurst_data,data_Hurst,name11,'A2');
                disp(strcat('Excel_outputpath_R_S_Hurst_data_Exceldata:',name11)); %Excel���ݱ�����������������
                
            case 3, %�ο�����:����������ѹ�������źŷ������Թ����2001��
                % �����������վ���¶ȱ仯��R/S����
                % ���������в���ͼ
                X_xn2=xn2;
                plot(t,X_xn2,'+r'); %����ԭʼ����ɢ��ͼ
                xlabel('ʱ��t/s');
                ylabel('��ѹ/Pa'); %��ע������
                
                for i3=1:length(X_xn2)-1,
                    A(i3)=X_xn2(i3+1)-X_xn2(i3); %����ԭʼ���еĲ������
                end
                
                figure,
                plot(A,'or');
                hold on %����ͼ��
                
                plot(A,'-b'); %���Ʋ������ɢ��ͼ
                xlabel('ʱ��t/s');
                ylabel('��ѹ/Pa'); %��ע������
                hold off
                
                
                % ����ʱ�ͼ����ֵ�ƽ��ֵ����
                [m3,n3]=size(A);                                   %�����������������
                for i3=1:n3,
                    M(i3)=mean(A(1:i3));
                end
                
                % ����ʱ�ͼ����ֵı�׼������
                for i3=1:n3,
                    S(i3)=std(A(1:i3),1);
                end
                
                % ����ʱ�ͼ����ֵļ������к�R/Sֵ
                for i3=1:n3,
                    for j3=1:i3,
                        der(j3)=A(1,j3)-M(1,i3);
                        cum2=cumsum(der);%�ۼ����
                        R(i3)=max(cum2)-min(cum2);% %���㼫������
                    end
                end
                
                %RS=S(2:n).\R(2:n); %����R/Sֵ
                RS=R(2:n3)./S(2:n3); %����R/Sֵ
                %RS=log10(RS);
                
                % ����Hurstָ������ز�������ͼ
                for i3=1:n3,
                    T(i3)=i3;
                end
                
                lag3=T(2:n3)*dt; %������2��n��ʱ����
                %lag3=log10(lag3);
                
                figure,
                plot(lag3/2,RS,'.r'); %����R/S��ʱ�͵�ɢ��ͼ
                xlabel('lag/2'); %�����ǩ
                ylabel('R/S'); %�����ǩ
                hold on %����ͼ��
                
                g=polyfit(log(lag3/2),log(RS),1);
                %polyfit���ڶ���ʽ�������
                %p=polyfit(x,y,m),����, x, yΪ��֪���ݵ�����, �ֱ��ʾ��,������, mΪ��϶���ʽ�Ĵ���, �������m����϶���ʽϵ��, �Ӹߴε��ʹδ��������p��.
                H3=g(1), %����Hurstָ��
                a=exp(g(2)), %��������ϵ��
                
                Cf=corrcoef(log(lag3/2),log(RS)); %�������ϵ��
                R2=Cf(1,2)^2, %��������Ŷ�
                C=2^(2*H3-1)-1, %���������ϵ��
                f1=a*(lag3/2).^H3; %��ָ��ģ��
                
                plot(lag3/2,f1), %��ɢ��ͼ�����������
                hold off, %������ͼ
                
                % �����������վ�¶ȱ仯�ʵ�����ع���
                i4=1:length(A)-1; %���ݱ��
                
                figure,
                plot(A(i4),A(i4+1),'*r'); %���������ͼ
                xlabel('A(i)'); %�����ǩ
                ylabel('A(i+1)'); %�����ǩ
                hold on
                
                g2=polyfit(A(i4),A(i4+1),1); %һ�ζ���ʽ�������
                Cf2=corrcoef(A(i4),A(i4+1)); %�������ϵ������
                C2=Cf2(1,2), %�������ϵ��
                C3=g2(1), %�����ع�ϵ��
                f2=g2(1)*A(i4)+g2(2); %�Իع�ģ��
                
                plot(A(i4),f2), %��ɢ��ͼ�����������
                hold off, %������ͼ
                
                beta3=2*H3+1,
                D3=2-H3,
                
            case 4, %��Դ������ʱ�����з���Դ����.docx��%Hurstָ������
                data=xn;
                n_max=150;
                [ln_RS,ln_n]=Hurst2(data,n_max);
                %data����������ʱ������
                %n_max�������е���󳤶�
                %ln_RS�����ص�ln(R/S)��ֵ
                %ln_n�����ص�ln(n)��ֵ
                
                % �����������
                hold on;
                nn4=6;
                LinearZone = [1:nn4];
                F = polyfit(ln_n(LinearZone),ln_RS(LinearZone),1);
                Hurst_value= F(1),
                
                yp=polyval(F,1:nn4);
                
                plot(1:nn4,yp,'-r');
                text(3.5,3,['Hurst-Value= k= ',num2str(F(1))]);
                hold off
        end
    end
    
    %% ����ά����
    if Output_Correlation_Dimension==1,
        switch Correlation_Dimension_Method, %ѡ�����ά���㷽��
            case 1, %G-P�㷨1
                data=xn2';
                min_m=2; %��С��Ƕ��ά��
                max_m=5; %����Ƕ��ά��
                N=length(xn);%���ݳ���
                %tau=2;%ʱ����ӣ�ͨ��C-C�㷨���м���
                tau1=tau;
                ss=10;
                
                [ln_r,ln_C]=CorrelationDimension_G_P_1(data,N,tau,min_m,max_m,ss);%����G-P�㷨���Թ���ά����
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_1_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
            case 2, %G-P�㷨2
                max_m=10;
                D=CorrelationDimension_G_P_2(data,tau,max_m);
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_2_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
            case 3, %G-P�㷨3
                %data=xn';%the time series
                %N3=length(data):%the length of the time series
                tau1=tau;
                m=3;%Ƕ��ά
                
                [ln_r,ln_C,CorrelationDimension]=CorrelationDimension_G_P_3(xn,tau,m);%����ln_r��ln_C�Լ�����ά��
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_3_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                %close all;
                
            case 4,%G-P-4
                [Log2R,Log2Cr2,xSlope,Slope2,D,A]=CorrelationDimension_G_P_4(xn,name11,Excel_Output_Path_Image);
                
                %ȥ��A,D�е�NaN
                z=find(~isnan(A));%ȥ��A�е�nan,���ط�nan�ı��
                A1=zeros(length(z),1);
                D1=zeros(length(z),1);
                D=D';
                
                for z_i=1:length(z),
                    A1(z_i)=A(z(z_i),1);
                    D1(z_i)=D(z(z_i),1);
                end
                
                %Corrslation_dimension_1=[Log2R,Log2Cr2];%��Ŷ������
                %Corrslation_dimension_2=[xSlope,Slope2];%����ݶ�
                Corrslation_dimension_3=[D1,A1];%��Ź���ά��
                
                m4_Correlation_dimension={'Log2R','Log2Cr2','xSlope','Slope2','D','A'};
                xlswrite( Excel_Outputpath_Correlation_Dimension_data,m4_Correlation_dimension,name11,'A1');
                disp(strcat('Excel_Outputpath_Correlation_Dimension_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                %xlswrite( Excel_Outputpath_Correlation_Dimension_data, Corrslation_dimension_1,name11,'A2');
                %disp(strcat('Excel_Outputpath_Correlation_Dimension_data_Exceldata:',name11)); %Excel���ݱ�����������������
                %xlswrite( Excel_Outputpath_Correlation_Dimension_data, Corrslation_dimension_2,name11,'C2');
                %disp(strcat('Excel_Outputpath_Correlation_Dimension_data_Exceldata:',name11)); %Excel���ݱ�����������������
                xlswrite( Excel_Outputpath_Correlation_Dimension_data, Corrslation_dimension_3,name11,'E2');
                disp(strcat('Excel_Outputpath_Correlation_Dimension_data_Exceldata:',name11)); %Excel���ݱ�����������������
                
            case 5, %��Դ������ʱ�����з���Դ����.docx��G-P�㷨
                % data::�������ʱ������
                % tau:  ʱ���ӳ�
                % min_m:��СǶ��ά
                % max_m:���Ƕ��ά
                % ss:�뾶��������
                
                data=xn;
                min_m=2; %��С��Ƕ��ά��
                max_m=5; %����Ƕ��ά��
                %tau=2;%ʱ����ӣ�ͨ��C-C�㷨���Լ���
                tau1=tau;
                ss=10;
                
                [ln_r,ln_C]=CorrelationDimension_G_P_5(data,tau,min_m,max_m,ss);
                
            case 6,%�����������û���KL�任��G-P ����������������ӹ���ά
                data=xn;
                min_m=3; %��С��Ƕ��ά��
                max_m=5; %����Ƕ��ά��
                %tau=2;%ʱ����ӣ�ͨ��C-C�㷨���Լ���
                tau1=tau;
                ss=10;
                
                [ln_r,ln_C,CorrelationDimension_slope]=CorrelationDimension_G_P_6(data,tau,min_m,max_m,ss);%�ֱ���ln_r,ln_C,����ά��
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_6_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
            case 7,%�������ά��Ƕ��ά

        end
    end
    
    %% ����K��
    %Kolmogorov��������ռ��п̻������˶���һ����Ҫ���ȣ�����ӳ��ϵͳ��̬��������Ϣ��ƽ����ʧ�ʡ�
    if Output_Kolmogorov_entropy==1,
        switch Kolmogorov_entropy_Method,
            case 1, % G-P�㷨
                X=xn;
                fs=Fs;
                t = 2;                 % ʱ��
                dd = 2;                 % Ƕ��ά���
                D = 1:dd:20;            % Ƕ��ά
                p = 1;                 % ���ƶ��ݷ��룬��������ƽ������(�����Ǹ�����ʱ p = 1)
                [Log2R,Log2Cr2,xSlope,Slope2,D_KE,KE]=KolmogorovEntropy_G_P(X,name11,Excel_Output_Path_Image,fs,t,dd,D,p);
                
                % KE ΪNaN��������
            case 2,
               
%                 % ���룺Data  �� ������ʱ������
%                 %      X     �� �ع�����ռ�
%                 %      M     �� �ع���ռ�������ÿ������mά
%                 %      m     �� ���Ƕ��ά��
%                 %      tau   �� ʱ���ӳ�
%                 % �����K    �� �¶�Ī�������
%                 m=3;
%                 M=20;
%                 
%                  K = KolmogorovEntropy(Data,X,M,m,tau);
                
                
            case 3, % �������ʱ������Kolmogorov�ص�STB�㷨
                % Schouten J C,Takens F,van den Bleek C M. Maximum-likelihood Estimation of the Entropy of an Attractor[J]. Phys.Rev.E,1994,49(1):126-129
                %--------------------------------------------------------------------------
                X=xn;
                fs = Fs; % �źŲ���Ƶ��
                h=1/fs;
                t = 1;  % �ع�ʱ��
                dd = 1; % Ƕ��ά���
                D = 1:dd:20; % �ع�Ƕ��ά
                bmax = 60; % �����ɢ����ֵ
                p =  1; %100; % ����ƽ������ (�����Ǹ�����ʱ p = 1)
                
                % ����ÿһ��Ƕ��ά��Ӧ��Kolmogorov��
                tic,%��ʼ��ʱ
                KE = KolmogorovEntropy_STB(X,fs,t,D,bmax,p);%���ú���KolmogorovEntropy_STB����K��
                
                t = toc,%��������ʾ����ִ��ʱ��
                
                % �����ͼ
                figure;
                plot(D,KE,'k.-'); grid on;
                xlabel('m');
                ylabel('Kolmogorov Entropy (nats/s)');
                %title(['Lorenz, length = ',num2str(k2)]);
                
                % �����ʾ
                disp(sprintf('Kolmogorov Entropy = %.4f',min(KE)));
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Kolmogorov_Entropy_STB_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                data1=[D,KE];
                data2=min(KE);
                
                m_STB_K={'D','KE','min(KE)'};
                xlswrite(Excel_Outputpath_Kolmogorov_Entropy_STB_data,m_STB_K,name11,'A1');
                disp(strcat('Excel_Outputpath_Kolmogorov_Entropy_STB_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_Outputpath_Kolmogorov_Entropy_STB_data,data1,name11,'A2');
                disp(strcat('Excel_Outputpath_Kolmogorov_Entropy_STB_data1_Exceldata:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_Outputpath_Kolmogorov_Entropy_STB_data,data2,name11,'C2');
                disp(strcat('Excel_Outputpath_Kolmogorov_Entropy_STB_data2_Exceldata:',name11)); %Excel���ݱ�����������������
        end
    end
    
    %% ͬʱ�������ά��K��
    if Output_Both_Kolmogorov_and_CrosslationsDimension==1,
        switch Both_Kolmogorov_and_CrosslationsDimension_Method,
            case 1,
                %�����������������ά��Kolmogorov��
                %X:lnr������������ĵ�
                %Y:lnC������������ĵ�
                %m_delt:Ƕ��ά������
                %tau:ʱ���ӳ�
                %D2Ϊ����ά��
                %K2ΪKolmogorov������
                
                m_delt=2;
                max_d=50;
                tau1=tau;
                
                for m=min_m:m_delt:max_m,
                    rows_m=(m-min_m)/2+1;
                    ln_r1=ln_r(rows_m,:); %ln_r1��ʾln_r�еĵ�rows_m��
                    ln_C1=ln_C(rows_m,:); %ln_C1��ʾln_C�еĵ�rows_m��
                    
                    %������������
                    nn4=4;
                    LinearZone = 1:nn4;
                    X=ln_r1(LinearZone);
                    Y=ln_C1(LinearZone);
                    
                    [D2,K2]=Kolmogorov_D2_K2(X,Y,m_delt,tau1)
                end
                
            case 2,
                
        end
    end
    
    %% �������lyapunovָ��
    if Output_Largest_Lyapunov_Exponent==1,
        switch  Largest_Lyapunov_Exponent_Method,
            case 1, % ����С��������1�������ʱ������ Lyapunov ָ��
                tau1=tau;
                m = 3; % Ƕ��ά
                data=xn ; % ���������� n*1
                taumax =50; % �����ɢ����ʱ��
                P = 1; % ����ƽ������
                
                Lyapunov1=Largest_Lyapunov1(data,m,tau,taumax,P); %����������ŵ��ָ��
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Lyapunov_Exponents_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
            case 2,% ����С��������2�������ʱ������ Lyapunov ָ��
                max_d=50;
                tau1=tau;
                fs = Fs; % ����Ƶ��
                t = tau;   % ʱ��
                d = 3;   % Ƕ��ά
                tmax = 50; % �����ɢ����ʱ��
                p = 1;  % ����ƽ������
                data=xn; %ʱ�������ź�
                
                [I,Y,diff_Y_I,Lyapunov1_2,Lyapunov1_e]=Largest_Lyapunov_Rosenstein2(data,fs,t,d,tmax,p);
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Lyapunov_Exponents_2',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
            case 3, %��Դ������ʱ�����з���Դ����.docx��G-P�㷨
                %ע�⣺"�������õ���lambda_1���ܵ������lyapunovָ���������������������ѡ��������������ϣ��˴��Ĵ�����Ϊ�˳���ķ���"
                %������ʹ��С�����������������lyapunovָ��
                %data:ʱ������
                %m:Ƕ��ά
                %tau:ʱ���ӳ�
                %P:ʹ�� FFT�������ʱ������ƽ������
                data=xn;
                m=3;
                P=1;
                max_d=50;
                tau1=tau;
                
                lambda_1=Largest_lyapunov_exponent_3(data,m,tau,P);%��Ҫ�ֶ��޸���������
                
            case 4, % �ú�����������ʱ�����е����Lyapunov ָ��--Wolf ����"
                % m: Ƕ��ά��
                % tau:ʱ���ӳ�
                % data:ʱ������
                % N:ʱ�����г���
                % P:ʱ�����е�ƽ������,ѡ���ݻ����൱ǰ���λ�ò������ǰ���ΪI�����ݻ����ֻ����|I��J|>P���������Ѱ
                m=3;
                data=xn;
                N=length(xn);
                P=1;
                lambda_1=Largest_lyapunov_exponent_wolf_4(data,N,m,tau,P),
                
        end
    end
    
    %% ����Lyapunovָ����
    if Output_Lyapunov_Exponents==1,
        switch Lyapunov_Exponents_Method,%ѡ����㷽��
            case 1,% ����BBA�㷨����Lyapunovָ����
                fs = Fs;% ����Ƶ��
                t = 1; % �ع�ʱ��
                t2 = 1; % ����ʱ��
                dl = 3; % �ֲ�Ƕ��ά
                dg = 4; % ȫ��Ƕ��ά
                o = 2; % ����ʽ��Ͻ���
                p = 1; % ����ƽ������ (�����Ǹ�����ʱ p = 1)
                
                X=xn;
                %--------------------------------------------------------------------------
                tic,
                [LE,K] = LyapunovSpectrum_BBA(X,fs,t,t2,dl,dg,o,p);%����BBA�㷨����LyapunovSpectrum
                
                t = toc,
                %--------------------------------------------------------------------------
                % �����ͼ
                
                figure;
                plot(K,LE)
                xlabel('K');
                ylabel('Lyapunov Exponents (nats/s)');
                % title(['Henon, length = ',num2str(k2)]);
                %--------------------------------------------------------------------------
                % �����ʾ
                LE = LE(:,end)%���Leָ���������
        end
    end
    
    %% ���幹���ͷ��Ϣ
    Excel_title{i,1}=name11;
    count=count+1, %����
end

%% ������ܺ����ؼ�����
for Sum_i=1:1,
    %% ԭʼ�ź�
    if Output_Original_Signal==1,
    end
    
    %%  ͳ����Ϣ���㣬����ƽ��ֵ����׼�ƫ�ȣ����
    if Output_Statistical_Information==1,
        %��ͷ��������Ϣ
        Case_m={'��������','ƽ��ֵ','��׼��','ƽ������ƫ��','ƫ��Sk','���K'};
        E22={Case_m};
        E21={Excel_title};
        
        %% ������ݼ���ͷ������Ϣ1
        %������ͷ
        xlswrite(Excel_outputpath_Statistical_Information_data,E22{1,1},num2str(numi),'A1');
        disp('Excelheader output is OK!'); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Statistical_Information_data,E21{1,1},num2str(numi),'A2');
        disp('Case_name output is OK!'); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Statistical_Information_data,Bubble2_Sum,num2str(numi),'B2');
        disp('Case_data output is OK!'); %Excel���ݱ�ı�ͷ�������
    end
    
    %%  Ƶ�׷���
    if Output_Frequency_Analysis==1,
    end
    
    %% �������ܶȷ���
    if Output_Power_Spectrum_Density_Analysis==1,
    end
    
    %% С������
    if Output_Wavelet_Analysis==1,
        %��ͷ��������Ϣ
        Case_m={'��������','d1','d2','d3','d4','d5','d6','d7','a7'};
        E22={Case_m};
        E21={Excel_title};
        
        %% ������ݼ���ͷ������Ϣ
        %������ͷ
        xlswrite(Excel_outputpath_Wavelet_Analysis_Energy_data,E22{1,1},num2str(numi),'A1');
        disp('Excelheader output is OK!'); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Wavelet_Analysis_Energy_data,E21{1,1},num2str(numi),'A2');
        disp('Case_name output is OK!'); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Wavelet_Analysis_Energy_data,Wavelet_Energy_Distribution_Sum,num2str(numi),'B2');
        disp('Case_data output is OK!'); %Excel���ݱ�ı�ͷ�������
    end
    
    %% С�����任����
    if Output_Wavelet_Packet_Transform==1,
        %��ͷ��������Ϣ
        Case_m={'��������','(3,0)','(3,1)','(3,2)','(3,3)','(3,4)','(3,5)','(3,6)','(3,7)'};
        E22={Case_m};
        E21={Excel_title};
        
        %% ������ݼ���ͷ������Ϣ
        %������ͷ
        xlswrite(Excel_outputpath_Wavelet_Packet_Energy_data,E22{1,1},num2str(numi),'A1');
        disp('Excelheader output is OK!'); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Wavelet_Packet_Energy_data,E21{1,1},num2str(numi),'A2');
        disp('Case_name output is OK!'); %Excel���ݱ�ı�ͷ�������
        
        xlswrite(Excel_outputpath_Wavelet_Packet_Energy_data,Wavelet_Packet_Energy_Distribution_Sum,num2str(numi),'B2');
        disp('Case_data output is OK!'); %Excel���ݱ�ı�ͷ�������
    end
    
    %% ����غ������� 
    if Output_AutoCorrelation_Function ==1,
    end
    
    %% Hurst����
    if Output_R_S_Hurst_Analysis==1,
    end
    
    %% ����ά����
    if Output_Correlation_Dimension==1,
    end
    
    %% ����K��
    if Output_Kolmogorov_entropy==1,
    end
    
    %% ����Lyapunovָ����
    if Output_Lyapunov_Exponents==1,
    end
end
