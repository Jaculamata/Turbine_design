function Turbine_lossflow 
%******************************************************
%�����Ÿ����©����
% ****���ߣ����� zrqwl2003@126.com***
%******************************************************
[lf_location,lf_style,lf_discription,lf_num,lf_segments,lf_diameter,lf_interval,lf_miu,lf_p0,lf_pz,lf_v0,lf_z]=Known_lossflow_parameters;
for j=1:1:lf_location
    if lf_style(j)==0 
        for i=1:1:lf_segments(j)    
            Av(j,i)=pi*lf_diameter(j,i)*lf_interval(j,i);
            Dls(j,i)=lf_num(j)*0.24*lf_miu(j,i)*Av(j,i)*sqrt(lf_p0(j,i)/lf_v0(j,i));
        end          
    else
        for i=1:1:lf_segments(j)    
            Av(j,i)=pi*lf_diameter(j,i)*lf_interval(j,i);
            K(j,i)=0.82/sqrt(1.25+lf_z(j,i));
            pratio(j,i)=lf_pz(j,i)/lf_p0(j,i);
            if K(j,i)<pratio(j,i)
                Dls(j,i)=lf_num(j)*0.36*lf_miu(j,i)*Av(j,i)*sqrt((lf_p0(j,i)^2-lf_pz(j,i)^2)/(lf_v0(j,i)*lf_p0(j,i)*lf_z(j,i)));
            else 
                Dls(j,i)=lf_num(j)*0.36*lf_miu(j,i)*Av(j,i)*sqrt(lf_p0(j,i)/((lf_z(j,i)+1.25)*lf_v0(j,i)));                
            end
        end      
    end
end 

% ��������
lforder=[{'��1��'} {'��2��'} {'��3��'} {'��4��'} {'��5��'} {'��6��'}];
xlswrite('Design_results.xls',lforder,'lossflow','B1:G1');        
xlswrite('Design_results.xls',lf_discription','lossflow',strcat('A2:A',num2str(lf_location+1)));
xlswrite('Design_results.xls',num2cell(Dls),'lossflow',strcat('B2:G',num2str(lf_location+1)));
fprintf('�������Ѿ����浽��ǰĿ¼\n');  

