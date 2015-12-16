function Turbine_stagedistribute
%******************************************************
%分级计算
% ****作者：王雷 zrqwl2003@126.com***
%******************************************************
[sd_num,sd_name,sd_G1,sd_Gz,sd_xa0,sd_xaz,sd_dhn,sd_e,sd_n,sd_ln,sd_minn,sd_omiga,sd_alpha1,sd_p0,sd_h0,sd_hz,sd_pz,sd_thetz,sd_alphaz2,sd_hcz2,sd_dline,sd_xaline,sd_divide,sd_a,sd_Ka]=Known_stagedistribute_parameters;
for j=1:1:sd_num
    while(1)
        [sd_x0(j),sd_t0(j),sd_v0(j),sd_s0(j)] = PH(sd_p0(j),sd_h0(j));
        sd_ht1(j)=sd_h0(j)-sd_dhn(j);
        [sd_xt1(j),sd_pt1(j),sd_tt1(j),sd_vt1(j)] = HS(sd_ht1(j),sd_s0(j));
        sd_d1(j)=sqrt((1000*60*sd_G1(j)*sd_xa0(j)*sd_vt1(j))/(sd_e(j)*pi^2*sd_n(j)*sd_ln(j)*sd_minn(j)*sqrt(1-sd_omiga(j))*sind(sd_alpha1(j))));
        sd_u(j)=pi*sd_d1(j)*sd_n(j)/60;
        sd_dht(j)=sd_dhn(j)/(1-sd_omiga(j));
        sd_ca(j)=sqrt(2000*sd_dht(j));
        sd_xa01(j)= sd_u(j)/sd_ca(j);
        if abs(sd_xa01(j)-sd_xa0(j))/sd_xa0(j)<0.00001
            sd_d1(j)=round(sd_d1(j)*1000);
            break;
        else
            sd_xa0(j)=sd_xa01(j);
        end   
    end
    [sd_xz(j),sd_tz(j),sd_vz(j),sd_sz(j)] = PH(sd_pz(j),sd_hz(j));
    sd_dz(j)=sqrt((sd_Gz(j)*sd_vz(j)*sd_thetz(j))/(pi*sqrt(sd_hcz2(j)*2000)*sind(sd_alphaz2(j))));
    sd_dz(j)=round(sd_dz(j)*1000);
    for i=1:1:sd_divide
        sd_d(j,i)=sd_dline(j,1)*i^5+sd_dline(j,2)*i^4+sd_dline(j,3)*i^3+sd_dline(j,4)*i^2+sd_dline(j,5)*i+sd_dline(j,6);
        sd_xa(j,i)=sd_xaline(j,1)*i^5+sd_xaline(j,2)*i^4+sd_xaline(j,3)*i^3+sd_xaline(j,4)*i^2+sd_xaline(j,5)*i+sd_xaline(j,6);     
    end
%     sd_d(j,1)=sd_d1(j); sd_d(j,sd_divide)=sd_dz(j);sd_xa(j,1)=sd_xa0(j);sd_xa(j,sd_divide)=sd_xaz(j);
    for i=1:1:sd_divide 
        sd_dh(j,i)=12.3245*(sd_d(j,i)/sd_xa(j,i)/1000)^2; 
    end
    sd_avgdh(j)=sum(sd_dh(j,:),2)/sd_divide(j);
    [sd_xzt(j),sd_tzt(j),sd_vzt(j),sd_hzt(j)] = PS(sd_pz(j),sd_s0(j));
    while(1)
        sd_z(j)=round((sd_h0(j)-sd_hzt(j))*(1+sd_a(j))/sd_avgdh(j));
        sd_a1(j)=sd_Ka(j)*(sd_hz(j)-sd_hzt(j))*sd_z(j)/(sd_z(j)+1);
        if abs(sd_a1(j)-sd_a(j))/sd_a1(j)<0.001
            break; 
        else
            sd_a(j)=sd_a1(j);  
        end   
    end
    for i=1:1:sd_z(j)
        ti(j,i)=(sd_divide(j)-1)*(i-1)/(sd_z(j)-1)+1;
        sd_d(j,i)=round(sd_dline(j,1)*ti(j,i)^5+sd_dline(j,2)*ti(j,i)^4+sd_dline(j,3)*ti(j,i)^3+sd_dline(j,4)*ti(j,i)^2+sd_dline(j,5)*ti(j,i)+sd_dline(j,6));
        sd_xa(j,i)=sd_xaline(j,1)*ti(j,i)^5+sd_xaline(j,2)*ti(j,i)^4+sd_xaline(j,3)*ti(j,i)^3+sd_xaline(j,4)*ti(j,i)^2+sd_xaline(j,5)*ti(j,i)+sd_xaline(j,6);     
    end
%     sd_d(j,1)=sd_d1(j); sd_d(j,sd_z(j))=sd_dz(j);sd_xa(j,1)=sd_xa0(j);sd_xa(j,sd_z(j))=sd_xaz(j);
    for i=1:1:sd_z(j)
        sd_dh(j,i)=12.3245*(sd_d(j,i)/sd_xa(j,i)/1000)^2; 
    end
    sd_diffh(j)=(sum(sd_dh(j,:),2)-(sd_h0(j)-sd_hzt(j))*(1+sd_a(j)))/sd_z(j);
    for i=1:1:sd_z(j)
        sd_dh1(j,i)=sd_dh(j,i)+sd_diffh(j); 
    end
    stagegraph=figure(j);
    subplot(3,1,1);
    plot(1:sd_z(j),sd_d(j,1:sd_z(j)),'-ko','LineWidth',2, 'MarkerFaceColor','g','MarkerSize',5);
    xlabel('级序号')
    ylabel('级直径d(mm)')
    title('直径d变化图')
    grid on
    hold on
    subplot(3,1,2);
    plot(1:sd_z(j),sd_dh1(j,1:sd_z(j)),'-ko','LineWidth',2, 'MarkerFaceColor','g','MarkerSize',5);
    xlabel('级序号')
    ylabel('级比焓降ht(kJ/kg)')
    title('比焓降ht变化图')
    grid on
    hold on
    subplot(3,1,3);
    plot(1:sd_z(j),sd_xa(j,1:sd_z(j)),'-ko','LineWidth',2, 'MarkerFaceColor','g','MarkerSize',5);
    xlabel('级序号')
    ylabel('级速比xa')
    title('速比xa变化图')
    grid on
    hold on
    saveas(stagegraph,strcat('stagegraph',num2str(j),'.fig'));
end

% 保存数据
for i=1:1:sd_num
    sd_order=sd_name(i);
    sd_order1=[{'直径'} {'速比'} {'比焓降'} {'调整后比焓降'}];
    sd_unit=[{'mm'},{' '},{'kJ/kg'},{'kJ/kg'}];  
    sd_Data=[sd_d(i,:)',sd_xa(i,:)',sd_dh(i,:)',sd_dh1(i,:)'];
    xlswrite('Design_results.xls',sd_order,'stage_distribute',strcat(char(65+(i-1)*4),'1'));        
    xlswrite('Design_results.xls',sd_order1,'stage_distribute',strcat(char(65+(i-1)*4),'2:',char(68+(i-1)*4),'2'));        
    xlswrite('Design_results.xls',sd_unit,'stage_distribute',strcat(char(65+(i-1)*4),'3:',char(68+(i-1)*4),'3'));
    xlswrite('Design_results.xls',num2cell(sd_Data),'stage_distribute',strcat(char(65+(i-1)*4),'4:',char(68+(i-1)*4),num2str(sd_z(i)+3)));
    fprintf('计算结果已经保存到当前目录\n');   
end
