% img=imread('C:/Users/lenovo/Desktop/hw/1.jpg');
% imfinfo('C:/Users/lenovo/Desktop/hw/1.jpg')
% 
% [height, width, depth] = size(img);
% 
% img = RGB_to_YIQ(img);      % RGBתΪYIQ
% 
% img = subsample(img);       % 4:2:0���β���
% 
% img = DCT(img);             % DCT�任
% 
% img = quantization(img);    %����  
% 
% AC = RLC(img);              %ACϵ�����γ�����
% 
% DC = DPCM(img);             %DCϵ����DPCM����



% img = zeros(height, width, depth);
% 
% img = inv_DPCM(img, DC);    %DCϵ�����γ��������
% 
% img = inv_RLC(img, AC);     %ACϵ����DPCM����
% 
% img = un_quantization(img);
% 
% img = IDCT(img);
% 
% img = YIQ_to_RGB(img);
% 
% figure,imshow(img);

