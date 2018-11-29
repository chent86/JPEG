function [ target ] = quantization(origin)
%亮度表
bright = [ 16 11 10 16 24 40 51 61;
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 55;
        14 17 22 29 51 87 80 62;
        18 22 37 56 68 109 103 77; 
        24 35 55 64 81 104 113 92;                      
        49 64 78 87 103 121 120 101;                   
        72 92 95 98 112 100 103 99];
%色度表
color = [17 18 24 47 99 99 99 99; 
        18 21 26 66 99 99 99 99; 
        24 26 56 99 99 99 99 99; 
        47 66 99 99 99 99 99 99; 
        99 99 99 99 99 99 99 99; 
        99 99 99 99 99 99 99 99; 
        99 99 99 99 99 99 99 99; 
        99 99 99 99 99 99 99 99];
[height,width,depth] = size(origin);
target = zeros(height,width,depth);
    for d=1:depth
        for m=1:8:height
            for n=1:8:width  %(m,n)为8x8的左上角元素
                for u=0:7
                   if u+m > height
                      break; 
                   end
                   for v=0:7  % (u+m,v+n)为8x8内的元素
                      if v+n > width
                          break;
                      end
                      if d==1
                          target(u+m,v+n,d) = origin(u+m,v+n,d)/bright(u+1,v+1);
                      else
                          target(u+m,v+n,d) = origin(u+m,v+n,d)/color(u+1,v+1);
                      end
                   end
                end
            end
        end
    end
    target = round(target);  %取整
end



