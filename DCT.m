function [target] = DCT( origin )
    [height,width,depth] = size(origin);
    target = zeros(height,width,depth);
    for d=1:depth
        for m=1:8:height
            for n=1:8:width  %(m,n)Ϊ8x8�����Ͻ�Ԫ��
                for u=0:7
                   if u+m > height
                      break; 
                   end
                   for v=0:7  % (u+m,v+n)Ϊ8x8�ڵ�Ԫ��
                      if v+n > width
                          break;
                      end
                      Cu = 1;
                      Cv = 1;
                      if u==0
                          Cu = 0.5^0.5;
                      end
                      if v==0
                          Cv = 0.5^0.5;
                      end
                      sum = 0;
                      for i = 0:7
                        for j = 0:7
                            f = 0;  % �������ȡ0
                            if m+i<=height && n+j<=width
                                f = origin(m+i,n+j,d);
                            end
                            sum = sum+cos((2*i+1)*u*pi/16)*cos((2*j+1)*v*pi/16)*f;
                        end
                      end
                      target(m+u, n+v,d) = Cu*Cv*sum/4;
                   end
                end
            end
        end 
    end
end

