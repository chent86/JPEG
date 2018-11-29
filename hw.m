img=imread('C:/Users/lenovo/Desktop/hw/2.jpg');
imfinfo('C:/Users/lenovo/Desktop/hw/2.jpg')

[height, width, depth] = size(img);

img = RGB_to_YIQ(img);      % RGB转为YIQ

img = subsample(img);       % 4:2:0二次采样

img = DCT(img);             % DCT变换

img = quantization(img);    %量化  

AC = RLC(img);              %AC系数的游长编码

DC = DPCM(img);             %DC系数的DPCM编码

% huffman_DC = huffman_for_DC(DC);       %DC系数的huffman编码
% 
% DC = inv_huffman_for_DC(huffman_DC);   %DC系数的huffman解码

huffman_AC = huffman_for_AC(AC);       %AC系数的huffman编码

% img = zeros(height, width, depth);
% 
% img = inv_DPCM(img, DC);    %DC系数的游长编码解码
% 
% img = inv_RLC(img, AC);     %AC系数的DPCM解码
% 
% img = un_quantization(img);
% 
% img = IDCT(img);
% 
% img = YIQ_to_RGB(img);
% 
% figure,imshow(img);



