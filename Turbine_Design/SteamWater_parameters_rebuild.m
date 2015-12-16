function SteamWater_parameters_rebuild
%******************************************************
%重新计算汽水参数[p,t,h,p1,hs,ts,hwd,twd,hw,tw]
% 已知抽汽压力pj、温度tj求取加热器汽侧工作压力p1j,各段抽汽比焓值hj，各级加热器凝结段的饱和水温度tsj，饱和水比焓hsj
% 通过上端差求取各级加热器进出口水温twj、水比焓hwj，
% 通过下端差计算各级加热器的疏水温度twdj、疏水比焓（过冷水）hwdj，
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
[h_num,h_name,d_pd,pc,h_p,h_t,d_order,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts]=Known_SteamWater_parameters_re;
tc=TSK(pc);
tcp=tc+cwp_ts;
h_tw(h_num+1)=tcp;
% p(h_num+1)=0;t(h_num+1)=0;h(h_num+1)=0;p1(h_num+1)=0;hs(h_num+1)=0;ts(h_num+1)=0;hwd(h_num+1)=0;twd(h_num+1)=0;
for j=1:1:h_num
    if h_t(j)<1
        h_x(j)=h_t(j);
        [h_t(j),h_v(j),h_h(j),h_s(j)] = PX(h_p(j),h_x(j));  
    else
        [h_s(j),h_h(j),h_s(j)] = PTG(h_p(j),h_t(j));
    end
    h_p1(j)=(1-h_Dp(j))*h_p(j);
    h_ts(j)=TSK(h_p1(j));
    [xs,vs,h_hs(j),ss] = PT(h_p1(j),h_ts(j));
    h_tw(j)=h_ts(j)-dt_out(j);
    if j==d_order
        h_p1(d_order)=d_pd;
        h_ts(d_order)=TSK(h_p1(d_order));
        [xs,vs,h_hs(d_order),ss] = PT(h_p1(d_order),h_ts(d_order));
        h_tw(d_order)=h_ts(d_order)+fwp_ts;
    end
    if j>d_order
        [vw,h_hw(j),sw] = PTF(cwp_outp,h_tw(j)); 
    else
        [vw,h_hw(j),sw] = PTF(fwp_outp,h_tw(j)); 
    end    
    [vw,h_hw(h_num+1),sw] = PTF(cwp_outp,tcp); 
end 
for j=1:1:h_num
    if(h_cooler(j)==1)
        h_twd(j)=h_tw(j+1)+dt_in(j); 
        [vw,h_hwd(j),sw] = PTF(h_p1(j),h_twd(j));
    else
        h_twd(j)=h_ts(j);
        h_hwd(j)=h_hs(j);
    end
end
h_p(h_num+1)=0;h_t(h_num+1)=0;h_h(h_num+1)=0;h_p1(h_num+1)=0;h_hs(h_num+1)=0;h_ts(h_num+1)=0;h_hwd(h_num+1)=0;h_twd(h_num+1)=0;
%保存数据
horder=[h_name {'SG'}];
tname=[{'加热器编号'} {'抽汽压力'} {'抽汽温度'} {'抽汽比焓'} {'加热器工作压力'} {'工作压力下饱和水比焓'} {'工作压力下饱和水温度'} {'疏水比焓'} {'疏水温度'} {'加热器出口水比焓'} {'加热器出口水温'}];
tdata=[h_p',h_t',h_h',h_p1',h_hs',h_ts',h_hwd',h_twd',h_hw',h_tw'];
xlswrite('Design_results.xls',tname,'SteamWater_parameters_rebuild','A1:K1');
xlswrite('Design_results.xls',horder','SteamWater_parameters_rebuild',strcat('A2:A',num2str(h_num+2)));        
xlswrite('Design_results.xls',num2cell(tdata),'SteamWater_parameters_rebuild',strcat('B2:K',num2str(h_num+2)));
fprintf('计算结果已经保存到当前目录\n');  

