function Heater_extractionflow(He_order)
%******************************************************
%������ȳ�����������He_order=1�����㣻����He_order=2������
% ****���ߣ����� zrqwl2003@126.com***
%******************************************************
if nargin < 1
%�жϱ��������ĺ���nargin
    He_order=1;
end
%�����֪����
[h_num,h_name,t_fw,d_pd,pc,d_order,rh_order,prh,h_style,hsg,asg,aother,h_cooler,dt_out,dt_in,fwp_outp,cwp_outp,h_Dp,fwp_ts,cwp_ts,eff_h,afw]=Known_SteamWater_parameters;
%�ж��Ƿ��ǳ���
%�ǣ����ȡ���ݺ�������ݳ�ʼ��Ϊ0
if He_order==1
%��ȡ���� B2��K10֮��ľ���
    tdata=xlsread('Design_results.xls','SteamWater_parameters',strcat('B2:K', num2str(h_num+2)));
 %�ѵ�һ�е����������0
    hsg(1,:)=0;asg(1,:)=0;aother(1,:)=0;
%����ֱ�Ӷ�ȡ����
else
    tdata=xlsread('Design_results.xls','SteamWater_parameters_rebuild',strcat('B2:K', num2str(h_num+2)));
end
%vpa���ȿ��� ��3,9,7,5�����ݶ�������6λ
%double��������ת��
h=double(vpa(tdata(:,3),6));hw=double(vpa(tdata(:,9),6));hwd=double(vpa(tdata(:,7),6));hs=double(vpa(tdata(:,5),6));
%1�ŵ�������֮ǰ�Ļ����� ��ѹ��
%�����غ��������ݶ�a
%as������ˮ
for j=1:1:d_order-1
    if j==1
        a(j)=(afw*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j)))/(h(j)-hwd(j));
        as(j)=a(j)+asg(j);
    else
        a(j)=(afw*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j))-as(j-1)*(hwd(j-1)-hwd(j)))/(h(j)-hwd(j));
        as(j)=as(j-1)+a(j)+asg(j);
    end
end
%��������������ĳ����ݶ�
%ac4��ѹ��������ˮ �����غ�
a(d_order)=(afw*(hs(d_order)-hw(d_order+1))/eff_h-asg(d_order)*(hsg(d_order)-hw(d_order+1))-as(d_order-1)*(hwd(d_order-1)-hw(d_order+1)))/(h(d_order)-hw(d_order+1));
ac4=afw-a(d_order)-as(d_order-1)-asg(d_order);
ac4temp=ac4;
%�����ѹ�������ݶ�
for j=d_order+1:1:h_num
%�ж��Ƿ��ǵ�һ����ѹ��
%��
    if j==d_order+1
%�ж���ˮ����   0������������1������ˮ�ã�2������
%����������
        if h_style(j)==0
            a(j)=(ac4temp*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hwd(j)))/(h(j)-hwd(j));
            as(j)=a(j)+asg(j);

%  1���ں�����ˮ�õ�
        elseif  h_style(j)==1
%����������㣬��д��������ʽ
            syms ac42 a5 hw51 ac41 hwd5 hw5 h5 hw6 hsg5 asg5 effh
            f1=sym('ac42+a5+asg5=ac41');
            f2=sym('hwd5*a5*effh+hwd5*asg5*effh+ac42*hw51=ac41*hw5');
            f3=sym('((h5-hwd5)*a5+(hsg5-hwd5)*asg5)*effh=(hw51-hw6)*ac42');
%����һ������
            [a5,ac42,hw51]=solve(f1,f2,f3,'a5','ac42','hw51');
%������ֵ���м��� subs��ֵ�滻����
            Tempac4=subs(ac42,{'ac41','hwd5','hw5','h5','hw6','hsg5','asg5','effh'},{ac4temp,hwd(j),hw(j),h(j),hw(j+1),hsg(j),asg(j),eff_h});
            a(j)=subs(a5,{'ac41','hwd5','hw5','h5','hw6','hsg5','asg5','effh'},{ac4temp,hwd(j),hw(j),h(j),hw(j+1),hsg(j),asg(j),eff_h});
            ac4temp=double(Tempac4);
%ΪʲôҪ����ˮ�ݶ�����Ϊ0  ������  ��������Ϊ����ˮ��������ˮ���������һ����������һ����˵��ˮΪ0��������
            as(j)=0;
	   %���ڻ��ʽ
        else
            a(j)=(ac4temp*(hw(j)-hw(j+1))/eff_h-asg(j)*(hsg(j)-hw(j+1)))/(h(j)-hw(j+1));
            ac4temp=ac4temp-a(j);
            as(j)=0;
        end
%������ǵ�һ����ѹ��
    else
%���ж���ˮ�ķ�ʽ �����������
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
%ͨ����ѹ���Ⱦ����ʵ�ƽ������������
sumla=0;
for j=d_order+1:1:h_num
   sumla=sumla +a(j)+asg(j);
end
%������������
ac=ac4-sumla-aother;
%ͨ�����ֻ������غ�����������
suma=0;
for j=1:1:h_num
    suma=suma+a(j)+asg(j);
end
ac1=1-suma-aother;
if (ac-ac1)<0.0000001
    wangl1 = msgbox('�������', '�������');
else
    wangl1 = msgbox('�����д������飡', '�������');
end
% ��������
horder=[{'ac4'} {'ac'} h_name];
tname=[{'���'} {'�����ݶ�'} ];
tdata=[ac4,ac,a];
xlswrite('Design_results.xls',horder,'extractionflow',strcat('B1:',char(65+2+h_num),'1'));
xlswrite('Design_results.xls',tname','extractionflow','A1:A2');
xlswrite('Design_results.xls',num2cell(tdata),'extractionflow',strcat('B2:',char(65+2+h_num),'2'));
fprintf('�������Ѿ����浽��ǰĿ¼\n');

