function Heater_extractionflow(He_order)
%******************************************************
%计算回热抽汽量，其中He_order=1，初算；其中He_order=2，重算
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
if nargin < 1
%判断变量个数的函数nargin
    He_order=1;
end
%获得已知参数
[h_num,h_name,t_fw,d_pd,pc,d_order,rh_order,prh,h_style,hsg,asg,aother,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts,eff_h,afw]=Known_SteamWater_parameters;
%判断是否是初算
%是，则读取数据后将相关数据初始化为0
if He_order==1
%读取数据 B2到K10之间的矩阵
    tdata=xlsread('Design_results.xls','SteamWater_parameters',strcat('B2:K', num2str(h_num+2)));
 %把第一行的相关数据置0
    hsg(1,:)=0;asg(1,:)=0;aother(1,:)=0;
%否则直接读取数据
else
    tdata=xlsread('Design_results.xls','SteamWater_parameters_rebuild',strcat('B2:K', num2str(h_num+2)));
end
%vpa精度控制 第3,9,7,5列数据都控制在6位
%double数据类型转换
h=double(vpa(tdata(:,3),6));hw=double(vpa(tdata(:,9),6));hwd=double(vpa(tdata(:,7),6));hs=double(vpa(tdata(:,5),6));
%1号到除氧器之前的换热器 高压级
%能量守恒计算抽气份额a
%as代表疏水
for j=1:1:d_order-1
    if j==1
        a(j)=(afw*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j)))/(h(j)-hwd(j));
        as(j)=a(j)+asg(j);
    else
        a(j)=(afw*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j))-as(j-1)*(hwd(j-1)-hwd(j)))/(h(j)-hwd(j));
        as(j)=as(j-1)+a(j)+asg(j);
    end
end
%单独计算除氧器的抽汽份额
%ac4低压级过来的水 物质守恒
a(d_order)=(afw*(hs(d_order)-hw(d_order+1))/eff_h-asg(d_order)*(hsg(d_order)-hw(d_order+1))-as(d_order-1)*(hwd(d_order-1)-hw(d_order+1)))/(h(d_order)-hw(d_order+1));
ac4=afw-a(d_order)-as(d_order-1)-asg(d_order);
ac4temp=ac4;
%计算低压级抽汽份额
for j=d_order+1:1:h_num
%判断是否是第一个低压级
%是
    if j==d_order+1
%判断疏水类型   0代表逐级自流，1代表疏水泵，2代表混合
%对于逐级自流
        if h_style(j)==0
            a(j)=(ac4temp*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j)))/(h(j)-hwd(j));
            as(j)=a(j)+asg(j);

%  1对于含有疏水泵的
        elseif  h_style(j)==1
%定义符号运算，列写三个方程式
            syms ac42 a5 hw51 ac41 hwd5 hw5 h5 hw6 hsg5 asg5 effh
            f1=sym('ac42+a5+asg5=ac41');
            f2=sym('hwd5*a5*effh+hwd5*asg5*effh+ac42*hw51=ac41*hw5');
            f3=sym('((h5-hwd5)*a5+(hsg5-hwd5)*asg5)*effh=(hw51-hw6)*ac42');
%多了一对括号
            [a5,ac42,hw51]=solve(f1,f2,f3,'a5','ac42','hw51');
%带入数值进行计算 subs数值替换函数
            Tempac4=subs(ac42,{'ac41','hwd5','hw5','h5','hw6','hsg5','asg5','effh'},{ac4temp,hwd(j),hw(j),h(j),hw(j+1),hsg(j),asg(j),eff_h});
            a(j)=subs(a5,{'ac41','hwd5','hw5','h5','hw6','hsg5','asg5','effh'},{ac4temp,hwd(j),hw(j),h(j),hw(j+1),hsg(j),asg(j),eff_h});
            ac4temp=double(Tempac4);
%为什么要将疏水份额重置为0  ？？？  ！！！因为又疏水泵所以疏水不会进入下一级，对于下一级来说疏水为0！！！！
            as(j)=0;
	   %对于混合式
        else
            a(j)=(ac4temp*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hw(j+1)))/(h(j)-hw(j+1));
            ac4temp=ac4temp-a(j);
            as(j)=0;
        end
%如果不是第一根低压级
    else
%再判断疏水的方式 处理过程相似
        if h_style(j)==0
            a(j)=(ac4temp*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j))-as(j-1)*(hwd(j-1)-hwd(j)))/(h(j)-hwd(j));
            as(j)=as(j-1)+a(j)+asg(j);
        elseif  h_style(j)==1
            syms a6 h6 a7 h7 hwd5 hwd6 hwd7 hw6 hw7 hw8 asg6 hsg6 asg7 hsg7 asj ac3 effh
            f1=sym('a6*(h6-hwd6+hwd7-hw7)+asg6*(hsg6-hwd6+hwd7-hw7)+asj*(hwd5-hwd6+hwd7-hw7)+asg7*(hwd7-hw7)+a7*(hwd7-hw7)=ac3*(hw6-hw7)/effh');
            f2=sym('a7*(h7-hwd7+hw7-hw8)+(asj+asg6)*(hwd6-hwd7+hw7-hw8)+a6*(hwd6-hwd7+hw7-hw8)+asg7*(hsg7-hwd7+hw7-hw8)=ac3*(hw7-hw8)/effh');
            [a6,a7]=solve(f1,f2,'a6','a7');
            a(j-1)=subs(a6,{'h6','h7','hwd5','hwd6','hwd7','hw6','hw7','hw8','asg6','hsg6','asg7','hsg7','ac3','asj','effh'},{h(j-1),h(j),hwd(j-2),hwd(j-1),hwd(j),hw(j-1),hw(j),hw(j+1),asg(j-1),hsg(j-1),asg(j),hsg(j),ac4temp,as(j-2),eff_h});
            a(j)=subs(a7,{'h6','h7','hwd5','hwd6','hwd7','hw6','hw7','hw8','asg6','hsg6','asg7','hsg7','ac3','asj','effh'},{h(j-1),h(j),hwd(j-2),hwd(j-1),hwd(j),hw(j-1),hw(j),hw(j+1),asg(j-1),hsg(j-1),asg(j),hsg(j),ac4temp,as(j-2),eff_h});
            as(j)=as(j-2)+a(j-1)+asg(j-1)+a(j)+asg(j);
            ac4temp=ac4temp-as(j);
            as(j)=0;
        elseif  h_style(j)==2
            a(j)=(ac4temp*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hw(j+1)))/(h(j)-hw(j+1));
            ac4temp=ac4temp-a(j);
            as(j)=0;
        end
    end
end
%通过低压级热井物质的平衡计算的排气量
sumla=0;
for j=d_order+1:1:h_num
   sumla=sumla +a(j)+asg(j);
end
%计算排气流量
ac=ac4-sumla-aother;
%通过汽轮机物质守恒计算的排气量
suma=0;
for j=1:1:h_num
    suma=suma+a(j)+asg(j);
end
ac1=1-suma-aother;
if (ac-ac1)<0.0000001
    wangl1 = msgbox('计算完毕', '计算完毕');
else
    wangl1 = msgbox('计算有错误，请检查！', '计算完毕');
end
% 保存数据
horder=[{'ac4'} {'ac'} h_name];
tname=[{'编号'} {'抽汽份额'} ];
tdata=[ac4,ac,a];
xlswrite('Design_results.xls',horder,'extractionflow',strcat('B1:',char(65+2+h_num),'1'));
xlswrite('Design_results.xls',tname','extractionflow','A1:A2');
xlswrite('Design_results.xls',num2cell(tdata),'extractionflow',strcat('B2:',char(65+2+h_num),'2'));
fprintf('计算结果已经保存到当前目录\n');

