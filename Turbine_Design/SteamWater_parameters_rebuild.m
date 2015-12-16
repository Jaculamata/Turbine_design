function SteamWater_parameters_rebuild
%******************************************************
%���¼�����ˮ����[p,t,h,p1,hs,ts,hwd,twd,hw,tw]
% ��֪����ѹ��pj���¶�tj��ȡ���������๤��ѹ��p1j,���γ�������ֵhj����������������εı���ˮ�¶�tsj������ˮ����hsj
% ͨ���϶˲���ȡ����������������ˮ��twj��ˮ����hwj��
% ͨ���¶˲�����������������ˮ�¶�twdj����ˮ���ʣ�����ˮ��hwdj��
% ****���ߣ����� zrqwl2003@126.com***
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
%��������
horder=[h_name {'SG'}];
tname=[{'���������'} {'����ѹ��'} {'�����¶�'} {'��������'} {'����������ѹ��'} {'����ѹ���±���ˮ����'} {'����ѹ���±���ˮ�¶�'} {'��ˮ����'} {'��ˮ�¶�'} {'����������ˮ����'} {'����������ˮ��'}];
tdata=[h_p',h_t',h_h',h_p1',h_hs',h_ts',h_hwd',h_twd',h_hw',h_tw'];
xlswrite('Design_results.xls',tname,'SteamWater_parameters_rebuild','A1:K1');
xlswrite('Design_results.xls',horder','SteamWater_parameters_rebuild',strcat('A2:A',num2str(h_num+2)));        
xlswrite('Design_results.xls',num2cell(tdata),'SteamWater_parameters_rebuild',strcat('B2:K',num2str(h_num+2)));
fprintf('�������Ѿ����浽��ǰĿ¼\n');  

