function [DC] = DPCM(origin)
%对DC系数进行DPCM编码
    DC = struct('index',[]);
    [height,width,depth] = size(origin);
    for d=1:depth
        pos = 1;
        pass = 0; %上一个计算的值
        for m=1:8:height
            for n=1:8:width  %(m,n)为8x8的左上角元素
               DC(d).index(pos)=origin(m,n,d)-pass;
               pass = origin(m,n,d);
               pos = pos+1;
            end
        end
    end
end

