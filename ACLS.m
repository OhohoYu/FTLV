
function [W,H] = ACLS()
    %Here we use alternating constrained least squares to decompose the nxm
    %matrix V into a nxk matrix W and a kxm matrix H. 
    %The concept is to minimize the euclidean error: 
    %||V-WH||^2 = sigma(Vij - (WH)ij)2
    
    %we will alternate between linear squares solves of W and H:
    %x = lsqlin(C,d,A,b)solves the linear system C*x = d in the 
    %least-squares sense, subject to A*x ? b.
    
    % set up paths to VLFeat functions. 
    % See http://www.vlfeat.org/matlab/matlab.html for VLFeat Matlab documentation
    % This should work on 32 and 64 bit versions of Windows, MacOS, and Linux
        run('/Users/elisecotton/vlfeat-0.9.19/toolbox/vl_setup')
        
    %load('imagematrix.mat', 'images');
    %V = images;
    V = randi( [0 256], 100, 500);
    k = 2; %k is between 1 and 5
    
    [W,H] = initializeACLS(V,k);

end

function [W,H] = initializeACLS(V,k)
    %initialization:
    % first, run k-means clustering with k = 20. then, populate our W and H
    % matrices with random cluster centers 
    vocab_size = 20;
    
    [n,m] = size(V);
    
    [centers, assignments] = vl_kmeans(single(V), vocab_size);
    size(centers)
    
    centers_vector = reshape(centers,1,numel(centers));

    W = reshape(datasample(centers_vector,(n*k)), n, k);
    H = reshape(datasample(centers_vector, k*m),k,m);
end 