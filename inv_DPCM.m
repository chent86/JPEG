function [target] = inv_DPCM(origin, DC)
% ��DPCM����ָ�DCϵ��
    target = origin;
    [height,width,depth] = size(origin);
    for d=1:depth
        pos = 1;
        pass = 0; %��һ�������ֵ
        for m=1:8:height
            for n=1:8:width  %(m,n)Ϊ8x8�����Ͻ�Ԫ��
               target(m,n,d) = DC(d).index(pos)+pass;
               pass = target(m,n,d);
               pos = pos+1;
            end
        end
    end
end