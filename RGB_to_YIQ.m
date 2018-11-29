function [ YIQ ] = RGB_to_YIQ(RGB)

YIQ_matrix = [0.299, 0.587, 0.144;
    0.595879 -0.274133 -0.321746;
    0.211205 -0.523083 0.311878];

% YUV_matrix = [0.299, 0.587, 0.144;
%               -0.299, -0.587, 0.886;
%               0.701, -0.587, -0.144];

    [height, width, deepth] = size(RGB);
    YIQ = zeros(height, width, deepth);
    tmp = zeros(3,1);
    for i=1:height
       for j = 1:width
          tmp(1,1) = RGB(i,j,1);
          tmp(2,1) = RGB(i,j,2);
          tmp(3,1) = RGB(i,j,3);
          tmp = YIQ_matrix*tmp;
          YIQ(i,j,1) = tmp(1,1);
          YIQ(i,j,2) = tmp(2,1);
          YIQ(i,j,3) = tmp(3,1);
       end
    end
end

