function [MSE, PSNR] = evaluate_jpeg(origin, target)
    [height, width, depth] = size(origin);
    MSE = 0;
    for d=1:depth
        for i=1:height
            for j=1:width
                MSE = MSE + (double(origin(i,j,d))-double(target(i,j,d)))^2;
            end
        end
    end
    MSE = double(MSE);
    MSE = MSE /(height*width);
    PSNR = 10*log((255*255)/MSE);
end

