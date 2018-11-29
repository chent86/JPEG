function [ target ] = subsample( origin )
    [height,width,~] = size(origin); %不能少一维，否则width会不准确，可以用~来占位
    target = origin;
    for i=1:2:height
       if i==height
           break;               % 边界情况未处理（全采样）
       end
       for j =1:2:width 
           if j==width          % 边界情况未处理（全采样）
               break;
           end
           Cr = target(i,j,2);  %4:2:0中，2x2的单位中，他们有相同的(Cr,Cb),Cr取样左上角，Cb取样左下角
           Cb = target(i+1,j,3);
           target(i,j,2) = Cr;
           target(i,j,3) = Cb;
           target(i,j+1,2) = Cr;
           target(i,j+1,3) = Cb;
           target(i+1,j,2) = Cr;
           target(i+1,j,3) = Cb;
           target(i+1,j+1,2) = Cr;
           target(i+1,j+1,3) = Cb;
       end
    end
end

