function T = TSK(P)
%***************************************
% ĳ��ѹ�������¶Ⱥ���
%  Parameters: P      ѹ��   MPa 
%              t      �¶�   �� 
% ****���ߣ����� zrqwl2003@126.com*******
%***************************************
TA = 100 * P ^ 0.25;
k=1;           
while(1)
    PB = PSK(TA);
    if(abs((P - PB) / P) < 0.0000001)
        T = TA;
        k=0;  
        break;
    else
        TA = TA + 25 * (P - PB) / PB ^ 0.75;
    end
end 