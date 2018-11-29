function [DC] = DPCM(origin)
%��DCϵ������DPCM����
    DC = struct('index',[]);
    [height,width,depth] = size(origin);
    for d=1:depth
        pos = 1;
        pass = 0; %��һ�������ֵ
        for m=1:8:height
            for n=1:8:width  %(m,n)Ϊ8x8�����Ͻ�Ԫ��
               DC(d).index(pos)=origin(m,n,d)-pass;
               pass = origin(m,n,d);
               pos = pos+1;
            end
        end
    end
end

