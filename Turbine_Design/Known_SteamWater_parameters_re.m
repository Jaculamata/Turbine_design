% function [h_num,h_name,d_pd,pc,h_p,h_t,d_order,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts]=Known_SteamWater_parameters_re;
% %******************************************************
% %���¼�����ˮ�����������(50MW)
% %���ȼ���h_num;����������h_name;%����������ѹ��(MPa)d_pd;
% %������ѹ��(MPa)pc;����ѹ��(MPa)h_p;�����¶�(��)/�ɶ�h_t;���������d_order;
% %������ˮ��ȴ��h_cooler;%���ڶ˲�(��)dt_out;��ڶ˲�(��);dt_in;��ˮ��ѹͷ(MPa)
% %fwp_outp;����ˮ��ѹͷ(MPa)cwp_outp;%����ѹ��(%)h_Dp;��ˮ������(��)fwp_ts;����ˮ������(��)cwp_ts;
% ****���ߣ����� zrqwl2003@126.com***
% %******************************************************
% h_num=7;
% h_name=[{'#1'} {'#2'} {'#3'} {'#4'} {'#5'} {'#6'} {'#7'} {'#8'}];
% d_pd=0.588;
% pc=0.0046;
% h_p=[5.928 3.622 1.64 0.81 0.5344 0.2374 0.1350 0.02567];
% h_t=[383 317 433 335 232 140 193 0.9526];
% d_order=4;
% %������ˮ��ȴ����
% h_cooler=[1 1 1 0 1 1 1 1];
% %���ڶ˲�(��)��
% dt_out=[-1.6 0 0 0 2.8 2.8 2.8 2.8];
% %��ڶ˲�(��)��
% dt_in=[5.6 5.6 5.6 0 5.6 5.6 5.6 5.6];
% %��ˮ��ѹͷ(MPa)��
% fwp_outp=19.82;
% %����ˮ��ѹͷ(MPa)����
% cwp_outp=1.73;
% %����ѹ��(%):
% h_Dp=[0.06 0.06 0.06 0.06 0.06 0.06 0.06 0.06] ;
% %��ˮ������(��)��
% fwp_ts=3.4;
% %����ˮ������(��)����
% cwp_ts=1;
function [h_num,h_name,d_pd,pc,h_p,h_t,d_order,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts]=Known_SteamWater_parameters_re;
%******************************************************
%���¼�����ˮ�����������(300MW)
%���ȼ���h_num;����������h_name;%����������ѹ��(MPa)d_pd; ������ѹ��(MPa)pc;
%����ѹ��(MPa)h_p;�����¶�(��)/�ɶ�h_t;���������d_order; ������ˮ��ȴ��h_cooler;
% ���ڶ˲�(��)dt_out;��ڶ˲�(��);dt_in;��ˮ��ѹͷ(MPa);fwp_outp;����ˮ��ѹͷ(MPa)cwp_outp;
% ����ѹ��(%)h_Dp;��ˮ������(��)fwp_ts;����ˮ������(��)cwp_ts;
%******************************************************
h_num=8;h_name=[{'#1'} {'#2'} {'#3'}];
%����������ѹ������ѡȡ������ѹ������ֵ֪
[p,t]=SteamWater_parameters;
d_pd=0.7614;pc=0.00539;h_p=zeros(p.length);for i=1:1:p.length
    h_p(i)=p(i);end
h_t=zeros(t.length);for i=1:1:t.length
    h_t(i)=t(i);end
d_order=4;h_cooler=[1  0 1 ];
dt_out=[10 0 0];dt_in=[5  0 5  ];fwp_outp=6.3;
cwp_outp=1.2;h_Dp=[0.08 0.4 0.08];fwp_ts=3.4;cwp_ts=1;
