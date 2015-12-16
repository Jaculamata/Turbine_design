	function [sumdeltah,deltahl,deltahtht,deltahf,deltahe,deltahd,deltahx]=Getsumdeltah(style,a,dhu,E0,ln,dm,K1,v1,v2,e,ec,xa,Be,sn,Ce,G,dGp,dGt,u,x0,x2)
%************************
%¼ÆËã¼¶ÄÚËðÊ§£¨ÂÖÖÜËðÊ§Ö®ÍâµÄ£©
% ****×÷Õß£ºÍõÀ× zrqwl2003@126.com***
%**************************
%ÊéP127Ò³
%a¾­ÑéÏµÊý£¬¸ù¾ÝÒ¶Æ¬ÀàÐÍ±ä»¯
if a==1.6
    deltahl=a/ln*dhu;%Ò¶¸ßËðÊ§
    deltahtht=0;%ÉÈÐÎËðÊ§
else
    deltahl=a/ln*dhu;%Ò¶¸ßËðÊ§
    deltahtht=0.7*(ln/dm)^2*E0;%ÉÈÐÎËðÊ§
end
%ÅÐ¶ÏÒ¶ÐÍ
if style==0
    deltahf=K1*(u/100)^3*(dm*0.001)^2/((v1+v2)/2)/G;%Ò¶ÂÖÄ¦²ÁËðÊ§
else
    deltahf=0;
end
%¼ÆËã²¿·Ö½øÆøËðÊ§£¬ÏÈÅÐ¶Ï
if e==1 
    deltahe=0;
else
    deltahw=Be*(1-e-ec/2)*xa^3/e;%¹Ä·çËðÊ§
    deltahs=Ce*sn*xa/e/(dm*0.001);%³âÆûËðÊ§
    deltahe=(deltahw+deltahs)*E0;%²¿·Ö½øÆûËðÊ§
end
deltahp=dGp/G*(dhu-deltahl);%¸ô°åÂ©ÆûËðÊ§
deltaht=dGt/G*(dhu-deltahl);%Ò¶¶¥Â©ÆûËðÊ§
deltahd=deltahp+deltaht;%Â©ÆûËðÊ§
if x0>0 && x0<1 && x2>0 && x2<1  %ÊªÆûËðÊ§  
    deltahx=(1-(x0+x2)/2)*(dhu-deltahl);
else
    deltahx=0; 
end
%¼¶ÄÚ¸÷ÏîËðÊ§Ö®ºÍ
sumdeltah=deltahl+deltahtht+deltahf+deltahe+deltahd+deltahx;