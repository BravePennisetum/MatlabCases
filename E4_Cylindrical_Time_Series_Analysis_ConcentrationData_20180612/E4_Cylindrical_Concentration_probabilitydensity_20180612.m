%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ���ܣ�1���Դ��㲻ͬλ�ÿ�϶��ʱ���źŵ�ԭʼ�źţ�ͳ����Ϣ���㣨ƽ��ֵ����׼�ƫ�ȡ���ȣ���Ƶ�׷������������ܶȡ�С�������������ֲ������ϵ���ȼ���
%%% ������K:\ʵ��¼������(����)\Բ���ι���������ʵ��\��ѹ�������������������о�\����Ũ��\����Ũ�Ȼ���
%%% ע�⣺�˳����������ݽ�ȡ֮��
%%% �μ���
%%% ���ڣ�2018��06��12��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear all; close all; clc;
Path='E:\����Ũ�Ȼ���';
name0='�ŵ�һ��';%����Ŀ��

for numi=1:4, %numi=5; %��2-10��Ϊ��ѹ�ź�����,��9�飬��9�����У��ֶ��޸ģ��ֱ�Ϊ2,3,4,5,6,7,8,9,10,���벼���ľ���ֱ�Ϊ20��40,60,80,100,120,140,160,180mm,��(numi-1)*20mm
    statistical_analysis=1; %����ͳ�Ʒ���
    
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
        end
        
    end
    
    %%
    count=0; %����ͳ���Ѿ���ɼ���Ĺ�����������ʼ��Ϊ0
    Excel_title=cell(72,1); %���ڴ�Ź���������
    Bubble2_Sum=[]; %���ڻ���ͳ�Ƽ�����
    
    for i=1:72, %��Ӧ21������
        name1=num2str(i); %ͨ������Casename�������幤������
        Excel_readpath=strcat(Path,'\',name0,'\',name1,'\',num2str(numi),'.xlsx'); %'.xlsx'�ļ�������·��
        [signal_Data,str]=xlsread(Excel_readpath,1); %��ȡExcel������Ϊ��num2str(numi)�Ĺ���������,signal_Data������ݣ�str�д���ַ�
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
            Excel_outputpath_Original_Increments_Probability_density_data=strcat(Path2,'\',num2str(numi),'\','ԭʼ�ź����������ܶȺ�������.xlsx');%���幤������ԭʼ�źŸ����ܶȺ�����·��
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
                [xn2_x,yy2,xi,ff]=signal_probability_density2(xn,60);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                %�ֱ�Ϊ��'ѹ��1(Pa)','(��״ͼ-��ɢ�ź�)Ƶ��','ѹ��2��Pa��','(����ͼ-�����ź�)�����ܶ�'
                title('�ź�xn�����ܶȷֲ�');
                %axis([0,0.6,0,0.6])
                xlabel('ѹ��(Pa)');
                ylabel('pdf');
                hold off
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Original_Singal_Probability_density_',name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                %����������
                Original_Singal_Probability_density_Temp1=[xn2_x,yy2];
                Original_Singal_Probability_density_Temp2=[xi,ff];
                m_Original_Singal_Probability_density={'Ũ��1','(��״ͼ-��ɢ�ź�)Ƶ��','Ũ��2','(����ͼ-�����ź�)�����ܶ�'};
                
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
                delay_N1=50; %���Ӳ���
                delay_time=delay_N1/Data_numi_Fs; %����ʱ��
                pressure_increment_data= pressure_increments2(xn,Data_numi_Fs,delay_time); %����p(t+delta_t)-p(t)
                [xn2_x,yy2,xi,ff]=signal_probability_density2(pressure_increment_data,60);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                
                title('�ź������ĸ����ܶȷֲ�');
                %axis([0,0.6,0,0.6])
                xlabel('����(Pa)');
                ylabel('pdf');
                hold on
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Original_Singal_Increments_Probability_density_',num2str(delay_N1),name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                Original_Singal_Probability_density_Temp1=[xn2_x,yy2];
                Original_Singal_Probability_density_Temp2=[xi,ff];
                
                delay_N2=20; %���Ӳ���
                delay_time=delay_N2/Data_numi_Fs; %����ʱ��
                pressure_increment_data= pressure_increments2(xn,Data_numi_Fs,delay_time); %����p(t+delta_t)-p(t),���س��Ӳ�ֵ������
                [xn2_x,yy2,xi,ff]=signal_probability_density2(pressure_increment_data,60);%���ú���"signal_probability_density.m"�����źŵĸ����ܶȺ�����ֱ��ͼ
                
                title('�ź������ĸ����ܶȷֲ�');
                %axis([0,0.6,0,0.6])
                xlabel('����(Pa)');
                ylabel('pdf');
                hold on
                
                print(gcf,'-dtiff',[Excel_Output_Path_Image,'Original_Singal_Increments_Probability_density_',num2str(delay_N2),name11,'.tiff']);  %����tiff��ʽ��ͼƬ��ָ��·��
                close all;
                
                Original_Singal_Probability_density_Temp3=[xn2_x,yy2];
                Original_Singal_Probability_density_Temp4=[xi,ff];
                m_Original_Singal_Probability_density={'Ũ��1_delay_N1','(��״ͼ-��ɢ�ź�)Ƶ��','Ũ��2_delay_N1','(����ͼ-�����ź�)�����ܶ�','Ũ��1_delay_N2','(��״ͼ-��ɢ�ź�)Ƶ��','Ũ��2_delay_N2','(����ͼ-�����ź�)�����ܶ�'};
                
                %������ؽ����ָ��Excel��
                xlswrite(Excel_outputpath_Original_Increments_Probability_density_data,m_Original_Singal_Probability_density,name11,'A1');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data_Excelheader:',name11)); %Excel���ݱ�ı�ͷ�������
                
                xlswrite(Excel_outputpath_Original_Increments_Probability_density_data,Original_Singal_Probability_density_Temp1,name11,'A2');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_outputpath_Original_Increments_Probability_density_data,Original_Singal_Probability_density_Temp2,name11,'C2');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_outputpath_Original_Increments_Probability_density_data,Original_Singal_Probability_density_Temp3,name11,'E2');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
                
                xlswrite(Excel_outputpath_Original_Increments_Probability_density_data,Original_Singal_Probability_density_Temp4,name11,'G2');
                disp(strcat('Excel_outputpath_Original_Singal_Probability_density_data:',name11)); %Excel���ݱ�����������������
            end
        end
        
         %% ���幹���ͷ��Ϣ
        Excel_title{i,1}=name11;
        count=count+1, %����
    end
    
    %% ������ܺ����ؼ�����
    if i==72,
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
                
                xlswrite(Excel_outputpath_Statistical_Information_data,Bubble2_Sum,num2str(numi),'B2');
                disp('Case_data output is OK!'); %Excel���ݱ�ı�ͷ�������
            end
        end
    end
end
