function Turbine_stage 
%******************************************************
%����ϸ����
% ****���ߣ����� zrqwl2003@126.com***
%******************************************************
[s_num,s_name,s_style,s_G,s_p0,s_t0,s_c0,s_dht,s_n,s_dm,s_omiga,s_e,s_alpha1,s_beta2,s_fai,s_miun,s_psai,s_miub,s_gdt,s_gdr,s_miu0,s_miu1]=Known_stage_parameters;
[sl_num,sl_a,sl_K1,sl_ec,sl_Be,sl_sn,sl_Ce,sl_zp,sl_up,sl_dp,sl_detp,sl_ut,sl_ot,sl_detz,sl_detr,sl_zr]=Known_stageloss_parameters;
if s_num==sl_num
    for j=1:1:s_num
        if s_t0(j)<1
            s_x0(j)=s_t0(j);       
            [s_t0(j),s_v0(j),s_h0(j),s_s0(j)]= PX(s_p0(j),s_x0(j));
        else
            [s_x0(j),s_v0(j),s_h0(j),s_s0(j)]= PT(s_p0(j),s_t0(j));
        end
        s_dhc0(j)=s_c0(j)^2/2000;
        s_h00(j)=s_h0(j)+s_dhc0(j);
        [s_x00(j),s_p00(j),s_t00(j),s_v00(j)] = HS(s_h00(j), s_s0(j));
        s_dht0(j)=s_dht(j)+s_miu0(j)*s_dhc0(j);
        s_dhn0(j)=(1-s_omiga(j))*s_dht0(j);
        s_c1t(j)=sqrt(2000*s_dhn0(j));
        s_c1(j)=s_fai(j)*s_c1t(j);
        s_h1t(j)=s_h00(j)-s_dhn0(j);
        [s_x1t(j),s_p1(j),s_t1t(j),s_v1t(j)] = HS(s_h1t(j), s_s0(j));
        s_etn(j)=s_p1(j)/s_p00(j);
        %�������©��
        if sl_zp(j)==0
            s_dGp(j)=0;
        else
            s_dGp(j)=sl_up(j)*(pi*sl_dp(j)*sl_detp(j)/1000000)*sqrt(2000*s_dht0(j))/(s_v1t(j)*sqrt(sl_zp(j)));
        end
        s_Gn(j)=s_G(j)-s_dGp(j);
        s_An(j)=(s_Gn(j)*s_v1t(j))/(s_miun(j)*s_c1t(j));
        s_ca(j)=sqrt(2000*s_dht0(j));
        s_u(j)=pi*s_dm(j)*s_n(j)/60/1000;
        s_xa(j)=s_u(j)/s_ca(j); 
        s_ln(j)=round(s_An(j)*1000000/(s_e(j)*pi*s_dm(j)*sind(s_alpha1(j))));
        sl_dthn(j)=(1-s_fai(j)^2)*s_dhn0(j);
        s_h1(j)=s_h1t(j)+sl_dthn(j);
        [s_x1(j),s_t1(j),s_v1(j),s_s1(j)] = PH(s_p1(j), s_h1(j));
        if s_x1(j)<1
            s_t1(j)=s_x1(j);
        end
        s_w1(j)=sqrt(s_c1(j)^2+s_u(j)^2-2*s_c1(j)*s_u(j)*cosd(s_alpha1(j)));
        s_beta1(j)=asind(s_c1(j)*sind(s_alpha1(j))/s_w1(j));
        s_dthw1(j)=s_w1(j)^2/2000;
        s_w2t(j)=sqrt(2000*s_omiga(j)*s_dht0(j)+s_w1(j)^2);
        s_w2(j)=s_psai(j)*s_w2t(j);
        s_h2t(j)=s_h1(j)-s_omiga(j)*s_dht0(j);
        [s_x2t(j),s_p2(j),s_t2t(j),s_v2t(j)] = HS(s_h2t(j), s_s1(j));
        s_lb(j)=s_ln(j)+s_gdt(j)+s_gdr(j);
         %����Ҷ��©��
        if sl_detr(j)==0
             s_dGt(j)=0;
        else
            sl_det(j)=sl_detz(j)/sqrt(1+sl_zr(j)*(sl_detz(j)/sl_detr(j))^2);
            s_dGt(j)=sl_ut(j)*(pi*(s_dm(j)+s_lb(j))*sl_det(j)/1000000)*sqrt(2000*sl_ot(j)*s_dht0(j))/s_v2t(j);
        end
        s_Gb(j)=s_Gn(j)-s_dGt(j);
        s_Ab(j)=(s_Gb(j)*s_v2t(j))/(s_miub(j)*s_w2t(j));
        s_c2(j)=sqrt(s_w2(j)^2+s_u(j)^2-2*s_w2(j)*s_u(j)*cosd(s_beta2(j)));
        s_alpha2(j)=180-acosd((s_c2(j)^2+s_u(j)^2-s_w2(j)^2)/(2*s_u(j)*s_c2(j)));
        s_dhb0(j)=s_w2t(j)^2/2000;
        sl_dthb(j)=(1-s_psai(j)^2)*s_dhb0(j);
        s_h2(j)=s_h2t(j)+sl_dthb(j);
        [s_x2(j),s_t2(j),s_v2(j),s_s2(j)] = PH(s_p2(j), s_h2(j));
        if s_x2(j)<1
            s_t2(j)=s_x2(j);
        end
        sl_dthc2(j)=s_c2(j)^2/2000;
        sl_dthu(j)=sl_dthn(j)+sl_dthb(j)+sl_dthc2(j);
        s_dhu(j)=s_dht0(j)-sl_dthu(j);
        s_E0(j)=s_dht0(j)-s_miu1(j)*sl_dthc2(j);
        s_effu(j)=s_dhu(j)/s_E0(j)*100;
        s_wu(j)=s_u(j)*(s_c1(j)*cosd(s_alpha1(j))+s_c2(j)*cosd(s_alpha2(j)))/1000;
        s_effu1(j)=s_wu(j)/s_E0(j)*100;
        if (abs(s_effu(j)-s_effu1(j))/s_effu1(j))>0.01 
            wangl = msgbox(strcat('��' ,num2str(j),'������Ч��У�����ϴ����飡'), '����Ч��У��');
        end
        s_Pu(j)=s_dhu(j)*s_G(j);
        [sl_sumdth(j),sl_deltahl(j),sl_deltahtht(j),sl_deltahf(j),sl_deltahe(j),sl_deltahd(j),sl_deltahx(j)]=Getsumdeltah(s_style(j),sl_a(j),s_dhu(j),s_E0(j),s_ln(j),s_dm(j),sl_K1(j),s_v1(j),s_v2(j),s_e(j),sl_ec(j),s_xa(j),sl_Be(j),sl_sn(j),sl_Ce(j),s_G(j),s_dGp(j),s_dGt(j),s_u(j),s_x0(j),s_x2(j));
        s_h21(j)=s_h2(j)+sl_dthc2(j)+sl_sumdth(j);
        [s_x21(j),s_t21(j),s_v21(j),s_s21(j)] = PH(s_p2(j), s_h21(j));
        s_dhi(j)=s_dhu(j)-sl_sumdth(j);
        s_effi(j)=s_dhi(j)/s_E0(j)*100;
        s_Pi(j)=s_dhi(j)*s_G(j);
    end
    % �������� 
    s_order=[{'��Ŀ'} {'��λ'} s_name];
    s_discription=[{'��������'},{'����ƽ��ֱ��'},{'��Ҷƽ��ֱ��'},{'��ǰѹ��'},{'��ǰ�¶�/�ɶ�'},{'��ǰ�ٶ�'},{'��ǰ����ֵ'},{'Բ���ٶ�'},{'�����ʽ�'},{'�����ٶ�'},{'�����ٱ�'},{'������'},{'�����ϼ����ٶ���'},{'������ֹ���ʽ�'},{'������������ٶ�'},{'�����ٶ�ϵ��'},{'�������ʵ���ٶ�'},{'������ʧ'},{'�����ѹ��'},{'������¶�/�ɶ�'},{'��������������'},{'������ڽ����'},{'���������'},{'����߶�'},{'���ֽ�����'},{'��Ҷ��������ٶ�'},{'�����w1�ı��ʽ�'},{'��Ҷ��ֹ���ʽ�'},{'��Ҷ���������ٶ�'},{'��Ҷ�ٶ�ϵ��'},{'��Ҷ��ʧ'},{'��Ҷ����ʵ���ٶ�'},{'��Ҷ���ھ����ٶ�'},{'������ʧ'},{'��Ҷ��ѹ��'},{'��Ҷ���¶�/�ɶ�'},{'��Ҷ���ڱ���'},{'��Ҷ�������'},{'��Ҷ������'},{'��Ҷ�߶�'},{'����������'},{'������Ч���ʽ�'},{'���ܹ���'},{'����Ч��'},{'Ҷ����ʧ'},{'�ķ�Ħ����ʧ'},{'���ֽ�����ʧ'},{'©����ʧ'},{'ʪ����ʧ'},{'������Ч���ʽ�'},{'�������Ч��'},{'�����ڹ���'}];
    s_unit=[{'kg/s'},{'mm'},{'mm'},{'MPa'},{'��'},{'m/s'},{'kJ/kg'},{'m/s'},{'kJ/kg'},{'m/s'},{' '},{' '},{'kJ/kg'},{'kJ/kg'},{'m/s'},{' '},{'m/s'},{'kJ/kg'},{'MPa'},{'��'},{'m^3/kg'},{'m^2'},{'(o)'},{'mm'},{' '},{'m/s'},{'kJ/kg'},{'kJ/kg'},{'m/s'},{' '},{'kJ/kg'},{'m/s'},{'m/s'},{'kJ/kg'},{'MPa'},{'��'},{'m^3/kg'},{'m^2'},{'(o)'},{'mm'},{'kJ/kg'},{'kJ/kg'},{'kW'},{'%'},{'kJ/kg'},{'kJ/kg'},{'kJ/kg'},{'kJ/kg'},{'kJ/kg'},{'kJ/kg'},{'%'},{'kW'}];  
    s_Data=[s_G;s_dm;s_dm;s_p0;s_t0;s_c0;s_h00;s_u;s_dht;s_ca;s_xa;s_omiga;s_dhc0;s_dhn0;s_c1t;s_fai;s_c1;sl_dthn;s_p1;s_t1;s_v1;s_An;s_alpha1;s_ln;s_e;s_w1;s_dthw1;s_dhb0;s_w2t;s_psai;sl_dthb;s_w2;s_c2;sl_dthc2;s_p2;s_t2;s_v2;s_Ab;s_beta2;s_lb;s_E0;s_dhu;s_Pu;s_effu;sl_deltahl;sl_deltahf;sl_deltahe;sl_deltahd;sl_deltahx;s_dhi;s_effi;s_Pi];
    xlswrite('Design_results.xls',s_order,'stage_data',strcat('A1:',char(65+1+s_num),'1'));        
    xlswrite('Design_results.xls',s_discription','stage_data',strcat('A2:A',num2str(53)));
    xlswrite('Design_results.xls',s_unit','stage_data',strcat('B2:B',num2str(53)));
    xlswrite('Design_results.xls',num2cell(s_Data),'stage_data',strcat('C2:',char(65+1+s_num),num2str(53)));
    fprintf('�������Ѿ����浽��ǰĿ¼\n');   

else 
    wangl = msgbox(strcat('����������ʧ���ݲ���Ӧ,���飡'), '����ϸ����');
end