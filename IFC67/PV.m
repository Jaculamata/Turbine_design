function [X, T, S, H] = PV(P, V)
%***************************************
% ��֪ѹ�����������ʺ���
%  Parameters: P      ѹ��   MPa 
%              t      �¶�   �� 
%              V      ����   m^3/kg 
%              H      ����   kJ/kg
%              S      ����   kJ/(kg.�� )
%              x      �ɶȡ���<1(���ȶȡ棩
% ****���ߣ����� zrqwl2003@126.com********  
%***************************************
%��������
TS = TSK(P);
[VG, HG, SG]=PTG(P, TS);
[VF, HF, SF]=PTF(P, TS);
if (V > VG) 
    X = 0;
    T = TS;
    while(1)
       [VB, H, S]=PTG(P,T);
        X = T - TS;
        if (abs(V - VB) <= 0.0000005)
            break;
        end
        T = T + 0.1;
    end
else
    if  (V > VF)      
        X = (V - VF) / (VG - VF); 
        T = TS;
        S = SF + X * (SG - SF);
        H = HF + X * (HG - HF);
    else
        X = 0;
        T = TS;
        while(1)
           [VB, H, S]=PTF(P,T);
           X = T - TS;
            if (abs(V - VB) <= 0.00000005)
                break;
            end
            T = T - 0.1;
        end
    end
end
