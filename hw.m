img=imread('C:/Users/lenovo/Desktop/hw2/2.jpg');
imfinfo('C:/Users/lenovo/Desktop/hw2/2.jpg')

[height, width, depth] = size(img);

% JPEGѹ������
img = RGB_to_YIQ(img);      % RGBתΪYIQ

img = subsample(img);       % 4:2:0���β���

img = DCT(img);             % DCT�任

img = quantization(img);    %����  

AC = RLC(img);              %ACϵ�����γ�����

DC = DPCM(img);             %DCϵ����DPCM����

huffman_DC = huffman_for_DC(DC);       %DCϵ����huffman����

huffman_AC = huffman_for_AC(AC);       %ACϵ����huffman����

% save_jpg(huffman_AC, huffman_DC); 

% %JPEG��ѹ������
new_img = zeros(height, width, depth);

new_DC = inv_huffman_for_DC(huffman_DC);   %DCϵ����huffman����

new_AC = inv_huffman_for_AC(huffman_AC);     %ACϵ����huffman����


new_img = inv_DPCM(new_img, new_DC);    %DCϵ�����γ��������

new_img = inv_RLC(new_img, new_AC);     %ACϵ����DPCM����

new_img = un_quantization(new_img);     %������

new_img = IDCT(new_img);                %��DCT�任

new_img = YIQ_to_RGB(new_img);          %YIQתΪRGB

% ʧ��ȱȽϲ���

% origin = imread('C:/Users/lenovo/Desktop/hw2/2.bmp');
% 
% gif = imread('C:/Users/lenovo/Desktop/hw2/2.gif');
% 
% [MSE, PSNR] = evaluate_jpeg(origin, new_img)
% 
% [MSE, PSNR] =  evaluate_gif(origin, gif)

figure,imshow(new_img);





