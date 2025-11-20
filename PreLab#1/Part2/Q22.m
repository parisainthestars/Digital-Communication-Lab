
n = 7;

K = zeros(n);

for i = 1:n 
    for j = 1:i  
        
        
        if j == 1 || j == i
            K(i, j) = 1;
        else
            
            K(i, j) = K(i-1, j-1) + K(i-1, j);
        end
    end
end


disp("Pascal's Triangle (K) for n=7:");
disp(K);