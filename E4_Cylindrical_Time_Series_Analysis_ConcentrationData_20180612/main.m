% close all
% clc
data=xn;
%% -------------------------------------------
PreStep=input('������Ԥ�ⲽ��(Ĭ��Ϊ10��)=');
if isempty(PreStep)
    PreStep=10
else
   PreStep
end

 max_m=input('������cao����G_P����max_m(Ĭ��Ϊ20)=');
if isempty(max_m)
    max_m=20
else
   max_m
end

 max_N=input('������С���ֽ����(Ĭ��Ϊ3)=');
if isempty(max_N),
    max_N=3,
else
   max_N,
end

if max_N==0,
    main_process(data,PreStep,max_m);
else
    disp('---------С�����ֽ�-----------------')
    [A,D]=wave(data,max_N);
    main_process(A,PreStep,max_m);
    for i=1:max_N,
        main_process(D(i,:)',PreStep,max_m);
    end
end
    
    
    