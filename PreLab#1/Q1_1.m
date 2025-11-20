
format long;

fractions = [10583/4000, 2024/765, 2709/1024];
val_sqrt7 = sqrt(7);

disp('Value of sqrt(7):');
disp(val_sqrt7);
disp('Values of fractions:');
disp(fractions);

% 2. Find the best approximation programmatically using min()
differences = abs(fractions - val_sqrt7);

[min_diff, index] = min(differences);

best_fraction = fractions(index);
fprintf('The best approximation is %f, which is the fraction at index %d.\n', best_fraction, index);