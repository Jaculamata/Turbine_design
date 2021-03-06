function Thermal_graph
%******************************************************
%热力过程线初步拟定
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
[p0,t0,pc,Eff_TriH,Dp0,Dpc,C1,C2,C3,Eff_TriM,Eff_TriL,Dprh,Dprhout,ps,Dps]=Known_graph_parameters;
if (Dprh ==0 )%单缸
    fprintf( '计算热力过程线各点参数\n')
    %调节级级前压力 减去主气阀和调节气阀节流压力损失
    p01=(1-Dp0)*p0;
    %排汽压力  凝汽器压力加上排汽阻力损失
    pc1=(1+Dpc)*pc;   
    %查询进气状态点参数
    [v0,h0,s0] = PTG(p0,t0);
    %查询调节级级前参数
    [x01,t01,v01,s01] = PH(p01,h0);
    %查询汽缸理想出口状态点参数
    [xct,tct,vct,hct] = PS(pc,s0);
    %汽轮机理想比焓降
    DHt=h0-hct;
    %汽轮机实际比焓降
    DHi=DHt*Eff_TriH;
    %汽缸实际出口焓
    hc2=h0-DHi;
    %反向查询汽缸实际出口状态
    [xc2,tc2,vc2,sc2] = PH(pc1,hc2);
    %考虑末级余速损失
    Dhc2=C1*DHt;
    %将实际排汽压力线下移
    hc3=hc2-Dhc2;
    [xc3,tc3,vc3,sc3] = PH(pc1,hc3);
    h41=(h0+hc3)/2;
    s41=(s01+sc3)/2;
    [x41,p41,t41,v41] = HS(h41, s41);    
    h4=h41-C2;
    [x4,t4,v4,s4] = PH(p41,h4);
    %由0,1,4,3,2连接的线即为该机组在设计工况下的近似热力过程线
    fprintf('绘制H-S图\n')
    Thermalgraph=figure(1);
    axis([5.5 8.5 1800 3800])
    grid on 
    hold on
    %0点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(p0,h0-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(p0,h0+100);
    plot([Temps1 s0 Temps2],[h0-50 h0 h0+100],'-');%等压线
    plot([s0-0.1 s0+1],[h0 h0],'-');%等焓线
    text(s0-0.4,h0,strcat('h0=',num2str(h0),'kJ/kg'));%标数据
    plot(s0,h0,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    text(s0-0.1,h0+70,strcat('p0=',num2str(p0),'MPa'));%标数据
    %1点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(p01,h0-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(p01,h0+100);
    plot([Temps1 s01 Temps2],[h0-50 h0 h0+100],'-');%等压线
    plot(s01,h0,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    text(s01+0.1,h0+130,strcat('p01=',num2str(p01),'MPa'));%标数据
    plot([s0 s01],[h0 h0],'-','LineWidth',2.5);%连线   
    
    %2t点与2点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(pc,hct-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(pc,hct+50);
    plot([Temps1 s0 Temps2],[hct-50 hct hct+50],'-');%背压线
    text(s0,hct-50,strcat('pc=',num2str(pc),'MPa'));%标数据
    plot([s0-0.1 s0+0.1],[hct hct],'-');%辅助等焓线
    plot([s0 s0],[h0 hct],'-');%等熵焓降线
    text(s0-0.05,(h0+hct)/2,strcat('DHt=',num2str(DHt),'kJ/kg'));%标数据
    plot(s0,hct,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(pc1,hc2-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(pc1,hc2+50);
    plot([Temps1 sc2 Temps2],[hc2-50 hc2 hc2+50],'-');%
    text(sc2+0.1,hc2+80,strcat('pc1=',num2str(pc1),'MPa'));%标数据
    plot([sc2-0.1 sc2+0.1],[hc2 hc2],'-');%辅助等焓线
    plot([sc2 sc2],[h0 hc2],'-');%实际焓降线
    text(sc2-0.05,(h0+hc2)/2,strcat('DHi=',num2str(DHi),'kJ/kg'));%标数据
    plot(sc2,hc2,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点    
    text(sc2+0.1,hc2-15,strcat('Dhc2=',num2str(Dhc2),'kJ/kg')); %标余速
    %3点
    plot(sc3,hc3,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    plot([sc2 sc3],[hc2 hc3],'-','LineWidth',2.5);%连线
    plot([sc3-0.1 sc3+0.1],[hc3 hc3],'-');%辅助等焓线
    text(sc3-0.1,hc3-50,strcat('hc=',num2str(hc3),'kJ/kg'));%标数据
    %41点
    plot([s01 sc3],[h0 hc3],'-');%连线
    plot(s41,h41,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(p41,h41-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(p41,h41+50);
    plot([Temps1 s41 Temps2],[h41-50 h41 h41+50],'-');%等压线
    %4点
    plot(s4,h4,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    plot([s01 s4 sc3],[h0 h4 hc3],'-','LineWidth',2.5);%连线

    xlabel('s[kJ/(kg.K)]')
    ylabel('h[kJ/kg]')
    hold on 
    saveas(Thermalgraph,'Thermalgraph1.fig');
    fprintf('绘制结果已经保存到当前目录\n')
   
else
%     [p0,t0,pc,Eff_TriH,Dp0,Dpc,C1,C2,C3,Eff_TriM,Eff_TriL,Dprh,Dprhout,ps,Dps]=Known_graph_parameters;
    fprintf( '计算热力过程线各点参数\n')
    p01=(1-Dp0)*p0;
    pc1=(1+Dpc)*pc;
    prhin=C3*p0;
    prhout=(1-Dprh)*prhin;    
    prhout1=(1-Dprh-Dprhout)*prhin; 
    ps1=(1-Dps)*ps; 
    %高压缸
    [v0,h0,s0] = PTG(p0,t0);    
    [x01,t01,v01,s01] = PH(p01,h0);
    [xprhint,tprhint,vprhint,hprhint] = PS(prhin,s0);
    DHtH=h0-hprhint;
    DHiH=DHtH*Eff_TriH;
    hrhin=h0-DHiH;
    [xprhin,tprhin,vprhin,sprhin] = PH(prhin,hrhin);
    fprintf('绘制H-S图\n')
    Thermalgraph=figure(1);
    axis([5.5 8.5 1800 3800])
    grid on 
    hold on
    %0点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(p0,h0-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(p0,h0+100);
    plot([Temps1 s0 Temps2],[h0-50 h0 h0+100],'-');%等压线
    plot([s0-0.1 s0+0.1],[h0 h0],'-');%等焓线
    text(s0-0.45,h0,strcat('h0=',num2str(h0),'kJ/kg'));%标数据
    plot(s0,h0,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    text(s0-0.15,h0+70,strcat('p0=',num2str(p0),'MPa'));%标数据
    %1点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(p01,h0-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(p01,h0+100);
    plot([Temps1 s01 Temps2],[h0-50 h0 h0+100],'-');%等压线
    plot(s01,h0,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    text(s01+0.1,h0+70,strcat('p01=',num2str(p01),'MPa'));%标数据
    plot([s0 s01],[h0 h0],'-','LineWidth',2.5);%连线   
    %2t点与2点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(prhin,hprhint-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(prhin,hprhint+200);
    plot([Temps1 s0 Temps2],[hprhint-50 hprhint hprhint+200],'-');%高排压力线
    text(s0-0.05,hprhint-50,strcat('prhin=',num2str(prhin),'MPa'));%标数据
    plot([s0-0.1 s0+0.1],[hprhint hprhint],'-');%辅助等焓线
    plot([s0 s0],[h0 hprhint],'-');%等熵焓降线
    text(s0-0.4,(h0+hprhint)/2,strcat('DHtH=',num2str(DHtH),'kJ/kg'));%标数据
    plot(s0,hprhint,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
%     [Tempx1,Tempt1,Tempv1,Temps1] = PH(pc1,hrhin-50);
%     [Tempx2,Tempt2,Tempv2,Temps2] = PH(pc1,hrhin+50);
%     plot([Temps1 sprhin Temps2],[hrhin-50 hrhin hrhin+50],'-');%
%     text(sprhin+0.1,hrhin+80,strcat('prhin=',num2str(prhin),'MPa'));%标数据
    plot([sprhin-0.05 sprhin+0.1],[hrhin hrhin],'-');%辅助等焓线
    plot([sprhin sprhin],[h0 hrhin],'-');%实际焓降线
    text(sprhin,(h0+hrhin)/2,strcat('DHiH=',num2str(DHiH),'kJ/kg'));%标数据
    plot(sprhin,hrhin,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点    
    plot([s01 sprhin],[h0 hrhin],'-','LineWidth',2.5);%连线   
     %中低压缸
    [vprhout,hprhout,sprhout] = PTG(prhout,t0);    
    [xprhout1,tprhout1,vprhout1,sprhout1] = PH(prhout1,hprhout);
    [xct,tct,vct,hct] = PS(pc,sprhout);
    DHtML=hprhout-hct;
    DHiML=DHtML*(Eff_TriM+Eff_TriL)/2;
    hc5=hprhout-DHiML;
    [xc5,tc5,vc5,sc5] = PH(pc1,hc5);
    Dhc2=C1*DHtML;
    hc6=hc5-Dhc2;
    [xc6,tc6,vc6,sc6] = PH(pc1,hc6);
    h71=(hprhout+hc6)/2;
    s71=(sprhout1+sc6)/2;
    [x71,p71,t71,v71] = HS(h71, s71);    
    h7=h71-C2;
    [x7,t7,v7,s7] = PH(p71,h7);

    %3点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(prhout,hprhout-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(prhout,hprhout+100);
    plot([Temps1 sprhout Temps2],[hprhout-50 hprhout hprhout+100],'-');%等压线
    plot([sprhout-0.1 sprhout+0.5],[hprhout hprhout],'-');%等焓线
    text(sprhout-0.4,hprhout+50,strcat('hprhout=',num2str(hprhout),'kJ/kg'));%标数据
    plot(sprhout,hprhout,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    text(sprhout-0.25,hprhout+100,strcat('prhout=',num2str(prhout),'MPa'));%标数据
    plot([sprhin sprhout],[hrhin hprhout],'-','LineWidth',2.5);%连线  
    %4点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(prhout1,hprhout-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(prhout1,hprhout+100);
    plot([Temps1 sprhout1 Temps2],[hprhout-50 hprhout hprhout+100],'-');%等压线
    plot(sprhout1,hprhout,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    text(sprhout1+0.15,hprhout+100,strcat('prhout1=',num2str(prhout1),'MPa'));%标数据
    plot([sprhout sprhout1],[hprhout hprhout],'-','LineWidth',2.5);%连线   
   
    %5t点与5点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(pc,hct-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(pc,hct+200);
    plot([Temps1 sprhout Temps2],[hct-50 hct hct+200],'-');%
    text(sprhout-0.1,hct-50,strcat('pc=',num2str(pc),'MPa'));%标数据
    plot([sprhout-0.1 sprhout+0.1],[hct hct],'-');%辅助等焓线
    plot([sprhout sprhout],[hprhout hct],'-');%等熵焓降线
    text(sprhout-0.4,(hprhout+hct)/2,strcat('DHtML=',num2str(DHtML),'kJ/kg'));%标数据
    plot(sprhout,hct,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(pc1,hc5-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(pc1,hc5+50);
    plot([Temps1 sc5 Temps2],[hc5-50 hc5 hc5+50],'-');%
    text(sc5+0.1,hc5+80,strcat('pc1=',num2str(pc1),'MPa'));%标数据
    plot([sc5-0.1 sc5+0.1],[hc5 hc5],'-');%辅助等焓线
    plot([sc5 sc5],[hprhout hc5],'-');%实际焓降线
    text(sc5-0.05,(hprhout+hc5)/2,strcat('DHiML=',num2str(DHiML),'kJ/kg'));%标数据
    plot(sc5,hc5,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点     
    text(sc5+0.1,hc5-15,strcat('Dhc2=',num2str(Dhc2),'kJ/kg')); %标余速
    %6点
    plot(sc6,hc6,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    plot([sc6-0.1 sc6+0.1],[hc6 hc6],'-');%辅助等焓线
    text(sc6-0.1,hc6-50,strcat('hc=',num2str(hc6),'kJ/kg'));%标数据
    plot([sc5 sc6],[hc5 hc6],'-','LineWidth',2.5);%连线

    %71点
    plot([sprhout1 sc6],[hprhout hc6],'-');%连线
    plot(s71,h71,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    [Tempx1,Tempt1,Tempv1,Temps1] = PH(p71,h71-50);
    [Tempx2,Tempt2,Tempv2,Temps2] = PH(p71,h71+50);
    plot([Temps1 s71 Temps2],[h71-50 h71 h71+50],'-');%等压线
    %7点
    plot(s7,h7,'ro','MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',5);%画点
    plot([sprhout1 s7 sc6],[hprhout h7 hc6],'-','LineWidth',2.5);%连线
    xlabel('s[kJ/(kg.K)]')
    ylabel('h[kJ/kg]')
    hold on 
    saveas(Thermalgraph,'Thermalgraph2.fig');
    fprintf('绘制结果已经保存到当前目录\n');    
end