function [ target ] = subsample( origin )
    [height,width,~] = size(origin); %������һά������width�᲻׼ȷ��������~��ռλ
    target = origin;
    for i=1:2:height
       if i==height
           break;               % �߽����δ����ȫ������
       end
       for j =1:2:width 
           if j==width          % �߽����δ����ȫ������
               break;
           end
           Cr = target(i,j,2);  %4:2:0�У�2x2�ĵ�λ�У���������ͬ��(Cr,Cb),Crȡ�����Ͻǣ�Cbȡ�����½�
           Cb = target(i+1,j,3);
           target(i,j,2) = Cr;
           target(i,j,3) = Cb;
           target(i,j+1,2) = Cr;
           target(i,j+1,3) = Cb;
           target(i+1,j,2) = Cr;
           target(i+1,j,3) = Cb;
           target(i+1,j+1,2) = Cr;
           target(i+1,j+1,3) = Cb;
       end
    end
end

