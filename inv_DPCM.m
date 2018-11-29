function [target] = inv_DPCM(origin, DC)
% 从DPCM编码恢复DC系数
    target = origin;
    [height,width,depth] = size(origin);
    for d=1:depth
        pos = 1;
        pass = 0; %上一个计算的值
        for m=1:8:height
            for n=1:8:width  %(m,n)为8x8的左上角元素
               target(m,n,d) = DC(d).index(pos)+pass;
               pass = target(m,n,d);
               pos = pos+1;
            end
        end
    end
end