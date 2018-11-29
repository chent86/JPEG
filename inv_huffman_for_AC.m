function [AC] = inv_huffman_for_AC(huffman_AC)
%  ��huffman����ָ�ACϵ��
    AC = struct('block',struct('index',struct([])));
    for d=1:3
        decode = huffmandeco(huffman_AC(d).compress_data,huffman_AC(d).dict);
        [~,width] = size(decode);
        pos = 0;       % ��ǰ��ȡ���Ķ�������λ��
        block_id = 1;  % ���
        block_pos = 1; % ���ڵ����
        for i=1:width
            bin = dec2bin(decode(i));
            for j=1:8  %ǰ�油0
                 [~,bin_width] =  size(bin);
                 if bin_width ~= 8
                     bin = ['0',bin];
                 else
                    break;    
                 end                
            end
            r = bin2dec(bin(1:4));
            s = bin2dec(bin(5:8));
            amp = huffman_AC(d).binary(pos+1:pos+s);
            pos = pos+s;
            if r==0
               AC(d).block(block_id).index(block_pos).RUNLENGTH=0;
               if amp(1)=='-'  % ����(0,0),��ʾһ�������
                  AC(d).block(block_id).index(block_pos).VALUE=0;
                  block_id = block_id+1;
                  block_pos = 1;
               else
                  if amp(1)=='0' % ����
                      for j=1:s
                         if amp(j)=='1'
                            amp(j)='0'; 
                         else
                             amp(j)='1';
                         end
                      end
                      AC(d).block(block_id).index(block_pos).VALUE = -1*bin2dec(amp);
                  else
                      AC(d).block(block_id).index(block_pos).VALUE = bin2dec(amp);
                  end
                  block_pos = block_pos+1;
               end
            else
               AC(d).block(block_id).index(block_pos).RUNLENGTH=r;
               if amp(1)=='-'  % valueΪ0
                  AC(d).block(block_id).index(block_pos).VALUE=0;
               else
                  if amp(1)=='0' % ����
                      for j=1:s
                         if amp(j)=='1'
                            amp(j)='0'; 
                         else
                             amp(j)='1';
                         end
                      end
                      AC(d).block(block_id).index(block_pos).VALUE = -1*bin2dec(amp);
                  else
                      AC(d).block(block_id).index(block_pos).VALUE = bin2dec(amp);
                  end
               end
               block_pos = block_pos+1;                
            end
        end
    end
end

