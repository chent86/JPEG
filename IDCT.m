function [target] = IDCT( origin ) % 与DCT公式类似，然而代码上实际有较多调整
    [height,width,depth] = size(origin);
    target = zeros(height,width,depth);
    for d=1:depth
        for m=1:8:height
            for n=1:8:width  %(m,n)为8x8的左上角元素
                for i=0:7
                   if i+m > height
                      break; 
                   end
                   for j=0:7  % (u+m,v+n)为8x8内的元素
                      if j+n > width
                          break;
                      end
                      sum = 0;
                      for u = 0:7
                        for v = 0:7
                            Cu = 1;
                            Cv = 1;
                            if u==0
                              Cu = 0.5^0.5;
                            end
                            if v==0
                              Cv = 0.5^0.5;
                            end
                            f = 0;  % 溢出部分取0
                            if m+u<=height && n+v<=width
                                f = origin(m+u,n+v,d);
                            end
                            sum = sum+Cu*Cv*cos((2*i+1)*u*pi/16)*cos((2*j+1)*v*pi/16)*f/4;
                        end
                      end
                      target(m+i, n+j,d) = sum;
                   end
                end
            end
        end 
    end
end

