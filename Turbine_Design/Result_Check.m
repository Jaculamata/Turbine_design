function Result_Check
%******************************************************
%流量功率校核及指标计算
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
[m,DetD0,designPe,eff_m,eff_g,rh_order,h_h,h_a,h0,hc,ac,qrh,arh,hfw,alv,asg,hlv,hsg,hother,aother]=Known_Result_Check;
if rh_order==0
    Dhimac=h0-hc;
    D0=3.6*designPe*m/(Dhimac*eff_m*eff_g)/(1-DetD0);
    for j=1:1:size(h_h,2)
        y(j)=(h_h(j)-hc)/Dhimac; 
    end 
else
    Dhimac=h0-hc+qrh; 
    D0=3.6*designPe*m/(Dhimac*eff_m*eff_g)/(1-DetD0);
    for j=1:1:rh_order
        y(j)=(h_h(j)-hc+qrh)/Dhimac;
    end    
    for j=rh_order+1:1:size(h_h,2)
        y(j)=(h_h(j)-hc)/Dhimac;
    end 
end
ysg=(hsg-hc)/Dhimac;
ylv=(hlv-hc)/Dhimac; 
yother=(hother-hc)/Dhimac; 
beta0=1/(1-sum(h_a.*y)-sum(aother.*yother)-sum(asg.*ysg)-sum(alv.*ylv)); 
D01=3.6*designPe*beta0/(Dhimac*eff_m*eff_g);
Derr=abs(D01-D0)/D01;
if Derr<0.01 
    wangl = msgbox(strcat('设计结果合理(误差为：',num2str(Derr),')'), '流量校核');
elseif Derr<0.03 
    wangl = msgbox(strcat('设计误差较大但在合理范围内，调整相关数据(误差为：',num2str(Derr),')'), '流量校核');
else
    wangl = msgbox(strcat('设计误差很大，请重新设计(误差为：',num2str(Derr),')'), '流量校核');
end
Pe1=(D01*(h0+arh*qrh-sum(h_a.*h_h)-hc*ac-sum(aother.*hother)-sum(alv.*hlv)-sum(asg.*hsg)))*eff_m*eff_g/3.6;
Perr=abs(Pe1-designPe)/Pe1;
if Perr<0.01 
    wangl = msgbox(strcat('设计结果合理(误差为：',num2str(Perr),')'), '功率校核');
elseif Perr<0.03 
    wangl = msgbox(strcat('设计误差较大但在合理范围内，调整相关数据(误差为：',num2str(Perr),')'), '功率校核');
else
    wangl = msgbox(strcat('设计误差很大，请重新设计(误差为：',num2str(Perr),')'), '功率校核');
end
Q0=(D01*(h0-hfw)+D01*arh*qrh)*1000; 
q0=Q0/Pe1;
eff_ael=3600/q0*100;
%保存数据
hname=[{'估计流量'} {'计算流量'} {'设计功率'} {'计算功率'} {'热耗'} {'热耗率'} {'电效率'}];
hunit=[{'t/h'} {'t/h'} {'kW'} {'kW'} {'kJ/h'} {'kJ/(kW.h)'} {'%'}];
tname=[{'项目'} {'单位'} {'结果'}];
tdata=[D0,D01,designPe,Pe1,Q0,q0,eff_ael];
xlswrite('Design_results.xls',hname,'results','B1:H1');        
xlswrite('Design_results.xls',hunit,'results','B2:H2');        
xlswrite('Design_results.xls',tname','results','A1:A3');
xlswrite('Design_results.xls',num2cell(tdata),'results','B3:H3');
xlswrite('Design_results.xls',{'抽汽做功不足系数'},'results','A4');        
xlswrite('Design_results.xls',num2cell(y),'results',strcat('B4:',char(65+size(h_h,2)),'4'));
xlswrite('Design_results.xls',{'汽耗系数beta0'},'results','A5');        
xlswrite('Design_results.xls',num2cell(beta0),'results','B5');
fprintf('计算结果已经保存到当前目录\n');  
