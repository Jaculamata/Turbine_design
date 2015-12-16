function [p,t]=SteamWater_parameters
%.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
%������ˮ����[p,t,h,p1,hs,ts,hwd,twd,hw,tw]
% ���ݵ���������ȡ����������������ˮ��twj��ˮ����hwj��
% ͨ���϶˲���ȡ��������������εı���ˮ�¶�tsj������ˮ����hsj�����������๤��ѹ�� ������ѹ��pj��
% ͨ���¶˲�����������������ˮ�¶�twdj����ˮ���ʣ�����ˮ��hwdj��
% ����ٸ��ݳ���ѹ��������������ߵĽ�����h-sͼ�ϲ�ȡ���γ����¶�tj����������ֵhj��
% .*.*.*.*���ߣ����� zrqwl2003@126.com.*.*.*
%.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
%function [h_num,h_name,t_fw,d_pd,pc,d_order,rh_order,h_style,hsg,asg,aother,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts,eff_h,afw]=Known_SteamWater_parameters

[h_num,h_name,t_fw,d_pd,pc,h_p,h_t,d_order,rh_order,prh,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts]=Known_SteamWater_parameters;
if (rh_order ==0 )%������
%����ˮ�¶�
    tc=TSK(pc);
    %�����¶�
    tcp=tc+cwp_ts;
    %����������ˮ��
    td=TSK(d_pd);
    %��ѹ������ˮ������
    tfwrise1=(t_fw-td-fwp_ts)./(d_order-1);
    %��ѹ������ˮ������
    tfwrise2=(td-tc-cwp_ts)./(h_num-d_order+1);
    %���������������ˮ�£�ͨ���˲�������������
    %�ٲ���ɵ���Ӧ���ʣ����ݣ�����ֵ
    for j=1:1:d_order
        tw(j)=t_fw-tfwrise1.*(j-1);
        [vw,hw(j,:),sw] = PTF(fwp_outp,tw(j));       
    end
    for j=d_order+1:1:h_num
       tw(j)=tw(d_order)-tfwrise2.*(j-d_order);
        [vw,hw(j,:),sw] = PTF(cwp_outp,tw(j));    
    end
    %���������������ˮ�¶ȣ�ѹ������ֵ
    for j=1:1:h_num
        ts(j)=tw(j)+dt_out(j);
	%���¶ȶ�Ӧ����ˮ��ѹ��
        p1(j)=PSK(ts(j));       
        [vs,hs(j),ss] = PTF(p1(j),ts(j));
	%��Ӧ����ѹ������
        p(j)=p1(j)./(1-h_Dp(j)); 
    end
    %������������¶Ⱥ�ѹ��
    ts(d_order)=td;
    p1(d_order)=d_pd;
    [xs,vs,hs(d_order),ss] = PT(p1(d_order),ts(d_order));
    %�������ĳ���ѹ��
    p(d_order)=d_pd./(1-h_Dp(d_order)); 
%�����¶�
    tw(h_num+1)=tcp;
    [vw,hw(h_num+1,:),sw] = PTF(cwp_outp,tcp);
    %��������ˮ��ȴ�ļ�����ˮ�¶ȵ��ڱ���ˮ�¶�
    %��������ȴ���ģ�ͨ���¶˲�����ˮ�¶�
    for j=1:1:h_num
        if(h_cooler(j)==0)
            twd(j)=ts(j);
            hwd(j)=hs(j);
        else
            twd(j)=tw(j+1)+dt_in(j);
            [vw,hwd(j,:),sw] = PTF(p1(j),twd(j));
        end
    end
   % p(h_num+1)=0;t(h_num+1)=0;h(h_num+1)=0;p1(h_num+1)=0;hs(h_num+1)=0;ts(h_num+1)=0;hwd(h_num+1)=0;twd(h_num+1)=0;
    getP=open('Thermalgraph1.fig');%�½�����һ��ͼƬ�ļ�
    %��ָ����ʽ��ֵ���뵽��Ļ��ָ���ļ�
    fprintf('�밴˳����ͼ�е��ѹ���������������ߵĽ���\n')
    %gcf ���ص�ǰfigure����ľ��ֵ  figure������ʾͼ�κ��û�����Ĵ���
    %gca���ص�ǰaxes����ľ��ֵ axes�ڴ�������ʾ��ͼ�ε���
    %gco���ص�ǰ��굥���ľ��ֵ
    %ָ��figure�ĳߴ���Ե�λ
    set(gcf,'units','normalized','position',[0,0,1,0.9]);
    for j=1:1:h_num
        [Tempx1,Tempt1,Tempv1,Temph1] = PS(p(j),6.8+0.05.*j);
        [Tempx2,Tempt2,Tempv2,Temph2] = PS(p(j),6.9+0.07.*j);
        plot([6.8+0.05.*j 6.9+0.07.*j],[Temph1 Temph2],'-');%��ѹ��
    end   
    wangl1 = questdlg('�밴˳����ͼ�е��ѹ���������������ߵĽ����ȡ����ѹ��', '�����������߻�ȡ����ѹ��','��','��','��');
    if strcmp(wangl1,'��')
        while(1)
            for j=1:1:h_num
                [s(j,:),h(j,:)]=ginput(getP);
                ppoints(j,:)=plot(s(j),h(j),'ro','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',5);%����
            end
            wangl = questdlg('�Ƿ�����ѡȡ��','��ʾ��','��','��','��');
            if (strcmp(wangl,'��'))
                break;
            else
                for j=1:1:h_num
                    delete(ppoints(j));
                end
            end
        end
        for j=1:1:h_num
            [x(j,:),t(j,:),v(j,:),s(j,:)] = PH(p(j),h(j));
        end  
        %����ͼ��
        saveas(getP,'Thermalgraph11.fig');
        close(getP);
        %��������
        horder=h_name;
        tname=[{'���������'} {'����ѹ��'} {'�����¶�'} {'��������'} {'����������ѹ��'} {'����ѹ���±���ˮ����'} {'����ѹ���±���ˮ�¶�'} {'��ˮ����'} {'��ˮ�¶�'} {'����������ˮ����'} {'����������ˮ��'}];
        tdata=[num',p',t',h',p1',hs',ts',hwd',twd',hw',tw'];
        xlswrite('Design_results.xls',tname,'SteamWater_parameters','A1:K1');
        xlswrite('Design_results.xls',horder','SteamWater_parameters','A2:A8');        
        xlswrite('Design_results.xls',num2cell(tdata),'SteamWater_parameters','B2:K8');
        fprintf('�������Ѿ����浽��ǰĿ¼\n');  
    else
        close(getP);        
    end 
else
%     [h_num,t_fw,d_pd,pc,d_order,rh_order,prh,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts]=Known_SteamWater_parameters;
    tc=TSK(pc);
    tcp=tc+cwp_ts;
    td=TSK(d_pd);
    p(rh_order)=prh;
    p1(rh_order)=p(rh_order).*(1-h_Dp(rh_order));
    ts(rh_order)=TSK(p1(rh_order));
    [xs,vs,hs(rh_order),ss] = PT(p1(rh_order),ts(rh_order));
    tw(rh_order)=ts(rh_order)-dt_out(rh_order);
    tfwrise1=(t_fw- tw(rh_order))./(rh_order-1);
    for j=1:1:rh_order-1
        tw(j)=t_fw-tfwrise1.*(j-1);
    end
    tfwrise12=(tw(rh_order)-td-fwp_ts)./(d_order-rh_order+0.5);
    for j=rh_order+1:1:d_order-2
        tw(j)=tw(rh_order)-tfwrise12.*(j-rh_order); 
    end
    tw(d_order-1)=tw(d_order-2)-tfwrise12.*1.5;
    tw(d_order)=td+fwp_ts;
    for j=1:1:d_order
        [vw,hw(j),sw] = PTF(fwp_outp,tw(j));        
    end 
    tfwrise2=(td-tcp)./(h_num-d_order+1);
    for j=h_num:-1:d_order+1
        tw(j)=tcp+tfwrise2.*(h_num+1-j);
        [vw,hw(j),sw] = PTF(cwp_outp,tw(j));    
    end
  
    for j=1:1:h_num 
        ts(j)=tw(j)+dt_out(j);
        p1(j)=PSK(ts(j));       
        [vs,hs(j),ss] = PTF(p1(j),ts(j));
        p(j)=p1(j)./(1-h_Dp(j)); 
    end
    ts(d_order)=td;
    p1(d_order)=d_pd;
    [xs,vs,hs(d_order),ss] = PT(p1(d_order),ts(d_order));
    p(d_order)=d_pd./(1-h_Dp(d_order)); 
    tw(h_num+1)=tcp;
    [vw,hw(h_num+1),sw] = PTF(cwp_outp,tcp);      
    for j=1:1:h_num
        if(h_cooler(j)==0)
            twd(j)=ts(j);
            hwd(j)=hs(j);
        else
            twd(j)=tw(j+1)+dt_in(j);
            [vw,hwd(j),sw] = PTF(p1(j),twd(j));
        end
    end 
    p(h_num+1)=0;t(h_num+1)=0;h(h_num+1)=0;p1(h_num+1)=0;hs(h_num+1)=0;ts(h_num+1)=0;hwd(h_num+1)=0;twd(h_num+1)=0;
    getP=open('Thermalgraph2.fig');
    fprintf('�밴˳����ͼ�е��ѹ���������������ߵĽ���\n')
    set(gcf,'units','normalized','position',[0,0,1,0.9]);
    for j=1:1:rh_order-1
        [Tempx1,Tempt1,Tempv1,Temph1] = PS(p(j),6.45);
        [Tempx2,Tempt2,Tempv2,Temph2] = PS(p(j),6.52);
        plot([6.45 6.52],[Temph1 Temph2],'-m');%��ѹ��
    end   
    for j=rh_order+1:1:h_num
        [Tempx1,Tempt1,Tempv1,Temph1] = PS(p(j),7.3+0.03.*(j-rh_order));
        [Tempx2,Tempt2,Tempv2,Temph2] = PS(p(j),7.4+0.04.*(j-rh_order));
        plot([7.3+0.03.*(j-rh_order) 7.4+0.04.*(j-rh_order)],[Temph1 Temph2],'m-');%��ѹ��
    end 
    wangl1 = questdlg('�밴˳����ͼ�е��ѹ���������������ߵĽ����ȡ����ѹ��', '�����������߻�ȡ����ѹ��','��','��','��');
    if strcmp(wangl1,'��')
        while(1)
            for j=1:1:h_num
                [s(j),h(j)]=ginput(getP);
                ppoints(j)=plot(s(j),h(j),'ro','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',5);%����
            end
            wangl = questdlg('�Ƿ�����ѡȡ��','��ʾ��','��','��','��');
            if (strcmp(wangl,'��'))
                break;
            else
                for j=1:1:h_num
                    delete(ppoints(j));
                end
            end
        end
        for j=1:1:h_num
            [x(j),t(j),v(j),s(j)] = PH(p(j),h(j));
        end  
        %����ͼ��
        saveas(getP,'Thermalgraph21.fig');
        close(getP);
        %��������
        horder=[h_name {'SG'}];
        tname=[{'���������'} {'����ѹ��'} {'�����¶�'} {'��������'} {'����������ѹ��'} {'����ѹ���±���ˮ����'} {'����ѹ���±���ˮ�¶�'} {'��ˮ����'} {'��ˮ�¶�'} {'����������ˮ����'} {'����������ˮ��'}];
        tdata=[p',t',h',p1',hs',ts',hwd',twd',hw',tw'];
        xlswrite('Design_results.xls',tname,'SteamWater_parameters','A1:K1');
        xlswrite('Design_results.xls',horder','SteamWater_parameters',strcat('A2:A',num2str(h_num+2)));        
        xlswrite('Design_results.xls',num2cell(tdata),'SteamWater_parameters',strcat('B2:K',num2str(h_num+2)));
        fprintf('�������Ѿ����浽��ǰĿ¼\n');  
    else
        close(getP);        
    end 
end