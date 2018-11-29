function [huffman_AC] = huffman_for_AC(AC)
% 对AC系数进行huffman编码
    huffman_AC = struct();
    for d=1:3  %对一个平面的所有块统一huffman
        binary='';
        matrix = [];
        matrix_pos = 1;
        [~,AC_block_count] = size(AC(d).block);
        for i=1:AC_block_count
            [~,index_width] = size(AC(d).block(i).index);
            for j=1:index_width
                 while AC(d).block(i).index(j).RUNLENGTH > 15
                    AC(d).block(i).index(j).RUNLENGTH =  AC(d).block(i).index(j).RUNLENGTH-15;
                    symbol1='11110001';
                    symbol2='-';
                    binary=[binary, symbol2];
                    matrix(matrix_pos) = bin2dec(symbol1);
                    matrix_pos = matrix_pos+1;
                 end
                  r = dec2bin(AC(d).block(i).index(j).RUNLENGTH);
                  for k=1:4  %RunLength前面补0
                     [~,r_width] =  size(r);
                     if r_width ~= 4
                         r = ['0',r];
                     else
                        break;    
                     end
                  end
                  if AC(d).block(i).index(j).VALUE<0
                      symbol2 = dec2bin(-AC(d).block(i).index(j).VALUE);
                      [~, amplitude_width] = size(symbol2);
                      s = dec2bin(amplitude_width);
                      for k=1:amplitude_width
                         if symbol2(k)=='1'
                            symbol2(k)='0'; 
                         else
                            symbol2(k)='1';   
                         end
                      end
                  elseif AC(d).block(i).index(j).VALUE>0
                      symbol2 = dec2bin(AC(d).block(i).index(j).VALUE);
                      [~, amplitude_width] = size(symbol2);
                      s = dec2bin(amplitude_width);
                  else
                      symbol2 = '-';
                      s = '0001';
                  end
                  for k=1:4  %size前面补0
                     [~,s_width] =  size(s);
                     if s_width ~= 4
                         s = ['0',s];
                     else
                        break;    
                     end
                  end
                  symbol1 = [r,s];
                  binary=[binary, symbol2];
                  matrix(matrix_pos) = bin2dec(symbol1);
                  matrix_pos = matrix_pos+1;                  
            end
        end
        % matrix是将要进行huffman编码的symbol1数组
        pos = 1;
        p = [];
        element = [];
        [~,matrix_width] = size(matrix);
        for i=1:matrix_width
            if numel(find(element==matrix(i)))==0
                element(pos) = matrix(i);
                p(pos) = numel(find(matrix==matrix(i)))/matrix_width;
                pos = pos+1;
            end
        end
        [dict, ~] = huffmandict(element, p);
        comp = huffmanenco(matrix, dict);
        huffman_AC(d).compress_data = comp;
        huffman_AC(d).dict = dict;
        huffman_AC(d).binary = binary;        
    end
end