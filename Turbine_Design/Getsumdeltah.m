	function [sumdeltah,deltahl,deltahtht,deltahf,deltahe,deltahd,deltahx]=Getsumdeltah(style,a,dhu,E0,ln,dm,K1,v1,v2,e,ec,xa,Be,sn,Ce,G,dGp,dGt,u,x0,x2)
%************************
%���㼶����ʧ��������ʧ֮��ģ�
% ****���ߣ����� zrqwl2003@126.com***
%**************************
%��P127ҳ
%a����ϵ��������ҶƬ���ͱ仯
if a==1.6
    deltahl=a/ln*dhu;%Ҷ����ʧ
    deltahtht=0;%������ʧ
else
    deltahl=a/ln*dhu;%Ҷ����ʧ
    deltahtht=0.7*(ln/dm)^2*E0;%������ʧ
end
%�ж�Ҷ��
if style==0
    deltahf=K1*(u/100)^3*(dm*0.001)^2/((v1+v2)/2)/G;%Ҷ��Ħ����ʧ
else
    deltahf=0;
end
%���㲿�ֽ�����ʧ�����ж�
if e==1 
    deltahe=0;
else
    deltahw=Be*(1-e-ec/2)*xa^3/e;%�ķ���ʧ
    deltahs=Ce*sn*xa/e/(dm*0.001);%������ʧ
    deltahe=(deltahw+deltahs)*E0;%���ֽ�����ʧ
end
deltahp=dGp/G*(dhu-deltahl);%����©����ʧ
deltaht=dGt/G*(dhu-deltahl);%Ҷ��©����ʧ
deltahd=deltahp+deltaht;%©����ʧ
if x0>0 && x0<1 && x2>0 && x2<1  %ʪ����ʧ  
    deltahx=(1-(x0+x2)/2)*(dhu-deltahl);
else
    deltahx=0; 
end
%���ڸ�����ʧ֮��
sumdeltah=deltahl+deltahtht+deltahf+deltahe+deltahd+deltahx;