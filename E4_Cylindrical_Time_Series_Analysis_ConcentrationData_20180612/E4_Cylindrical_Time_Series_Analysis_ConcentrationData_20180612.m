%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ���ܣ�1���Դ��㲻ͬλ�ÿ�϶��ʱ���źŵ�ԭʼ�źţ�ͳ����Ϣ���㣨ƽ��ֵ����׼�ƫ�ȡ���ȣ���Ƶ�׷������������ܶȡ�С�������������ֲ������ϵ���ȼ���
%%% ������K:\ʵ��¼������(����)\Բ���ι���������ʵ��\��ѹ�������������������о�\����Ũ��\����Ũ�Ȼ���
%%% ע�⣺�˳����������ݽ�ȡ֮��
%%% �μ���
%%% ���ڣ�2018��06��12��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear all; close all; clc;
Path='K:\ʵ��¼������(����)\Բ���ι���������ʵ��\��ѹ�������������������о�\����Ũ��\����Ũ�Ȼ���';
name0='�ŵ�һ��';%����Ŀ����7080Ŀ����250um

for numi=4:4, %numi=5; %��2-10��Ϊ��ѹ�ź�����,��9�飬��9�����У��ֶ��޸ģ��ֱ�Ϊ2,3,4,5,6,7,8,9,10,���벼���ľ���ֱ�Ϊ20��40,60,80,100,120,140,160,180mm,��(numi-1)*20mm
    statistical_analysis=1; %����ͳ�Ʒ���
    frequency_analysis=1; %����Ƶ�����
    chaotic_analysis=1; %���л������
    
    %% ����ȷ��Ҫ���еļ��㷽��
    for calculate_method=1:1,
        %% ԭʼ�ź�
        Output_Original_Signal=1; %ԭʼ�ź�
        
        %% ͳ�Ʒ���
        if statistical_analysis==1,
            %
            Output_Statistical_Information=1; %ͳ����Ϣ���㣬����ƽ��ֵ����׼�ƫ�ȣ����
            Output_Original_Singal_Probability_density=1; %����ԭʼ�źŵĸ����ܶȺ���
            Output_probability_distribution_of_pressure_increments=1; %����ԭʼ�ź������ĸ����ܶȺ���
            %
            Output_calcualte_average_cycle_time=1;%����ƽ��ѭ��ʱ��
            Output_cycle_time_distribution=1;%�����ź�����ѭ������ѭ��ʱ��
            Output_cycle_time_probability_density_distribution=1;%�����źŵĸ����ܶȺ���
        end
        
        %% Ƶ�����
        if frequency_analysis==1,
            %
            Output_Frequency_Analysis=1; % Ƶ�׷���
            Output_Power_Spectrum_Density_Analysis=1; % �������ܶȷ���
            PSD_Method=1; %�����õļ���PSD������%1-PSD_WELCH������%2-���ֹ����׼��㷽���Ա�
            %
            Output_Wavelet_Analysis=1; %С������
            Output_Wavelet_Packet_Transform=1; %С��������
            %
            Output_AutoCorrelation_Function =1;% ����غ�������
        end
        
        %% �������
        if chaotic_analysis==1,
            %
            Output_tau=1;%����ʱ���ӳ�tau,%ʱ���ӳ���Ҫһֱ���ڱ�ѡ��״̬
            %
            Output_m=1;%����Ƕ��ά��m
            %
            HunDun_Analysis=1;%���л��������ʶ��
            %
            Output_Period_Mean=1;%��������ƽ������
            %
            Output_R_S_Hurst_Analysis=1; %R/S����������Hustָ��
            R_S_Hurst_Analysis_Method=4; %1:����ı����������򣬵ȳ���������2�������㲢��չ��һ��������
            %
            Output_Correlation_Dimension=0; %����ά����
            Correlation_Dimension_Method=6; %G-P�㷨���������ά,����4���Խ�����ά�����������excel��,����6����KL�任
            %
            Output_Kolmogorov_entropy=1; %����K��
            Kolmogorov_entropy_Method=1; %1:G-P�㷨��2�� ��3:STB�㷨
            %Kolmogorov��������ռ��п̻������˶���һ����Ҫ���ȣ�����ӳ��ϵͳ��̬��������Ϣ��ƽ����ʧ�ʡ�
            %
            Output_Largest_Lyapunov_Exponent=1;%���lyapunovָ������
            %
            Output_Lyapunov_Exponents_Spectrum=1; %����Lyapunovָ����
            Lyapunov_Exponents_Spectrum_Method=1; %1������BBA�㷨����Lyapunovָ���ף�
        end
    end
    
    %%
    count=0; %����ͳ���Ѿ���ɼ���Ĺ�����������ʼ��Ϊ0
    Excel_title=cell(72,1); %���ڴ�Ź���������
    Bubble2_Sum=[]; %���ڻ���ͳ�Ƽ�����
    average_cycle_time_t_sum=[];%���ڻ���ƽ��ѭ��ʱ��
    Wavelet_Energy_Distribution_Sum=[]; %���ڻ���С������������
    Wavelet_Packet_Energy_Distribution_Sum=[]; %���ڻ���С��������������
    sum_data_all=[];%���ڻ��ܻ�������ļ�����
    
    for i=1:72, %��Ӧ21������
        name1=num2str(i); %ͨ������Casename�������幤������
        Excel_readpath=strcat(Path,'\',name0,'\',name1,'\',num2str(numi),'.xlsx'); %'.xlsx'�ļ�������·��
        [signal_Data,str]=xlsread(Excel_readpath,num2str(numi)); %��ȡExcel������Ϊ��num2str(numi)�Ĺ���������,signal_Data������ݣ�str�д���ַ�
        signal_Data=signal_Data(:,2)/1000;%�ڶ�������Ϊ��ȡѡ��������
        
        %ȥ�������е�NaN�������ڵ���
        [m,xn]=find(isnan(signal_Data));    % �ҳ�NaN����λ��
        signal_Data(m,:)=[]; %ɾ������NaN���У�x(:,n)=[]����ɾ����
        
        signal_Data_OriginalVoltage=signal_Data; %���ڱ���ԭʼ��ѹ�ź�
        
        %% ���ñ궨�������б궨������
        %         fileName=strcat('K:\ʵ��¼������(����)\ѭ��������ʵ��\�궨����\̽��궨ֵ20180414.xlsx');%���Excel�ļ�������
        %         sheetName='7080';%�����ߴ�
        %         fit_Order=3; %��Ͻ���
        %         K=E3_nihe_biaoding(fileName,sheetName,fit_Order);%���ñ궨��Ϻͺ������б궨�����ض���ʽϵ�����ֱ�Ϊ�Ӹ߽׵��ͽ׵�ϵ��
        %
        %         fix_Factor=4.5/4.2;%����ϵ��
        %         signal_Data=signal_Data/1000*fix_Factor;%�Ե�ѹ���ݽ�������
        
        %% ����Ũ�Ȼ���ϵ��
        if ((i<=24) && (i>=1)),% 637um��Eps=-0.0023744?V6+0.034899?V5-0.19195?V4+0.4645?V3-0.41233?V2+0.1451?V
            K1=-0.0023744;
            K2=0.034899;
            K3=-0.19195;
            K4=0.4645;
            K5=-0.41233;
            K6=0.1451;
            
        elseif ((i<=48) && (i>=25)),%537um��Eps=-0.00074066?V6+0.013488?V5-0.091961?V4+0.27586?V3-0.30551?V2+0.13817?V
            K1=-0.00074066;
            K2=0.013488;
            K3=-0.091961;
            K4=0.27586;
            K5=-0.30551;
            K6=0.13817;
            
        elseif ((i<=72) && (i>=49)),%373um��Eps=-0.0019129?V6+0.029739?V5-0.17156?V4+0.43142?V3-0.39647?V2+0.14975?V
            K1=-0.0019129;
            K2=0.029739;
            K3=-0.17156;
            K4=0.43142;
            K5=-0.39647;
            K6=0.14975;
            
        end
        
        %����ɿ���Ũ���ź�
        [row,column]=size(signal_Data); %row�����У�column������
        for row_i=1:row,
            for column_i=1:column,
                temp1=signal_Data(row_i,column_i);
                temp2=K1*temp1^6+K2*temp1^5+K3*temp1^4+K4*temp1^3+K5*temp1^2+K6*temp1;
                signal_Data(row_i,column_i)=temp2;
            end
        end
        
        %% ����Ϊ��������Ҫ�޸ĵĲ���
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Data_numi=signal_Data;
        Data_numi_length=length(Data_numi); %���ݳ���
        Data_numi_length=Data_numi_length;
        Data_numi_Fs=200; %����Ƶ��
        Data_numi_dt=1/Data_numi_Fs; %����ʱ����,1/200
        Data_numi_Order=0:(Data_numi_length-1); %�������,��0��ʼ���
        Data_numi_time=Data_numi_Order*Data_numi_dt;%���ݲɼ���ʱ������
        Data_numi_time=Data_numi_time';%ת��Ϊ������
        
        name11=strcat(name1,'_',num2str(numi)); %������ļ����֣�����'1_1'
        
        Path2=strcat(Path,'\',name0,'\','������','\','����Ũ��');
        mkdir(Path2,num2str(numi)); %�����ļ��У����ڴ����36����������ͬλ�ô��ļ���������
        Path3=strcat(Path2,'\',num2str(numi));
        mkdir(Path3,'����ͼ��'); %��Path3�ļ����´�����Ϊ������ͼ���ļ��У����ڴ洢Matlab�Զ����ɵ�ͼ����Ϣ
        
        Bubble_t=Data_numi_time;  %��1��Ϊʱ������
        Bubble20=Data_numi; %ʵ������
        
        %Bubble21=distrend_data(Bubble20,Data_numi_Fs,4); %����distrend_data������������С���˷�ȥ��������,���У�3������ʾ��3�ζ���ʽ�������
        Bubble21=Bubble20;
        xn=Bubble21;
        abs_xn=abs(Bubble21); %����ֵ
        data=Bubble21;
        
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
            Excel_outputpath_calcualte_average_cycle_time_data=strcat(Path2,'\',num2str(numi),'\','ƽ��ѭ��ʱ�����.xlsx');%���幤����ƽ��ѭ��ʱ��ı���·��
            Excel_outputpath_cycle_time_distribution_data=strcat(Path2,'\',num2str(numi),'\','����ѭ������ѭ��ʱ�����.xlsx');%���幤�������ź�����ѭ������ѭ��ʱ��ı���·��
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
            %
            Excel_Outputpath_Output_Lyapunov_Exponents_data=strcat(Path2,'\',num2str(numi),'\','Lyapunovָ���׻���.xlsx');%���屣��STB�㷨�����K������·��
            %
            Excel_Outputpath_sum_data_all=strcat(Path2,'\',num2str(numi),'\','sum_data_all.xlsx');%���屣��STB�㷨�����K������·��
        end
        
        %% ���ԭʼ�źŵ�Excel��
        if  Output_Original_Signal==1;
            Original_data=[Bubble_t,signal_Data_OriginalVoltage,Bubble20,Bubble21];%���ڴ��ʱ�����ݣ�ԭʼ��ֵ���ݣ�ȥ����ѹ��ķ�ֵ����
            m1={'ʱ��','ԭʼ��ѹ�ź�','ԭʼ��ֵ','ȥ���������ķ�ֵ'};
            
            xlswrite(Excel_outputpath_Original_Signal_data,m1,name11,'A1');
            disp(strcat('Excel_outputpath_Original_Signal_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
            
            xlswrite(Excel_outputpath_Original_Signal_data,Original_data,name11,'A2');
            disp(strcat('Excel_outputpath_Original_Signal_data_Exceldata:',name11)); %Excel���ݱ�����������������
        end
        
        %% ͳ�Ʒ���
        if statistical_analysis==1,
            % ����ƽ��ֵ����׼���ȣ�ƫ��
            if Output_Statistical_Information==1,
                Bubble20_mean=mean(Bubble20);
                Bubble20_length=length(Bubble20);
                
                %�����׼��
                Bubble20_std=std(Bubble20);%��׼ƫ��
                
                %����ƽ������ƫ��
                Bubble21_Average_Absolute_Deviation=mean(abs(Bubble21));%ƽ������ƫ��,���м���
                
                %���֥, ����ѭ������������¯��������������CPFD��ֵģ���ʵ���о�, 2015, �й���ѧԺ�о���Ժ(�����������о���).P43
                %����ƫ��
                Bubble20_Sk_sum=0;
                for j=1:Bubble20_length,
                    Bubble20_Sk_sum=Bubble20_Sk_sum+xn(j)^3;
                end
                Bubble20_Sk=Bubble20_Sk_sum/(Data_numi_length*Bubble20_std^3);
                
                %���֥, ����ѭ������������¯��������������CPFD��ֵģ���ʵ���о�, 2015, �й���ѧԺ�о���Ժ(�����������о���).P43
                %������
                Bubble20_K_sum=0;
                for j=1:Bubble20_length,
                    Bubble20_K_sum=Bubble20_K_sum+xn(j)^4;
                end
                
                Bubble20_K=Bubble20_K_sum/(Data_numi_length*Bubble20_std^4);
                
                Bubble2_Temp=[Bubble20_mean,Bubble20_std,Bubble21_Average_Absolute_Deviation,Bubble20_Sk,Bubble20_K];%�ֱ�Ϊƽ��ֵ����׼�����ƫ��ƽ��ֵ��ƫ��Sk�����K
                Bubble2_Sum=[Bubble2_Sum;Bubble2_Temp];%���ܼ���Ľ���������Excel�Ĵ�����������ڻ��ܺ������
            end
            
            %% ����ԭʼ�źŵĸ����ܶȺ���
            %�ο����ף����ٷ壬Һ��������ѭ��������ѹ�������źŵ�ͳ�Ƽ�Ƶ�׷��������̹���ѧ����2006.
            if Output_Original_Singal_Probability_density==1,
                [xn2_x,yy2,xi,ff]=signal_probability_density(xn,30);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                %�ֱ�Ϊ��'ѹ��1(Pa)','(��״ͼ-��ɢ�ź�)Ƶ��','ѹ��2��Pa��','(����ͼ-�����ź�)�����ܶ�'
                title('�ź�xn�����ܶȷֲ�');
                %axis([0,0.6,0,0.6])
                xlabel('ѹ��(Pa)');
                ylabel('pdf');
                hold off
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Original_Singal_Probability_density_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                %����������
                Original_Singal_Probability_density_Temp1=[xn2_x',yy2'];
                Original_Singal_Probability_density_Temp2=[xi',ff'];
                m_Original_Singal_Probability_density={'ѹ��1(Pa)','(��״ͼ-��ɢ�ź�)Ƶ��','ѹ��2��Pa��','(����ͼ-�����ź�)�����ܶ�'};
                
                %������ؽ����ָ��Excel��
                xlswrite(Excel_outputpath_Original_Singal_Probability_density_data,m_Original_Singal_Probability_density,name11,'A1');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_Original_Singal_Probability_density_data,Original_Singal_Probability_density_Temp1,name11,'A2');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_outputpath_Original_Singal_Probability_density_data,Original_Singal_Probability_density_Temp2,name11,'C2');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
            end
            
            %% ����ԭʼ�ź������ĸ����ܶȺ���
            if Output_probability_distribution_of_pressure_increments==1,
                delay_N=10; %���Ӳ���
                delay_time=delay_N/Data_numi_Fs; %����ʱ��
                pressure_increment_data= pressure_increments(xn,Data_numi_Fs,delay_time); %����p(t+delta_t)-p(t)
                [xn2_x,yy2,xi,ff]=signal_probability_density(pressure_increment_data,30);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                
                title('�ź������ĸ����ܶȷֲ�');
                %axis([0,0.6,0,0.6])
                xlabel('����(Pa)');
                ylabel('pdf');
                hold on
                
                delay_N=5; %���Ӳ���
                delay_time=delay_N/Data_numi_Fs; %����ʱ��
                pressure_increment_data= pressure_increments(xn,Data_numi_Fs,delay_time); %����p(t+delta_t)-p(t)
                [xn2_x,yy2,xi,ff]=signal_probability_density(pressure_increment_data,30);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                
                %print(gcf,'-dtiff',[Excel_Output_Path_Image,'Original_Singal_Probability_density_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                %close all;
            end
            
            %% ����ƽ��ѭ��ʱ�䣬�㷨���������ƽ��ֱֵ�ߵĽ������
            if Output_calcualte_average_cycle_time==1,
                average_cycle_time_t_temp = calcualte_average_cycle_time(xn,Data_numi_Fs);
                average_cycle_time_t_sum=[average_cycle_time_t_sum; average_cycle_time_t_temp];%���뵽��һ����
            end
            
            %% �����ź�����ѭ������ѭ��ʱ��
            if Output_cycle_time_distribution==1,
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                [whole_cycle_time_sum,half_cycle_time_sum] = cycle_time_distribution(xn,Data_numi_Fs);%�ֱ𷵻�����ѭ��ʱ�䡢��ѭ��ʱ��
                
                % ����ѭ��ʱ����
                m_cycle_time={'����ѭ�����','����ѭ��ʱ��','��ѭ�����','��ѭ��ʱ��'};
                
                %������ؽ����ָ��Excel��
                xlswrite(Excel_outputpath_cycle_time_distribution_data,m_cycle_time,name11,'A1');
                disp(strcat('Excel_outputpath_cycle_time_distribution_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_cycle_time_distribution_data,whole_cycle_time_sum,name11,'A2');
                disp(strcat('Excel_outputpath_cycle_time_distribution_data:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_outputpath_cycle_time_distribution_data,half_cycle_time_sum,name11,'C2');
                disp(strcat('Excel_outputpath_cycle_time_distribution_data:',name11)); %Excel���ݱ�����������������
                
                %��������ʱ��ĸ����ܶȺ���
                if Output_cycle_time_probability_density_distribution==1,
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %����ѭ��ʱ����ʷֲ�
                    [xn2_x,yy2,xi,ff]=signal_probability_density(whole_cycle_time_sum(:,2),10);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                    %�ֱ�Ϊ��'ѹ��1(Pa)','(��״ͼ-��ɢ�ź�)Ƶ��','ѹ��2��Pa��','(����ͼ-�����ź�)�����ܶ�'
                    title('�ź����ڸ����ܶȷֲ�');
                    %axis([0,0.6,0,0.6])
                    xlabel('whole cycle time');
                    ylabel('pdf');
                    hold off
                    
                    print(gcf,'-dtiff',[Excel_Output_Path_Image,'whole_cycle_time_probability_density_distribution_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                    close all;
                    
                    cycle_time_probability_density_distribution_Temp11=[xn2_x',yy2'];
                    cycle_time_probability_density_distribution_Temp21=[xi',ff'];
                    m_cycle_time_probability_density_distribution={'��������ʱ��1(s)','(��״ͼ-��ɢ�ź�)Ƶ��','��������ʱ��2(s)','(����ͼ-�����ź�)�����ܶ�'};
                    
                    %������ؽ����ָ��Excel��
                    xlswrite(Excel_outputpath_cycle_time_distribution_data,m_cycle_time_probability_density_distribution,name11,'F1');
                    disp(strcat('Excel_outputpath_whole_cycle_time_distribution_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                    
                    xlswrite(Excel_outputpath_cycle_time_distribution_data,cycle_time_probability_density_distribution_Temp11,name11,'F2');
                    disp(strcat('Excel_outputpath_whole_cycle_time_distribution_data:',name11)); %Excel���ݱ�����������������
                    
                    xlswrite(Excel_outputpath_cycle_time_distribution_data,cycle_time_probability_density_distribution_Temp21,name11,'H2');
                    disp(strcat('Excel_outputpath_whole_cycle_time_distribution_data:',name11)); %Excel���ݱ�����������������
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    % ��ѭ��ʱ����ʷֲ�
                    [xn2_x,yy2,xi,ff]=signal_probability_density(half_cycle_time_sum(:,2),10);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                    %�ֱ�Ϊ��'ѹ��1(Pa)','(��״ͼ-��ɢ�ź�)Ƶ��','ѹ��2��Pa��','(����ͼ-�����ź�)�����ܶ�'
                    title('�ź����ڸ����ܶȷֲ�');
                    %axis([0,0.6,0,0.6])
                    xlabel('half cycle time');
                    ylabel('pdf');
                    hold off
                    
                    print(gcf,'-dtiff',[Excel_Output_Path_Image,'half_cycle_time_probability_density_distribution_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                    close all;
                    
                    cycle_time_probability_density_distribution_Temp12=[xn2_x',yy2'];
                    cycle_time_probability_density_distribution_Temp22=[xi',ff'];
                    m_cycle_time_probability_density_distribution={'������ʱ��1(s)','(��״ͼ-��ɢ�ź�)Ƶ��','������ʱ��2(s)','(����ͼ-�����ź�)�����ܶ�'};
                    
                    %������ؽ����ָ��Excel��
                    xlswrite(Excel_outputpath_cycle_time_distribution_data,m_cycle_time_probability_density_distribution,name11,'K1');
                    disp(strcat('Excel_outputpath_half_cycle_time_distribution_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                    
                    xlswrite(Excel_outputpath_cycle_time_distribution_data,cycle_time_probability_density_distribution_Temp12,name11,'K2');
                    disp(strcat('Excel_outputpath_half_cycle_time_distribution_data:',name11)); %Excel���ݱ�����������������
                    
                    xlswrite(Excel_outputpath_cycle_time_distribution_data,cycle_time_probability_density_distribution_Temp22,name11,'M2');
                    disp(strcat('Excel_outputpath_half_cycle_time_distribution_data:',name11)); %Excel���ݱ�����������������
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
            end
        end
        
        %% Ƶ�����
        if frequency_analysis==1,
            %% Ƶ�׷���
            if Output_Frequency_Analysis==1,
                y=fft(xn,Data_numi_length);%����Ҷ�任
                mag=abs(y);
                f=(0:length(y)-1)'*Data_numi_Fs/length(y);%������Ƶ�ʵı��ʽΪf=(0:M-1)*Fs/M;
                frequency_data=[f(1:Data_numi_length/2),mag(1:Data_numi_length/2)];
                
                m2={'Ƶ��/Hz','��ֵ'};
                xlswrite(Excel_outputpath_Frequency_Analysis_data,m2,name11,'A1');
                disp(strcat('Excel_outputpath_Frequency_Analysis_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_Frequency_Analysis_data,frequency_data,name11,'A2');
                disp(strcat('Excel_outputpath_Frequency_Analysis_data_Exceldata:',name11)); %Excel���ݱ�����������������
                
                figure,
                plot(f(1:Data_numi_length/2),mag(1:Data_numi_length/2),'LineWidth',2);%����Ƶ��ͼ
                axis([0,20,0,150])
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
                        
                        nfft=800; %FFT�任����
                        Nseg=800; %�ֶμ��
                        window1=hamming(600); %ѡ�õĴ���-����������
                        %window1=hanning(length(xn)); %ѡ�õĴ���-����������
                        noverlap=200; %�ֶ������ص��Ĳ�������(����)
                        range='half'; %Ƶ�ʼ��Ϊ[0 Fs/2]��ֻ����һ���Ƶ��
                        f=(0:Nseg/2)*Data_numi_Fs/Nseg; %Ƶ��������
                        
                        Sx1=psd(xn,Nseg,Data_numi_Fs,window1,noverlap,'none');
                        %Sx1=10*log10(Sx1);
                        Plot_Pxx11=Sx1;
                        Plot_Pxx12=10*log10(Sx1);
                        
                        Sx2=pwelch(xn,window1,noverlap,nfft,Data_numi_Fs,'oneside')*Data_numi_Fs/2; %pwelch()���صĵ��߹����������Fs/2
                        %Sx2=10*log10(Sx2);
                        Plot_Pxx21=Sx2;
                        Plot_Pxx22=10*log10(Sx2);
                        
                        window2=boxcar(length(xn));      %PSD_WELCH�����������δ�����
                        Sx3=pwelch(xn,window2,noverlap,Data_numi_length,Data_numi_Fs,'oneside')*Data_numi_Fs/2;
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
                        axis([0,20,0,5]);
                        xlabel('Ƶ��/Hz');
                        ylabel('������');
                        title('������-Welch��-������-pwelch()����');
                        grid on
                        
                        subplot(3,1,3),
                        plot(f,Plot_Pxx31(1:length(f)),'LineWidth',2);
                      axis([0,20,0,5]);
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
                        %axis([0,20,0,5]);
                        xlabel('Ƶ��/Hz');
                        ylabel('������');
                        title('������-Welch��-psd()����');
                        grid on;
                        
                        subplot(3,1,2),
                        plot(f,Plot_Pxx22,'LineWidth',2);  %���ƹ�����
                        %axis([0,20,0,5]);
                        xlabel('Ƶ��/Hz');
                        ylabel('������');
                        title('������-Welch��-������-pwelch()����');
                        grid on;
                        
                        subplot(3,1,3),
                        plot(f,Plot_Pxx32(1:length(f)),'LineWidth',2);
                        %axis([0,20,0,5]);
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
                        f=(0:length(Pxx)-1)*Data_numi_Fs/length(Pxx);    %���������׶�Ӧ��Ƶ��
                        
                        figure,
                        subplot(4,2,1),
                        plot(f(1:Nsec/2),Pxx(1:Nsec/2),'LineWidth',2);       %���ƹ���������
                        xlabel('Ƶ��/Hz');
                        ylabel('������ /dB');
                        title('ƽ������ͼ');
                        grid on
                        
                        %% �����ź��ص��ֶι��ƹ�����
                        pxx1=abs(fft(xn(1:100),Nsec).^2)/Nsec;   %��һ�ι�����
                        pxx2=abs(fft(xn(51:150),Nsec).^2)/Nsec;  %�ڶ��ι�����
                        pxx3=abs(fft(xn(101:200),Nsec).^2)/Nsec; %�����ι�����
                        pxx4=abs(fft(xn(151:251),Nsec).^2)/Nsec; %���Ķι�����
                        Pxx=(pxx1+pxx2+pxx3+pxx4)/4; %������ƽ����ת��ΪdB
                        f=(0:length(Pxx)-1)*Data_numi_Fs/length(Pxx);  %Ƶ������
                        
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
                        f=(0:length(Pxx)-1)*Data_numi_Fs/length(Pxx);  %���Ƶ������
                        
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
                        f=(0:length(Pxx)-1)*Data_numi_Fs/length(Pxx); %Ƶ������
                        
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
                        [Pxx,Pxxc,f]=psd(xn,Nfft,Data_numi_Fs,window,noverlap,0.95);   %�����׹���,����0.95�����Ŷȸ����������䣬�޷���ֵ�ǻ��Ƴ���������
                        
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
                        [Pxx,f]=pwelch(xn,window,noverlap,Data_numi_length,Data_numi_Fs,range);
                        %plot_Pxx=10*log10(Pxx);
                        
                        subplot(4,2,6),
                        plot(f,Pxx,'LineWidth',2),
                        title('PSD��Welch����2');
                        grid on
                        
                        %% ����ط���MEM����
                        [Pxx1,f]=pmem(xn,20,Nfft,Data_numi_Fs);   %��������ط��������˲�������20�����ƹ�����
                        
                        subplot(4,2,7),
                        plot(f,Pxx1,'LineWidth',2);   %���ƹ�����
                        xlabel('Ƶ��/Hz');ylabel('������/dB');title('����ط� Order=20ԭʼ�źŹ�����');
                        grid on
                        
                        %% �öര�ڷ�(MTM)
                        [Pxx1,f]=pmtm(xn,2,Nfft,Data_numi_Fs); %�öര�ڷ�(NW=4)���ƹ�����
                        
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
                
                a7=wrcoef('a',C,L,'db2',7); %0-1.625Hz��      �ع���7���Ƶ�ź�
                d7=wrcoef('d',C,L,'db2',7); %1.625-3.25Hz���ع���7���Ƶ�ź�
                d6=wrcoef('d',C,L,'db2',6); %3.25-6.5Hz��  �ع���6���Ƶ�ź�
                d5=wrcoef('d',C,L,'db2',5); %6.5-12.5Hz��    �ع���5���Ƶ�ź�
                d4=wrcoef('d',C,L,'db2',4); %12.5-25Hz��      �ع���4���Ƶ�ź�
                d3=wrcoef('d',C,L,'db2',3); %25-50Hz��       �ع���3���Ƶ�ź�
                d2=wrcoef('d',C,L,'db2',2); %50-100Hz��         �ع���2���Ƶ�ź�
                d1=wrcoef('d',C,L,'db2',1); %100-200Hz��           �ع���1���Ƶ�ź�
                
                wavelet_sum_signals=[Data_numi_time,a7,d7,d6,d5,d4,d3,d2,d1,xn];%ע�������t������������ת��Ϊ������
                
                m5={'t','a7','d7','d6','d5','d4','d3','d2','d1','xn'};
                xlswrite(Excel_Outputpath_Wavelet_Sum_data,m5,name11,'A1');
                disp(strcat('Excel_Outputpath_Wavelet_Sum_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_Outputpath_Wavelet_Sum_data,wavelet_sum_signals,name11,'A2');
                disp(strcat('Excel_Outputpath_Wavelet_Sum_data_Exceldata:',name11)); %Excel���ݱ�����������������
                
                %���������ź���Ϣ
                figure,
                subplot(9,1,1),
                plot(Data_numi_time,a7,'linewidth',2);
                %axis([0,5,-200,200]);
                ylabel('a7');
                grid on;%��4���Ƶ�ź�
                
                subplot(9,1,2),
                plot(Data_numi_time,d7,'linewidth',2);
                %axis([0,5,-500,500]);
                ylabel('d7');
                grid on;%��4���Ƶ�ź�
                
                subplot(9,1,3),
                plot(Data_numi_time,d6,'linewidth',2);
                %axis([0,5,-1000,1000]);
                ylabel('d6');
                grid on;%��3���Ƶ�ź�
                
                subplot(9,1,4),
                plot(Data_numi_time,d5,'linewidth',2);
                %axis([0,5,-1000,1000]);
                ylabel('d5');
                grid on;%��2���Ƶ�ź�
                
                subplot(9,1,5),
                plot(Data_numi_time,d4,'linewidth',2);
                %axis([0,5,-200,200]);
                ylabel('d4');
                grid on;%��1���Ƶ�ź�
                
                subplot(9,1,6),
                plot(Data_numi_time,d3,'linewidth',2);
                %axis([0,5,-200,200]);
                ylabel('d3');
                grid on;%��1���Ƶ�ź�
                
                subplot(9,1,7),
                plot(Data_numi_time,d2,'linewidth',2);
                %axis([0,5,-200,200]);
                ylabel('d2');
                grid on;%��1���Ƶ�ź�
                
                subplot(9,1,8),
                plot(Data_numi_time,d1,'linewidth',2);
                %axis([0,5,-200,200]);
                ylabel('d1');
                grid on;%��1���Ƶ�ź�
                
                subplot(9,1,9),
                plot(Data_numi_time,xn,'linewidth',2);
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
                
                Wavelet_Packet_Sum_Signals=[Data_numi_time,xn30,xn31,xn32,xn33,xn34,xn35,xn36,xn37,xn];
                
                m6={'t','xn30','xn31','xn32','xn33','xn34','xn35','xn36','xn37','xn'};
                xlswrite(Excel_Outputpath_Wavelet_Packet_Transform_Sum_data,m6,name11,'A1');
                disp(strcat('Excel_Outputpath_Wavelet_Packet_Sum_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_Outputpath_Wavelet_Packet_Transform_Sum_data,Wavelet_Packet_Sum_Signals,name11,'A2');
                disp(strcat('Excel_Outputpath_Wavelet_Packet_Sum_data_Exceldata:',name11)); %Excel���ݱ�����������������
                
                figure,
                subplot(9,1,1);
                plot(Data_numi_time,xn30);
                ylabel('xn130');
                
                subplot(9,1,2);
                plot(Data_numi_time,xn31);
                ylabel('xn131');
                
                subplot(9,1,3);
                plot(Data_numi_time,xn32);
                ylabel('xn132');
                
                subplot(9,1,4);
                plot(Data_numi_time,xn33);
                ylabel('xn133');
                
                subplot(9,1,5);
                plot(Data_numi_time,xn34);
                ylabel('xn134');
                
                subplot(9,1,6);
                plot(Data_numi_time,xn35);
                ylabel('xn135');
                
                subplot(9,1,7);
                plot(Data_numi_time,xn36);
                ylabel('xn136');
                
                subplot(9,1,8);
                plot(Data_numi_time,xn37);
                ylabel('xn137');
                
                subplot(9,1,9);
                plot(Data_numi_time,xn);
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
                
                lag_t=lag(251:501)*Data_numi_dt;%Ϊ������
                acor_t=acor(251:501);%Ϊ������
                AutoCorrelation_Function_data=[lag_t',acor_t];
                
                m4={'����ʱ��','���ϵ��'};
                xlswrite(Excel_outputpath_AutoCorrelation_Function_data,m4,name11,'A1');
                disp(strcat('Excel_outputpath_AutoCorrelation_Function_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_AutoCorrelation_Function_data,AutoCorrelation_Function_data,name11,'A2');
                disp(strcat('Excel_outputpath_Output_AutoCorrelation_Function_data_Exceldata:',name11)); %Excel���ݱ�����������������
                
                figure,
                plot(lag(251:501)*Data_numi_dt,acor(251:501),'LineWidth',2);
                title('�����ϵ��'); xlabel('����ʱ��/s'); ylabel('�����ϵ��');
                %axis([0,5,-100000,100000]);
                grid on;
                
                acor2=abs(acor);
                [A_max,L_max] = max(acor2);%��������ֵ��Ӧ��ֵAm������ֵLm
                Delay = lag(L_max)*Data_numi_dt; %����ʱ��timedelay
                text(Delay,A_max,['(',num2str(Delay),',',num2str(A_max),')'],'color','b');%������ֵ
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'AutoCorrelation_Function_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
            end
        end
        
        if chaotic_analysis==1,
            %% ����ʱ�����tau
            if  Output_tau==1,
                
                disp('---------����Ϣ����tau----------')
                tau = Mutual_Information_main(data);
            end
            
            %% ����Ƕ��ά��m
            if Output_m==1,
                disp('---------cao����m----------')
                min_m=1;
                max_m=20;
                m=4;%embed_m_Cao(data,min_m,max_m,tau)
                close
            end
            
            %% �������е�ƽ������
            if Output_Period_Mean==1,
                disp('-------��ƽ������ P-----------')
                P=ave_period(data);
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
                            Data_numi_length=LengthX;
                            %N=floor(LengthX); %floor������ʾ��������
                            FactorNum=0; %����������ʼΪ0
                            
                            for i=3:Data_numi_length, %���ӷֽ�, ��4��ʼ��LengthX/4����
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
                        X_xn2=Bubble20;
                        plot(Data_numi_time,X_xn2,'+r'); %����ԭʼ����ɢ��ͼ
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
                                cum2=cumsum(der); %�ۼ����
                                R(i3)=max(cum2)-min(cum2); % %���㼫������
                            end
                        end
                        
                        %RS=S(2:n).\R(2:n); %����R/Sֵ
                        RS=R(2:n3)./S(2:n3); %����R/Sֵ
                        %RS=log10(RS);
                        
                        % ����Hurstָ������ز�������ͼ
                        for i3=1:n3,
                            T(i3)=i3;
                        end
                        
                        lag3=T(2:n3)*Data_numi_dt; %������2��n��ʱ����
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
                        text(3.5,3,['Hurst-Value= k= ',num2str(Hurst_value)]);
                        hold off
                end
            end
            
            %% ����ά����
            if Output_Correlation_Dimension==1,
                switch Correlation_Dimension_Method, %ѡ�����ά���㷽��
                    case 1, %G-P�㷨1
                        data=Bubble20';
                        min_m=2; %��С��Ƕ��ά��
                        max_m=7; %����Ƕ��ά��
                        Data_numi_length=length(xn);%���ݳ���
                        %tau=2;%ʱ����ӣ�ͨ��C-C�㷨���м���
                        tau1=tau;
                        ss=10;
                        
                        [ln_r,ln_C]=CorrelationDimension_G_P_1(data,Data_numi_length,tau,min_m,max_m,ss);%����G-P�㷨���Թ���ά����
                        
                        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_1_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                        close all;
                        
                    case 2, %G-P�㷨2
                        D0=CorrelationDimension_G_P_2(data,tau,max_m);
                        
                        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_2_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                        close all;
                        
                        m2={'D'};
                        xlswrite(Excel_Outputpath_Correlation_Dimension_data,m2,name11,'A1');
                        disp(strcat('Excel_Outputpath_Correlation_Dimension_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                        
                        xlswrite(Excel_Outputpath_Correlation_Dimension_data,D0',name11,'A2');
                        disp(strcat('Excel_Outputpath_Correlation_Dimension_data_Exceldata:',name11)); %Excel���ݱ�����������������
                        
                        
                        
                    case 3, %G-P�㷨3
                        %data=xn';%the time series
                        %N3=length(data):%the length of the time series
                        
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
                        ss=10;
                        [ln_r,ln_C]=CorrelationDimension_G_P_5(data,tau,min_m,max_m,ss);
                        
                    case 6,%�����������û���KL�任��G-P ����������������ӹ���ά
                        ss=10;
                        
                        [ln_r,ln_C,CorrelationDimension_slope]=CorrelationDimension_G_P_6(data,tau,min_m,max_m,ss);%�ֱ���ln_r,ln_C,����ά��
                        
                        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Correlation_Dimension_G_P_6_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                        close all;
                end
            end
            
            %% ����K��
            %Kolmogorov��������ռ��п̻������˶���һ����Ҫ���ȣ�����ӳ��ϵͳ��̬��������Ϣ��ƽ����ʧ�ʡ�
            if Output_Kolmogorov_entropy==1,
                switch Kolmogorov_entropy_Method,
                    case 1, % G-P�㷨
                        X=xn;
                        fs=Data_numi_Fs;
                        tau = 2;                 % ʱ��
                        dd = 2;                 % Ƕ��ά���
                        D = 1:dd:20;            % Ƕ��ά
                        p = 1;                 % ���ƶ��ݷ��룬��������ƽ������(�����Ǹ�����ʱ p = 1)
                        [Log2R,Log2Cr2,xSlope,Slope2,D_KE,KE]=KolmogorovEntropy_G_P(X,name11,Excel_Output_Path_Image,fs,tau,dd,D,p);
                        
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
                        fs = Data_numi_Fs; % �źŲ���Ƶ��
                        h=1/fs;
                        tau = 1;  % �ع�ʱ��
                        dd = 1; % Ƕ��ά���
                        D = 1:dd:20; % �ع�Ƕ��ά
                        bmax = 60; % �����ɢ����ֵ
                        p =  1; %100; % ����ƽ������ (�����Ǹ�����ʱ p = 1)
                        
                        % ����ÿһ��Ƕ��ά��Ӧ��Kolmogorov��
                        tic,%��ʼ��ʱ
                        KE = KolmogorovEntropy_STB(X,fs,tau,D,bmax,p);%���ú���KolmogorovEntropy_STB����K��
                        
                        t = toc,%��������ʾ����ִ��ʱ��
                        
                        % �����ͼ
                        figure;
                        plot(D,KE,'k.-'); %DΪǶ��ά
                        grid on;
                        xlabel('m');
                        ylabel('Kolmogorov Entropy (nats/s)');
                        %title(['Lorenz, length = ',num2str(k2)]);
                        
                        % �����ʾ
                        disp(sprintf('Kolmogorov Entropy = %.4f',min(KE)));
                        
                        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Kolmogorov_Entropy_STB_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                        close all;
                        
                        data1=[D',KE'];
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
            
            %% �������lyapunovָ��
            if Output_Largest_Lyapunov_Exponent==1,
                N=Data_numi_length;
                %disp('-------��С���ݷ������lyapunovָ��-------------')
                %Lyapunov1=LargestLyapunov(data,m,tau,P)
                
                        disp('-------wolf�������lyapunovָ��-------------')
                        Lyapunov1=lyapunov_wolf(data,N,m,tau,P)
            end
            
            %% ����Lyapunovָ����
            if Output_Lyapunov_Exponents_Spectrum==1,
                switch Lyapunov_Exponents_Spectrum_Method,%ѡ����㷽��
                    case 1,% ����BBA�㷨����Lyapunovָ����
                        fs = Data_numi_Fs;% ����Ƶ��
                        %                 t = 1; % �ع�ʱ��
                        t2 = 1; % ����ʱ��
                        dl = 3; % �ֲ�Ƕ��ά
                        dg = 4; % ȫ��Ƕ��ά
                        o = 2; % ����ʽ��Ͻ���
                        p = 1; % ����ƽ������ (�����Ǹ�����ʱ p = 1)
                        
                        [LE,K] = LyapunovSpectrum_BBA(data,fs,tau,t2,dl,dg,o,p);%����BBA�㷨����LyapunovSpectrum
                        % �����ͼ
                        
                        figure;
                        plot(K,LE)
                        xlabel('K');
                        ylabel('Lyapunov Exponents (nats/s)');
                        % title(['Henon, length = ',num2str(k2)]);
                        
                        print(gcf,'-dtiff',[Excel_Output_Path_Image,'Lyapunov_Exponents_Spectrum_',name11,'.tiff']);   %����tiff��ʽ��ͼƬ��ָ��·��
                        close all;
                        
                        %--------------------------------------------------------------------------
                        % �����ʾ
                        LE = LE(:,end),%���Leָ���������
                        
                        %���浽ָ��λ��
                        m_LE={'ָ����'};
                        xlswrite(Excel_Outputpath_Output_Lyapunov_Exponents_data,m_LE,name11,'A1');
                        disp(strcat('Excel_Outputpath_Output_Lyapunov_Exponents_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                        
                        xlswrite(Excel_Outputpath_Output_Lyapunov_Exponents_data,LE,name11,'A2');
                        disp(strcat('Excel_Outputpath_Output_Lyapunov_Exponents_data_Exceldata:',name11)); %Excel���ݱ�����������������
                end
            end
            
            sum_data_all_temp=[tau,m,P,Hurst_value,min(KE),Lyapunov1];
            sum_data_all=[sum_data_all;sum_data_all_temp];
        end
        
        %% ���幹���ͷ��Ϣ
        Excel_title{i,1}=name11;
        count=count+1, %����
    end
    
    %% ������ܺ����ؼ�����
    if i==72,
        %% ԭʼ�ź�
        if Output_Original_Signal==1,
        end
        
        if statistical_analysis==1, %����ͳ�Ʒ���
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
                
                xlswrite(Excel_outputpath_Statistical_Information_data,sum_data_all,num2str(numi),'B2');
                disp('Case_data output is OK!'); %Excel���ݱ�ı�ͷ�������
            end
            
            if Output_calcualte_average_cycle_time==1,
                m_cycle_time1={'����','ƽ��ѭ��ʱ��(s)'};
                E21={Excel_title};
                
                xlswrite(Excel_outputpath_calcualte_average_cycle_time_data,m_cycle_time1,num2str(numi),'A1');
                disp(strcat('Excel_outputpath_calcualte_average_cycle_time_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_calcualte_average_cycle_time_data,E21{1,1},num2str(numi),'A2');
                disp('Output_Case_name_is_OK!'); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_calcualte_average_cycle_time_data,average_cycle_time_t_sum,num2str(numi),'B2');
                disp(strcat('Excel_outputpath_calcualte_average_cycle_time_data_Exceldata:',name11)); %Excel���ݱ�����������������
            end
        end
        
        %% Ƶ�����
        if frequency_analysis==1,
            %Ƶ�׷���
            if Output_Frequency_Analysis==1,
            end
            
            %�������ܶȷ���
            if Output_Power_Spectrum_Density_Analysis==1,
            end
            
            %С������
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
            
            %С�����任����
            if Output_Wavelet_Packet_Transform==1,
                %��ͷ��������Ϣ
                Case_m={'��������','(3,0)','(3,1)','(3,2)','(3,3)','(3,4)','(3,5)','(3,6)','(3,7)'};
                E22={Case_m};
                E21={Excel_title};
                
                %������ݼ���ͷ������Ϣ
                %������ͷ
                xlswrite(Excel_outputpath_Wavelet_Packet_Energy_data,E22{1,1},num2str(numi),'A1');
                disp('Excelheader output is OK!'); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_Wavelet_Packet_Energy_data,E21{1,1},num2str(numi),'A2');
                disp('Case_name output is OK!'); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_Wavelet_Packet_Energy_data,Wavelet_Packet_Energy_Distribution_Sum,num2str(numi),'B2');
                disp('Case_data output is OK!'); %Excel���ݱ�ı�ͷ�������
            end
            
            %����غ�������
            if Output_AutoCorrelation_Function ==1,
            end
        end
        
        %% �������
        if chaotic_analysis==1,
            %Hurst����
            if Output_R_S_Hurst_Analysis==1,
            end
            
            %����ά����
            if Output_Correlation_Dimension==1,
            end
            
            %����K��
            if Output_Kolmogorov_entropy==1,
            end
            
            %����Lyapunovָ����
            if Output_Lyapunov_Exponents_Spectrum==1,
            end
            
            Case_m={'��������','tau','m','P','Hurst_value','min(KE)','Lyapunov1','lmd1_wolf'};
            E22={Case_m};
            E21={Excel_title};
            
            %������ͷ
            xlswrite(Excel_Outputpath_sum_data_all,E22{1,1},num2str(numi),'A1');
            disp('Excelheader output is OK!'); %Excel���ݱ�ı�ͷ�������
            
            xlswrite(Excel_Outputpath_sum_data_all,E21{1,1},num2str(numi),'A2');
            disp('Case_name output is OK!'); %Excel���ݱ�ı�ͷ�������
            
            xlswrite(Excel_Outputpath_sum_data_all,sum_data_all,num2str(numi),'B2');
            disp('Case_name output is OK!'); %Excel���ݱ�ı�ͷ�������
        end
    end
end
