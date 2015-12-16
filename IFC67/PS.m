function [X, T, V, H] = PS(P, S)
%***************************************
% ��֪ѹ�����������ʺ���
%  Parameters: P      ѹ��   MPa 
%              t      �¶�   �� 
%              V      ����   m^3/kg 
%              H      ����   kJ/kg
%              S      ����   kJ/(kg.�� )
%              x      �ɶȡ���<1(���ȶȡ棩
% ****���ߣ����� zrqwl2003@126.com*****************
%***************************************
TS = TSK(P);
[VG, HG, SG]=PTG(P, TS);
[VF, HF, SF]=PTF(P, TS);
if (S < SF) %THen GoTo 10 ˵��������Һ̬ˮ�ɶ�Ϊ0
    X = 0;
    T = 89.85 * S;
    while(1)
       [V, H, SB]=PTF(P,T);
        X = T - TS;
        if (abs(S - SB) <= 0.0000005)
            break;
        end
        T = T + 89.85 * (S - SB);       %��ʲôԭ���������
    end
else
    if (S <= SG) %THen GoTo 20      %������Һ�����
        X = (S - SF) / (SG - SF);    %�ɶ�ֱ��ͨ����ʽ����  
        T = TS;
        V = VF + X * (VG - VF);
        H = HF + X * (HG - HF);    %��Һ�����Ļ�������
    else    
        X = 1;    %ȫΪ��̬
        n = 1;
        ZP = P / 980.7;
        ZS = 0.23888846 * S;  %����
        while(1)
            ZT = (ZS - 1.44) * 1.1594 * log(10) + 0.25381 * 1.1594 * log(ZP);
            ZT = exp(ZT);
            T = 1000 * ZT - 273.15;
            if (T < TS) %THen GoTo 30  ����Һ̬ˮ
                T = TS;
                SB = SG;
                V = VG;
                H = HG;
                ZT = (273.15 + T) / 1000;
                ZSB = (log(ZT) / 1.1594 - 0.25381 * log(ZP)) / log(10) + 1.44;            
            else
                [V, H, SB]=PTG(P,T);   %����������
                ZSB = ZS;
            end
            X = T - TS;
            if (X >= 1)% THen GoTo 50
            else
                X = X + 1;
            end
            if (abs(S - SB) <= 0.00000005)% THen GoTo 1000
                break;
            end
            if (n <= 1) %THen GoTo 60
                ZS = ZSB + 0.1672 * (S - SB);
            else
                ZS = ZSB + (S - SB) * (ZSB - ZSA) / (SB - SA);               
            end
            n = n + 1;
            SA = SB;
            ZSA = ZSB;
        end
    end
end
