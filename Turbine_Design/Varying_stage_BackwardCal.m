function Varying_stage_BackwardCal
%%%ѹ�����乤����������ӳ���%%
%%%%%%%%%%%%���㷽��ԭ��%%%%%%%%%%%%%%%
%%%�ɼ�����ǰ�������֪�ļ���ѹ����ʼ�������¹������������ʼ����������ʧ%%
%%%�����Ҷ�����������ǰ������������ʧ����У�˼�����%%
%%%�̶��ٶ���Ҷ��������ٶȣ������Ҷǰ��������������%%
%%%�ٶԶ�Ҷ��������ٶȽ���У�˲����������ȷ������ǰ����״̬��%%
%%%����������Ƶĸ�����ʧ����У�˼�����%%
%%%��������趼У��ͨ������������¹����¼��ķ����ȡ���Ч�ʺ��ڹ���%%
%%%�����ڳ��ֳ���������ʱ������ȷ���ٽ�״̬�㲢�����������ƫת��%%
% ****���ߣ����� zrqwl2003@126.com***
%*******************************************************
% ������ƹ����¼��乤���²���
[sstyle,G,p2,h2s,dthc2,dthl,dthf,dthx,dthdel,dht,miu1,Ab,miub,alpha1,beta1,beta2,db,ln,psai,w1,w2,thet,An,miun,fai,G1,p21,h21s,dht1]=Known_stage_backward;
[sl_num,sl_a,sl_K1,sl_ec,sl_Be,sl_sn,sl_Ce,sl_zp,sl_up,sl_dp,sl_detp,sl_ut,sl_ot,sl_detz,sl_detr,sl_zr]=Known_stageloss_parameters;
[s_num,s_name,s_style,s_G,s_p0,s_t0,s_c0,s_dht,s_n,s_dm,s_omiga,s_e,s_alpha1,s_beta2,s_fai,s_miun,s_psai,s_miub,s_gdt,s_gdr,s_miu0,s_miu1]=Known_stage_parameters
[x2s,t2s,v2s,s2s]=PH(p2,h2s);
if (x2s>1)
    x2s=1;
end
[x21s,t21s,v21s,s21s]=PH(p21,h21s);
if (x21s>1)
    x21s=1;
end
% ���㼶����ʧ
dthl1=dthl*dht1/dht;
dthf1=dthf*(G*v2s/(G1*v21s));
if(x2s~= 1)
    dthx1=dthx*dht1/dht*(1-x21s)/(1-x2s);
else
    dthx1=0;
end
dthdel1=dthdel*dht1/dht;
dthc21=dthc2*(G1*v21s/(G*v2s))^2;
sumdth=dthl1+dthf1+dthx1+dthdel1;
while(1)
    while(1)
        sumdth1=sumdth+(1-miu1)*dthc21;
        %ȷ����Ҷ����״̬��2
        h21=h21s-sumdth1;
        [x21,t21,v21,s21]=PH(p21,h21);%2��
        if (abs(x21)>1)
            x21=1;
        end
        %����Ҷ��©��
        if sl_detr==0
             dGt=0;
        else
            sl_det=sl_detz/sqrt(1+sl_zr*(sl_detz/sl_detr)^2);
            dGt=sl_ut*(pi*(s_dm+s_lb)*sl_det/1000000)*sqrt(2000*sl_ot*dht1)/v21;
        end
        %��Ҷ����
        Gb1=G1+dGt;
        w21=Gb1*v21/Ab;
        if(x21==1)
            k=1.3;
        else
            k=1.035*x21*0.1;
        end
        w2c=sqrt(k*p21*1000000*v21);
        u=pi*db*3000/60;
        if(w21>w2c)
            %fprintf('��Ҷ�ٽ�\n');
            p2c=p21*(Gb1/(Ab*sqrt(k*p21*1000000/v21)))^(2*k/(k+1));
            v2c=k*p2c*1000000/((Gb1/Ab)^2);
            w2c=sqrt(k*p2c*1000000*v2c);
            dhbc0=w2c^2/2000;
            [X2c,T2c,S2c,h2c] = PV(p2c,v2c);
            dhb0=h2c-h21;
            w21=psai*sqrt(2000*(dhbc0+dhb0));
            beta21=asind(sind(beta2)*w2c*v21/w21/v2c);
            c21=sqrt(w21^2+u^2-2*w21*u*cosd(beta21));
            alpha21=asind(w21*sind(beta21)/c21);
        else
            %fprintf('��Ҷ���ٽ�\n');
            c21=sqrt(w21^2+u^2-2*w21*u*cosd(beta2));
            alpha21=asind(w21*sind(beta2)/c21);
        end
        dthc21s=c21^2/2000;
        if( abs(dthc21s-dthc21)<0.0005)
            break;
        else
            dthc21=dthc21s;
        end
    end
%         fprintf('��Ҷ�������\n'); 
        dthb1=w21^2/2000*(1/psai^2-1);
        dhb10=(w21/psai)^2/2000;
        h2t1=h21-dthb1;
        [X2t1,T2t1,V2t1,S2t1] = PH(p21,h2t1);%3��
        h110=h2t1+dhb10;
        [X110,p110,T110,V110] = HS(h110,S2t1);%40��
        dthw1=(w1*w21/w2)^2/2000;
        dthbeta1=(w1*w21*sind(thet)/w2/cosd(thet))^2/2000;
    while(1)
        dthb1=dhb10-dthw1;
        h11=h2t1+dthb1;
        [X11,p11,T11,V11] = HS(h11,S2t1);%4��
        h51=h11-dthbeta1;%5����
        [x11,T11,v11,S11] = PH(p11,h51);%5��
        if (x11>1)
            x11=1;
        end
        %�������©��
        if sl_zp==0
            dGp=0;
        else
            dGp=sl_up*(pi*sl_dp*sl_detp/1000000)*sqrt(2000*dht1)/(v11*sqrt(sl_zp));
        end
        %��������
        Gn1=Gb1-dGp;
        c11=Gn1*v11/An;
        if(x11==1)
            k=1.3;
        else
            k=1.035*x11*0.1;
        end
        c1c=sqrt(k*p11*1000000*v11);
        dn=db;
        u=pi*dn*3000/60;
        if(c11>c1c)
            %fprintf('�����ٽ�\n');
            p1c=p11*(Gn1/(An*sqrt(k*p11*1000000/v11)))^(2*k/(k+1));
            v1c=k*p1c*1000000/((Gn1/An)^2);
            c1c=sqrt(k*p1c*1000000*v1c);
            dhnc=c1c^2/2000;
            [X1c,T1c,S1c,h1c] = PV(p1c,v1c);
            dhn0=h1c-h11;
            c11=fai*sqrt(2000*(dhnc+dhn0));
            alpha11=asind(sind(alpha1)*c1c*v11/c11/v1c);
            w11=sqrt(c11^2+u^2-2*c11*u*cosd(alpha11));
            beta11=asind(c11*sind(alpha11)/w11);
        else
            %fprintf('�������ٽ�\n');
            w11=sqrt(c11^2+u^2-2*c11*u*cosd(alpha1));
            beta11=asind(c11*sind(alpha1)/w11);

        end
        dthw1s=w11^2/2000;
        if( abs(dthw1s-dthw1)<0.0005)
            break;
        else
            dthw1=dthw1s;
            thet=beta1-beta11;
            dthbeta1=(w11*sind(thet))^2/2000;
        end
    end
%         fprintf('����������\n');     
        dthn1=c11^2/2000*(1/fai^2-1);
        dhn10=(c11/fai)^2/2000;
        h61=h11-dthbeta1-dthn1;%6����
        [x61,T61,v61,S61] = PH(p11,h61);%6��
        h010=h61+dhn10;
        [x010,p010,T010,v010] = HS(h010,S61);%00��
        if (x010>1)
            x010=1;
        end
        [X1t, T1t, V1t, h1t]= PS(p21,S61);%����������
        Deltaht10=h010-h1t;%���������ʽ�
        xa=u/sqrt(2000*Deltaht10);
        Deltahu1=Deltaht10-dthn1-dthb1-dthc21;%������Ч�ʽ�
%         sumdths=Getsumdeltah(Deltahu1,v010,v21,G1,u,db,alpha1,deltaGp,x010,x21);%���㼶����ʧ
        sumdths=Getsumdeltah(sstyle,sl_a,Deltahu1,Deltaht10,ln,db*1000,sl_K1,v010,v21,1,sl_ec,xa,sl_Be,sl_sn,sl_Ce,G1,dGp,dGt,u,x010,x21);
        if( abs(sumdths-sumdth)<0.0005)
            break;
        else 
            sumdth=sumdths;
            deltaht1=Deltaht10;
        end  
end
omiga1=dthb1/(dthb1+dhn10);
Deltahi1=Deltahu1-sumdth;
E01=Deltaht10-miu1*dthc21;
fprintf('��Ч��Ϊ��'); 
eff_ti1=Deltahi1/E01*100
fprintf('����Ϊ��'); 
Pi1=G1*Deltahi1
fprintf('�����������\n');  
% ��������
s_order=[{'��Ŀ'} {'��λ'} {'�乤��������'}];
s_discription=[{'��������'},{'��ǰ��ֹѹ��'},{'��ǰ��ֹ����ֵ'},{'�����ʽ�'},{'������'},{'�������Ч��'},{'�����ڹ���'}];
s_unit=[{'kg/s'},{'MPa'},{'kJ/kg'},{'kJ/kg'},{' '},{'%'},{'kW'}];  
s_Data=[G1;p010;h010;deltaht1;omiga1;eff_ti1;Pi1];
xlswrite('Varying_results.xls',s_order,'BackwardCal_data','A1:C1');        
xlswrite('Varying_results.xls',s_discription','BackwardCal_data','A2:A8');
xlswrite('Varying_results.xls',s_unit','BackwardCal_data','B2:B8');
xlswrite('Varying_results.xls',num2cell(s_Data),'BackwardCal_data','C2:C8');
fprintf('�������Ѿ����浽��ǰĿ¼\n');   

