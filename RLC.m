function [AC] = RLC(origin)
%��ACϵ�������γ�����
    AC = struct('block',struct('index',struct([])));
    [height,width,depth] = size(origin);
    % z��ɨ���˳��
    order = [ 0  1  5  6  14 15 27 28
         2  4  7  13 16 26 29 42
         3  8  12 17 25 30 41 43
         9  11 18 24 31 40 44 53
         10 19 23 32 39 45 52 54
         20 22 33 38 46 51 55 60
         21 34 37 47 50 56 59 61
         35 36 48 49 57 58 62 63];
    for d=1:depth
        block_index = 0;
        for m=1:8:height
            for n=1:8:width  %(m,n)Ϊ8x8�����Ͻ�Ԫ��
                block = zeros(8,8);
                block_index = block_index+1;
                for u=0:7
                   if u+m > height
                      break; 
                   end
                   for v=0:7  % (u+m,v+n)Ϊ8x8�ڵ�Ԫ��
                      if v+n > width
                          break;
                      end
                      block(u+1,v+1)=origin(u+m,v+n,d);
                   end
                end
                % �õ�z��ɨ��Ľ��
                list = sortrows([reshape(block,[],1) reshape(order,[],1)],2);
                [height1,~] = size(list);
                
                %�γ����벿��
                flag = 0; % ��¼�Ƿ���0, 0����ǰû�м�⵽0
                pos = 1;  % ��¼��ǰ�����ͷ(��������ֵ)
                reg = 0;  %��¼0�ĳ���
                for i=2:height1 %��DCϵ��������
                   if flag == 0
                       if list(i,1)~=0
                           AC(d).block(block_index).index(pos).RUNLENGTH = 0;
                           AC(d).block(block_index).index(pos).VALUE = list(i,1);
                           pos = pos+1;
                       else
                          flag = 1; 
                          reg = 1;
                       end
                   else
                       if list(i,1)~=0
                           AC(d).block(block_index).index(pos).RUNLENGTH = reg;
                           AC(d).block(block_index).index(pos).VALUE = list(i,1);
                           pos = pos+1;
                           reg=0;
                           flag=0;
                       else
                           reg=reg+1;
                       end
                   end
                end
%                 if flag == 1  % �����(0,0)   %���һ��Ҫ����(0,0)��ʾ������ϣ����ں����ж�
                    AC(d).block(block_index).index(pos).RUNLENGTH = 0;
                    AC(d).block(block_index).index(pos).VALUE = 0;
%                 end
            end
        end
    end
end

