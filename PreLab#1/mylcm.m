function result = mylcm(varargin)

    if nargin == 0
        error('At least one input argument is required.');
    end
    numbers = [varargin{:}];

    is_not_positive = any(numbers <= 0);
    is_not_integer = any(numbers ~= floor(numbers));

    if is_not_positive || is_not_integer
        error('All inputs must be positive integers.');
    end

    
    if length(numbers) == 1
        result = numbers(1);
        return;
    end
    
    current_lcm = lcm(numbers(1), numbers(2));
    
    for i = 3:length(numbers)
        current_lcm = lcm(current_lcm, numbers(i));
    end
    
    result = current_lcm;
end