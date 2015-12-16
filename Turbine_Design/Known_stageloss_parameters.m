function [sl_num,sl_a,sl_K1,sl_ec,sl_Be,sl_sn,sl_Ce,sl_zp,sl_up,sl_dp,sl_detp,sl_ut,sl_ot,sl_detz,sl_detr,sl_zr]=Known_stageloss_parameters
%******************************************************
%级内损失详细计算所需系数
%叶高损失所需系数sl_a,叶轮摩擦损失所需系数sl_K1,鼓风损失所需系数sl_ec,sl_Be,斥汽损失sl_sn,sl_Ce
%隔板漏汽损失所需系数sl_zp,sl_up,sl_dp(mm),sl_detp(mm)，
%叶顶漏汽损失所需系数sl_ut,sl_ot,sl_detz,sl_detr(mm),sl_zr(mm)
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
sl_num=3;
sl_a=[1.2 1.2 1.2];
sl_K1=[1.05 1.05 1.05];
sl_ec=[0 0 0];
sl_Be=[0.15 0 0];
sl_sn=[6 0 0];
sl_Ce=[0.012 0 0];
sl_zp=[0 3 5];
sl_up=[0 0.75 0.75];
sl_dp=[0 789 2531];
sl_detp=[0 0.8 6.5];
sl_ut=[0 0.55 0.55];
sl_ot=[0 0.479 0.461];
sl_detz=[0 10 21.2];
sl_detr=[0 0.8 7.2];
sl_zr=[0 3 5];
% sl_num=1;
% sl_a=1.2;
% sl_K1=1.05;
% sl_ec=0;
% sl_Be=0.15;
% sl_sn=6;
% sl_Ce=0.012;
% sl_zp=0 ;
% sl_up=0;
% sl_dp=0;
% sl_detp=0;
% sl_ut=0;
% sl_ot=0;
% sl_detz=0;
% sl_detr=0;
% sl_zr=0;