function [h_num,h_name,t_fw,d_pd,pc,h_p,h_t,d_order,rh_order,h_style,hsg,asg,aother,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts,eff_h,afw]=Known_SteamWater_parameters
%******************************************************
%计算汽水参数所需参数(25MW)
%回热级数h_num;加热器名称h_name;给水温度(℃)t_fw;%除氧器工作压力(MPa)d_pd;
%凝汽器压力(MPa)pc;除氧器编号d_order;
%aother其它离开汽机（不加热给水）蒸汽份额(%)
%加热器疏水类型（0:表面逐级自流、1:表面疏水泵、
%2：混合）h_style;
%其它汽水流入焓值(kJ/kg):hsg;
%其它汽水流入份额(%)asg;有无疏水冷却器h_cooler;
%出口端差(℃)dt_out;入口端差(℃);dt_in;
%给水泵压头(MPa);fwp_outp;
%凝结水泵压头(MPa)cwp_outp;
%抽汽压损(%)h_Dp;给水泵温升(℃)fwp_ts;
%凝结水泵温升(℃)cwp_ts;
%加热器效率eff_h;%给水份额afw;
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
%回热级数由初压和初温查表确定
%给水温度
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
%此处如何计算
aother=0.0384;
h_cooler=[1 0 1];
dt_out=[10 0 0];
dt_in=[5 0 5];
fwp_outp=6.3;cwp_outp=1.2;
h_Dp=[0.08 0.4 0.08] ;
fwp_ts=3.4;cwp_ts=1;eff_h=0.98;afw=1;