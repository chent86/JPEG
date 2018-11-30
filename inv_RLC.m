function [target] = inv_RLC(origin, AC)
% 从RLC编码恢复AC系数
    [height,width,depth] = size(origin);
    target = origin;
    % z字扫描的顺序
    order = [ 0,  1,  5,  6,  14, 15, 27, 28;
         2,  4,  7,  13, 16, 26, 29, 42;
         3,  8,  12, 17, 25, 30, 41, 43;
         9,  11, 18, 24, 31, 40, 44, 53;
         10, 19, 23, 32, 39, 45, 52, 54;
         20, 22, 33, 38, 46, 51, 55, 60;
         21, 34, 37, 47, 50, 56, 59, 61;
         35, 36, 48, 49, 57, 58, 62, 63];
     for d=1:depth
        block_index = 0;
        for m=1:8:height
            for n=1:8:width  %(m,n)为8x8的左上角元素
                block_index = block_index+1;
                [~,c] = size(AC(d).block(block_index).index);
                list = zeros(64);
                pos=1;
                % 游长编码恢复
                for i=1:c  
                    if AC(d).block(block_index).index(i).RUNLENGTH==0
                        list(pos)=AC(d).block(block_index).index(i).VALUE;
                        pos=pos+1;
                    else
                        loop = AC(d).block(block_index).index(i).RUNLENGTH;
                        for j=1:loop
                           list(pos)=0;
                           pos = pos+1;
                        end
                        list(pos)=AC(d).block(block_index).index(i).VALUE;
                        pos=pos+1;
                    end
                end
                % Z字恢复
                for i=0:7
                   if m+i>height
                       break;
                   end
                   for j=0:7
                      if i==0&&j==0 %对DC系数不处理
                         continue; 
                      end
                      if n+j>width
                          break;
                      end
                      target(m+i,n+j,d) = list(order(i+1,j+1));
                   end
                end
            end
        end
     end
end

