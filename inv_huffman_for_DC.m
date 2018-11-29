function [DC] = inv_huffman_for_DC(huffman_DC)
%  ��huffman����ָ�DCϵ��
    DC = struct('index',[]);
    for d=1:3
       decode = huffmandeco(huffman_DC(d).compress_data,huffman_DC(d).dict);
       [~,width] = size(decode);
       pos = 0;
       for i=1:width
          c = huffman_DC(d).binary(pos+1:pos+decode(i));
          neg = 0;
          if(c(1)=='-')     % '-'����ԭ����0
              DC(d).index(i) = 0;
          else
              if(c(1)=='0')  % ����������0��ͷ˵��ԭ���Ǹ���
                  for j=1:decode(i)
                     if c(j)=='1'
                        c(j)='0'; 
                     else
                        c(j)='1';
                     end
                  end
                  neg = 1;
              end
              DC(d).index(i) = bin2dec(c);
              if neg==1
                  DC(d).index(i) = -DC(d).index(i);
              end
          end
          pos = pos+decode(i);
       end
    end
end

