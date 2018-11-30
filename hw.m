img=imread('C:/Users/lenovo/Desktop/hw2/2.jpg');
imfinfo('C:/Users/lenovo/Desktop/hw2/2.jpg')

[height, width, depth] = size(img);

% JPEG压缩部分
img = RGB_to_YIQ(img);      % RGB转为YIQ

img = subsample(img);       % 4:2:0二次采样

img = DCT(img);             % DCT变换

img = quantization(img);    %量化  

AC = RLC(img);              %AC系数的游长编码

DC = DPCM(img);             %DC系数的DPCM编码

huffman_DC = huffman_for_DC(DC);       %DC系数的huffman编码

huffman_AC = huffman_for_AC(AC);       %AC系数的huffman编码

% save_jpg(huffman_AC, huffman_DC); 

% %JPEG解压缩部分
new_img = zeros(height, width, depth);

new_DC = inv_huffman_for_DC(huffman_DC);   %DC系数的huffman解码

new_AC = inv_huffman_for_AC(huffman_AC);     %AC系数的huffman解码


new_img = inv_DPCM(new_img, new_DC);    %DC系数的游长编码解码

new_img = inv_RLC(new_img, new_AC);     %AC系数的DPCM解码

new_img = un_quantization(new_img);     %反量化

new_img = IDCT(new_img);                %逆DCT变换

new_img = YIQ_to_RGB(new_img);          %YIQ转为RGB

% 失真度比较部分

% origin = imread('C:/Users/lenovo/Desktop/hw2/2.bmp');
% 
% gif = imread('C:/Users/lenovo/Desktop/hw2/2.gif');
% 
% [MSE, PSNR] = evaluate_jpeg(origin, new_img)
% 
% [MSE, PSNR] =  evaluate_gif(origin, gif)

figure,imshow(new_img);





