function [m,DetD0,designPe,eff_m,eff_g,rh_order,h_h,h_a,h0,hc,ac,qrh,arh,hfw,alv,asg,hlv,hsg,hother,aother]=Known_Result_Check
%******************************************************
%流量功率校核及指标计算所需数据(50MW)
%m、DetD0估算流量用系数,designPe设计功率(kW),h0新汽焓(kJ/kg),eff_m机械效率,eff_g发电机效率rh_order再热对应抽汽口h_h抽汽焓(kJ/kg)，
% h_a抽汽份额,hc排汽焓(kJ/kg),ac排汽份额，qrh再热量(kJ/kg),arh再热份额hfw给水焓(kJ/kg),Dlv门杆漏汽量(t/h),Dsg轴封漏汽量(t/h)，hlv门杆漏汽焓(kJ/kg),hsg轴封漏汽焓(kJ/kg)
%******************************************************
% m=1.15;DetD0=0.03;designPe=47500;eff_m=0.98;eff_g=0.98;rh_order=0;
% h_h=[3208.68 3080.53 2992.15 2849.22 2695.04 2564.19 2473.34];
% h_a=[0.053711061 0.036801743 0.018086611 0.053091652 0.032811201 0.02254213	0.039844683];
% h0=3476.75;hc=2267.55;ac=0.71161092;qrh=0;arh=0;hfw=933.55;hlv=[3476.75];alv=[0.00738];
% hsg=[3404.43];asg=[0.02382];hother=[0];aother=[0];
%******************************************************
%流量功率校核及指标计算所需数据(300MW)
%m、DetD0估算流量用系数,designPe设计功率(kW),h0新汽焓(kJ/kg),
%eff_m机械效率,eff_g发电机效率,h_order再热对应抽汽口
%r h_h抽汽焓(kJ/kg)，h_a抽汽份额,hc排汽焓(kJ/kg),ac排汽份额，
%qrh再热量(kJ/kg),arh再热份额
%hfw给水焓(kJ/kg),alv门杆漏汽量(t/h),asg轴封漏汽量(t/h),
%hlv门杆漏汽焓(kJ/kg),hsg轴封漏汽焓(kJ/kg),hother,aother其它未做功汽水(小汽轮机等)
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
%2015-12-3改为25WM参数
%
m=1.2;DetD0=0.04;designPe=20000;eff_m=0.99;eff_g=0.975;rh_order=2;
%抽气焓值可以通过调用其他的函数求得
h_h=[3137.645952 3020.504122 3325.727704 3130.704871 2929.687815 2753.454181 2635.555009 2508.217641];
h_a=[0.073537464 0.081825202 0.036058215 0.034400456 0.038633046 0.025527442 0.02846112 0.031816979];
h0=3396.13;hc=2386.8;ac=0.595009375;qrh=517.79;arh=0.844637334;hfw=1193.7;
hlv=[3396.13 3537.74];alv=[0.00281 0.001128];hsg=[3019.95 3129.18];asg=[0.00365 0.00271];
hother=[3129.18];aother=[0.0384];
