function Result_Check
%******************************************************
%��������У�˼�ָ�����
% ****���ߣ����� zrqwl2003@126.com***
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
    wangl = msgbox(strcat('��ƽ������(���Ϊ��',num2str(Derr),')'), '����У��');
elseif Derr<0.03 
    wangl = msgbox(strcat('������ϴ��ں���Χ�ڣ������������(���Ϊ��',num2str(Derr),')'), '����У��');
else
    wangl = msgbox(strcat('������ܴ����������(���Ϊ��',num2str(Derr),')'), '����У��');
end
Pe1=(D01*(h0+arh*qrh-sum(h_a.*h_h)-hc*ac-sum(aother.*hother)-sum(alv.*hlv)-sum(asg.*hsg)))*eff_m*eff_g/3.6;
Perr=abs(Pe1-designPe)/Pe1;
if Perr<0.01 
    wangl = msgbox(strcat('��ƽ������(���Ϊ��',num2str(Perr),')'), '����У��');
elseif Perr<0.03 
    wangl = msgbox(strcat('������ϴ��ں���Χ�ڣ������������(���Ϊ��',num2str(Perr),')'), '����У��');
else
    wangl = msgbox(strcat('������ܴ����������(���Ϊ��',num2str(Perr),')'), '����У��');
end
Q0=(D01*(h0-hfw)+D01*arh*qrh)*1000; 
q0=Q0/Pe1;
eff_ael=3600/q0*100;
%��������
hname=[{'��������'} {'��������'} {'��ƹ���'} {'���㹦��'} {'�Ⱥ�'} {'�Ⱥ���'} {'��Ч��'}];
hunit=[{'t/h'} {'t/h'} {'kW'} {'kW'} {'kJ/h'} {'kJ/(kW.h)'} {'%'}];
tname=[{'��Ŀ'} {'��λ'} {'���'}];
tdata=[D0,D01,designPe,Pe1,Q0,q0,eff_ael];
xlswrite('Design_results.xls',hname,'results','B1:H1');        
xlswrite('Design_results.xls',hunit,'results','B2:H2');        
xlswrite('Design_results.xls',tname','results','A1:A3');
xlswrite('Design_results.xls',num2cell(tdata),'results','B3:H3');
xlswrite('Design_results.xls',{'������������ϵ��'},'results','A4');        
xlswrite('Design_results.xls',num2cell(y),'results',strcat('B4:',char(65+size(h_h,2)),'4'));
xlswrite('Design_results.xls',{'����ϵ��beta0'},'results','A5');        
xlswrite('Design_results.xls',num2cell(beta0),'results','B5');
fprintf('�������Ѿ����浽��ǰĿ¼\n');  
