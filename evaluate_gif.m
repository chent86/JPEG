function [MSE, PSNR] = evaluate_gif(origin, target)
    [height, width, ~] = size(origin);
    MSE = 0;
    for i=1:height
        for j=1:width
            MSE = MSE + (double(origin(i,j,1))*0.299+double(origin(i,j,2))*0.587+double(origin(i,j,3))*0.114-double(target(i,j)))^2;
        end
    end
    MSE = double(MSE);
    MSE = MSE /(height*width);
    PSNR = 10*log((255*255)/MSE);
end

