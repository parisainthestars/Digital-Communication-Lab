
n = 500;


[I, J] = meshgrid(1:n);

A = 1 ./ (I + J - 1);


eigenvalues = eig(A);

largest_eigenvalue = max(eigenvalues);

disp(largest_eigenvalue);