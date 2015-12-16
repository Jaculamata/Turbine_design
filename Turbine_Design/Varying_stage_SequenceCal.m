function Varying_stage_SequenceCal
%**************************************************************************
%%%ѹ�����乤��˳������ӳ���%%
%%%%%%%%%%%%���㷽��ԭ��%%%%%%%%%%%%%%%
%%%��֪��ǰ�����������������Լ����ļ��γߴ硢�ṹ���Ե������£�
%%%�������Ͷ�Ҷ���ѹ��������������ʽ��������ȡ�
%%%���춯Ҷ���ڵ������ٶ��Լ����ĸ�����ʧ��Ч�ʡ����ʵ����ݡ�
% ****���ߣ����� zrqwl2003@126.com***
%**************************************************************************
% ������ƹ����¼��乤���²���
[sstyle,G1,p01,h01,dhtc01,An,miun,fai,alpha1,beta1,beta2,Ab,miub,psai,miu1,db,ln,n]=Known_stage_sequence;
[sl_num,sl_a,sl_K1,sl_ec,sl_Be,sl_sn,sl_Ce,sl_zp,sl_up,sl_dp,sl_detp,sl_ut,sl_ot,sl_detz,sl_detr,sl_zr]=Known_stageloss_parameters;
[x01,t01,v01,s01] = PH(p01,h01);
h001=h01+dhtc01;
[x001,p001,t001,v001] = HS(h001, s01);
dGp=0;
Gn1=G1+dGp;
fprintf('������...........................\n')
Gcn1=0.648*An*sqrt(p001*1000000/v001);
if Gcn1<Gn1
    wangl = msgbox('�ü�Ϊ�ٽ繤�����ó����ʺϣ�', '�����ж�');
    return;
end 
startp11=0.546*p001;
while(1) 
    %�ڲ�С���ٽ�ѹ���ķ�Χ�ڣ��������������ѹ��p11(MPa) 
    p11=startp11;
    [x1t1,t1t1,v1t1,h1t1] = PS(p11, s01);
    dhn01=h001-h1t1;
    if dhn01<0 
        wangl = msgbox('�޷�����,�����������ݣ�', '�����ж�');
        return;
    end
    dhn1=h01-h1t1;
    c11t=sqrt(2000*dhn01);
    c11=fai*c11t;
    dhtn1=(1/fai^2-1)*c11^2/2000;
    h11=h1t1+dhtn1;
    [x11,t11,v11,s11] = PH(p11, h11);
    Gn1_1=An*c11/v11;
    if abs(Gn1-Gn1_1)/Gn1<0.001
        break;
    else
        startp11=startp11+0.001;
    end
end
fprintf('����������\n'); 
u=pi*db*n/60;
w11=sqrt(c11^2+u^2-2*c11*u*cosd(alpha1));
beta11=asind(c11*sind(alpha1)/w11);
thet=beta1-beta11;
w11_1=w11*cosd(thet);
dhtbeta11=(w11*sind(thet))^2/2000;
dhtw11=(w11*cosd(thet))^2/2000;
h11_1=h11+dhtbeta11;
[x11_1,t11_1,v11_1,s11_1] = PH(p11, h11_1);
h101=h11+dhtbeta11+dhtw11;
[x101,p101,t101,v101] = HS(h101, s11_1);
dGt=0;
Gb1=G1+dGt;
Gcb1=0.648*Ab*sqrt(p101*1000000/v101);
if Gcb1<Gb1
    wangl = msgbox('�ü�Ϊ�ٽ繤�����ó����ʺϣ�', '�����ж�');
    return;
end
startp21=0.546*p101;
while(1)
    %�ڲ�С���ٽ�ѹ���ķ�Χ�ڣ�������趯Ҷ���ѹ��p21(MPa) 
    p21=startp21;
    [x2t1,t2t1,v2t1,h2t1] = PS(p21, s11_1);
    dhb01=h101-h2t1;
    if dhb01<0
        wangl = msgbox('�޷�����,���鶯Ҷ���ݣ�', '�����ж�');
        return;
    end
    dhb1=h11_1-h2t1;
    w21t=sqrt(2000*dhb01);
    w21=psai*w21t;
    dhtb1=(1/psai^2-1)*w21^2/2000;
    h21=h2t1+dhtb1;
    [x21,t21,v21,s21] = PH(p21, h21);
    Gb1_1=Ab*w21/v21;

    if abs(Gb1-Gb1_1)/Gb1<0.005
        break;
    else
        startp21=startp21+0.001;
    end
end
fprintf('��Ҷ�������\n'); 
c21=sqrt(w21^2+u^2-2*w21*u*cosd(beta2));
alpha21=asind(w21*sind(beta2)/w11);
dhtc21=c21^2/2000;
dht01=dhb1+dhn01;
omiga1=dhb1/dht01;
xa1=u/sqrt(2000*dht01);
dhu1=dht01-dhtn1-dhtb1-dhtc21;
sumdht=Getsumdeltah(sstyle,sl_a,dhu1,dht01,ln,db*1000,sl_K1,v01,v21,1,sl_ec,xa1,sl_Be,sl_sn,sl_Ce,G1,dGp,dGt,u,x01,x21);
dhi1=dhu1-sumdht;
E01=dht01-miu1*dhtc21;
hnextin=h001-dhi1-miu1*dhtc21;
dthc2next=miu1*dhtc21;
fprintf('��Ч��Ϊ��'); 
eff_ti1=dhi1/E01*100
fprintf('����Ϊ��'); 
Pi1=G1*dhi1
fprintf('�����������\n');  
% ��������
s_order=[{'��Ŀ'} {'��λ'} {'�乤��������'}];
s_discription=[{'��������'},{'�����ѹ��'},{'��Ҷ��ѹ��'},{'�������(�¼���ڣ�'},{'�¼����������ٶ���'},{'��ֹ�����ʽ�'},{'������'},{'�������Ч��'},{'�����ڹ���'}];
s_unit=[{'kg/s'},{'MPa'},{'MPa'},{'kJ/kg'},{'kJ/kg'},{'kJ/kg'},{' '},{'%'},{'kW'}];  
s_Data=[G1 p11 p21 hnextin dthc2next dht01 omiga1 eff_ti1 Pi1];
%      1   1  1    1           1     1      1      3      3   
xlswrite('Varying_results.xls',s_order,'SequenceCal_data','A1:C1');        
xlswrite('Varying_results.xls',s_discription','SequenceCal_data','A2:A10');
xlswrite('Varying_results.xls',s_unit','SequenceCal_data','B2:B10');
xlswrite('Varying_results.xls',num2cell(s_Data),'SequenceCal_data','C2:C10');
fprintf('�������Ѿ����浽��ǰĿ¼\n');   

