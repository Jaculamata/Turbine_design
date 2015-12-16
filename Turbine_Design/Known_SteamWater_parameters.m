function [h_num,h_name,t_fw,d_pd,pc,h_p,h_t,d_order,rh_order,h_style,hsg,asg,aother,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts,eff_h,afw]=Known_SteamWater_parameters
%******************************************************
%������ˮ�����������(25MW)
%���ȼ���h_num;����������h_name;��ˮ�¶�(��)t_fw;%����������ѹ��(MPa)d_pd;
%������ѹ��(MPa)pc;���������d_order;
%aother�����뿪�����������ȸ�ˮ�������ݶ�(%)
%��������ˮ���ͣ�0:������������1:������ˮ�á�
%2����ϣ�h_style;
%������ˮ������ֵ(kJ/kg):hsg;
%������ˮ����ݶ�(%)asg;������ˮ��ȴ��h_cooler;
%���ڶ˲�(��)dt_out;��ڶ˲�(��);dt_in;
%��ˮ��ѹͷ(MPa);fwp_outp;
%����ˮ��ѹͷ(MPa)cwp_outp;
%����ѹ��(%)h_Dp;��ˮ������(��)fwp_ts;
%����ˮ������(��)cwp_ts;
%������Ч��eff_h;%��ˮ�ݶ�afw;
% ****���ߣ����� zrqwl2003@126.com***
%******************************************************
%���ȼ����ɳ�ѹ�ͳ��²��ȷ��
%��ˮ�¶�
h_num=3;
rh_order=0;
h_name=[{'#1'} {'#2'} {'#3'}];
t_fw=165;d_pd=0.588;
pc=0.005;
h_p=[0.59 0.142 0.036];d_order=2;
h_t=[335 150 90];
h_style=[0 2 0];
hsg=[0 0 0];
asg=[0 0 0];    
%�˴���μ���
aother=0.0384;
h_cooler=[1 0 1];
dt_out=[10 0 0];
dt_in=[5 0 5];
fwp_outp=6.3;cwp_outp=1.2;
h_Dp=[0.08 0.4 0.08] ;
fwp_ts=3.4;cwp_ts=1;eff_h=0.98;afw=1;