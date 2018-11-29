function [target] = IDCT( origin ) % ��DCT��ʽ���ƣ�Ȼ��������ʵ���н϶����
    [height,width,depth] = size(origin);
    target = zeros(height,width,depth);
    for d=1:depth
        for m=1:8:height
            for n=1:8:width  %(m,n)Ϊ8x8�����Ͻ�Ԫ��
                for i=0:7
                   if i+m > height
                      break; 
                   end
                   for j=0:7  % (u+m,v+n)Ϊ8x8�ڵ�Ԫ��
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
                            f = 0;  % �������ȡ0
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

