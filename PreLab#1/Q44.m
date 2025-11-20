
vec = randi([10, 30], 1, 20);
disp('Original Vector:');
disp(vec);

iteration_count = 0;

while any(mod(vec, 2) == 1)
    
    
    odd_indices = (mod(vec, 2) == 1);
    
    num_to_replace = sum(odd_indices);
    
    new_numbers = randi([10, 30], 1, num_to_replace);
    
    vec(odd_indices) = new_numbers;
    
    iteration_count = iteration_count + 1;
end

disp('Final All-Even Vector:');
disp(vec);

final_message = sprintf('The Vector Generated After %d Iteration(s).', iteration_count);
disp(final_message);