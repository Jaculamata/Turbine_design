function [X,V,H,S] = PT(P,T)
%***************************************
% ��֪ѹ���¶������ʺ���
%  Parameters: P      ѹ��   MPa 
%              t      �¶�   �� 
%              V      ����   m^3/kg 
%              H      ����   kJ/kg
%              S      ����   kJ/(kg.�� )
%              x      �ɶ�  ��<1(���ȶȡ棩
% ****���ߣ����� zrqwl2003@126.com*****************  
%***************************************
        TS = TSK(P);
        X = T - TS;
  %      if (X < 0)
 %             [V,H,S]=PTF(P, T);
  %      end   д�����ˡ���
        if (X <= 0)
              [V,H,S]=PTF(P, T);
        end  
        if (X > 0)
              [V,H,S]=PTG(P, T);
        end
        X = X + 1; %??