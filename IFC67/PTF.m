function [V,H,S] = PTF(P,T)
%.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
% 已知压力温度求饱和水、过冷水的性质函数
%  Parameters: p      压力   MPa 
%              t      温度   ℃ 
%              vsteam      比容   m.^3./kg 
%              hsteam      比焓   kJ./kg
%              ssteam      比熵   kJ./(kg.℃ )
% .*.*.*.*作者：王雷 zrqwl2003@126.com.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
%.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
a=[6824.687741,-542.2063673,-20966.66205,39412.86787,-67332.77739,99023.81028,-109391.1774,85908.41667,-45111.68742,14181.38926,-2017.271113,7.982692717,-0.02616571843,0.00152241179, 0.02284279054,242.1647003,1.269716088E-10,2.074838328E-07, 2.17402035E-08,1.105710498E-09,12.93441934,0.00001308119072,6.047626338E-14];           
e=[0.8438375405,0.0005362162162,1.72,0.07342278489, 0.0497585887,0.65371543,0.00000115,0.000015108,0.14188,7.002753165,0.0002995284926,0.204];            
P=P.*10;
ZP=P./221.2;
ZT=(273.15+T)./647.3;
Y=1-e(1).*ZT.^2-e(2)./ZT.^6;
Z=Y+sqrt(e(3).*abs(Y).^2-2.*e(4).*ZT+2.*e(5).*ZP);
ZV=a(12).*e(5)./Z.^0.2941176;
ZV=ZV+(a(13)+a(14).*ZT+a(15).*ZT.^2+a(16).*(e(6)-ZT).^10+a(17)./(e(7)+ZT.^19));
ZV=ZV-(a(18)+2.*a(19).*ZP+3.*a(20).*ZP.^2)./(e(8)+ZT.^11);
ZV=ZV-a(21).*ZT.^18.*(e(9)+ZT.^2).*(-3./(e(10)+ZP).^4+e(11));
ZV=ZV+3.*a(22).*(e(12)-ZT).*ZP.^2+4.*a(23)./ZT.^20.*ZP.^3;
V=0.00317.*ZV;
YP=6.*e(2)./ZT.^7-2.*e(1).*ZT;
ZH=0;
for ik=1:1:10
    i=11-ik;
    ZH=ZH.*ZT+(i-2).*a(i+1);
end
ZH=a(1).*ZT-ZH+a(12).*(Z.*(17.*(Z./29-Y./12)+5.*ZT.*YP./12)+e(4).*ZT-(e(3)-1).*ZT.*YP.*Y)./Z.^0.2941176;
ZH=ZH+(a(13)-a(15).*ZT.^2+a(16).*(9.*ZT+e(6)).*(e(6)-ZT).^9+a(17).*(20.*ZT.^19+e(7))./(e(7)+ZT.^19).^2).*ZP;
ZH=ZH-(12.*ZT.^11+e(8)).*(a(18).*ZP+a(19).*ZP.^2+a(20).*ZP.^3)./(e(8)+ZT.^11).^2;
ZH=ZH+a(21).*ZT.^18.*(17.*e(9)+19.*ZT.^2).*(1./(e(10)+ZP).^3+e(11).*ZP);
ZH=ZH+a(22).*e(12).*ZP.^3+21.*a(23).*ZP.^4./ZT.^20;
H=ZH.*70.1204;
ZS=0;
for ik=2:1:10
    i=12-ik;
    ZS=ZS.*ZT+(i-1).*a(i+1);
end
ZS=a(1).*log(ZT)-ZS+a(12).*((5.*Z./12-(e(3)-1).*Y).*YP+e(4))./Z.^0.2941176;
ZS=ZS+(-a(14)-2.*a(15).*ZT+10.*a(16).*(e(6)-ZT).^9+19.*a(17).*ZT.^18./(e(7)+ZT.^19).^2).*ZP;
ZS=ZS-11.*ZT.^10.*(a(18).*ZP+a(19).*ZP.^2+a(20).*ZP.^3)./(e(8)+ZT.^11).^2;
ZS=ZS+a(21).*(18.*e(9)+20.*ZT.^2).*(e(11).*ZP+1./(e(10)+ZP).^3).*ZT.^17;
ZS=ZS+a(22).*ZP.^3+20.*a(23).*ZP.^4./ZT.^21;
S=108.3275143.*ZS./1000;
