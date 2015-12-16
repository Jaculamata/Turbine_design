function [T,V,H,S] = PX(P,X)
%***************************************
% ��֪ѹ���ɶ������ʺ���
%  Parameters: P      ѹ��   MPa 
%              t      �¶�   �� 
%              V      ����   m^3/kg 
%              H      ����   kJ/kg
%              S      ����   kJ/(kg.�� )
%              x      �ɶ�   ��<1(���ȶȡ棩
% ****���ߣ����� zrqwl2003@126.com**********  ��
%***************************************
T = TSK(P);
[VG, HG, SG]=PTG(P, T);
[VF, HF, SF]=PTF(P, T);
V = VF + X * (VG - VF);
H = HF + X * (HG - HF);
S = SF + X * (SG - SF);