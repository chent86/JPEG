function [] = save_jpg(huffman_AC, huffman_DC)
%将JPEG压缩后的数据保存到文件
    fid = fopen('C:/Users/lenovo/Desktop/hw2/1','w');
    binary='';
    for d =1:3
        [~,width] = size(huffman_AC(d).compress_data);
        for j=1:width
           binary = [binary, num2str(huffman_AC(d).compress_data(j))];
        end
        [~,width] = size(huffman_DC(d).compress_data);
        for j=1:width
           binary = [binary, num2str(huffman_DC(d).compress_data(j))];
        end
        [height,~] = size(huffman_AC(d).dict);
        for j=1:height
           m = cell2mat(huffman_AC(d).dict(j,2));
           [~,width] = size(m);
           for k=1:width
               binary = [binary, num2str(m(k))];
           end
        end
        [height,~] = size(huffman_DC(d).dict);
        for j=1:height
           m = cell2mat(huffman_DC(d).dict(j,2));
           [~,width] = size(m);
           for k=1:width
               binary = [binary, num2str(m(k))];
           end
        end
        [~,width] = size(huffman_DC(d).binary);
        for j=1:width
           if  huffman_DC(d).binary(j)=='-'
              huffman_DC(d).binary(j)='0'; 
           end
        end
        [~,width] = size(huffman_AC(d).binary);
        for j=1:width
           if  huffman_AC(d).binary(j)=='-'
              huffman_AC(d).binary(j)='0'; 
           end
        end
        binary = [binary, huffman_DC(d).binary, huffman_AC(d).binary];
    end
    result = '';
    [~,width] = size(binary);
    add = 4-mod(width,4);
    for i=1:add
       binary = [binary,'0']; 
    end
    for i=1:4:width
        result = [result, dec2hex(bin2dec(binary(i:i+3)))];
    end
    fprintf(fid,'%s',result);
    fclose(fid);
end

