clc;

disp('Approximate value of 330! (scientific notation):');
format short e;
approx_fact = factorial(330);
disp(approx_fact);

disp(' ');
disp('Exact value of 330! using VPA:');
format short;

% 1. Convert the string expression to a symbolic object
symbolic_expression = str2sym('factorial(330)');

% 2. Use VPA on the symbolic object to calculate to 700 digits of precision
exact_fact = vpa(symbolic_expression, 700);

disp(exact_fact);