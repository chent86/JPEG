function [huffman_DC] = huffman_for_DC(DC)
% 对DC系数进行huffman编码
    huffman_DC = struct();
    for d=1:3
        binary = '';
        matrix = cell2mat(struct2cell(DC(d)));  % 转为矩阵，方便使用find
        [~,DC_width] = size(matrix);
        for i=1:DC_width
            if matrix(i) < 0
               matrix(i) = -matrix(i);
               neg = dec2bin(matrix(i));
               [~,neg_width] = size(neg);
               for k=1:neg_width
                  if neg(k)=='1'
                     neg(k)='0' ;
                  else
                     neg(k)='1';
                  end
               end
               binary = [binary,neg];
            elseif matrix(i) > 0
                binary = [binary,dec2bin(matrix(i))];
            else
                binary = [binary,'-'];  % 等于0时用'-'表示，否则会与-1冲突
            end
            [~, string_length] = size(dec2bin(matrix(i)));
            matrix(i)=string_length;
        end
        pos = 1;
        p = [];
        element = [];
        for i=1:DC_width
            if numel(find(element==matrix(i)))==0
                element(pos) = matrix(i);
                p(pos) = numel(find(matrix==matrix(i)))/DC_width;
                pos = pos+1;
            end
        end
        [dict, ~] = huffmandict(element, p);
        comp = huffmanenco(matrix, dict);
        huffman_DC(d).compress_data = comp;
        huffman_DC(d).dict = dict;
        huffman_DC(d).binary = binary;
    end
end