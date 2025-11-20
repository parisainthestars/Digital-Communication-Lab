% --- Test script for the mylcm.m function ---
clear;
clc;

disp('--- Testing mylcm.m function ---');

%% --- 1. Testing with valid inputs ---
disp(' ');
disp('--> Testing VALID inputs...');

% Test case 1: Separate arguments (from prompt)
lcm1 = mylcm(4, 5, 6);
fprintf('Test 1: mylcm(4, 5, 6) -> Expected: 60, Got: %d\n', lcm1);

% Test case 2: Single vector input (from prompt)
lcm2 = mylcm([4, 5, 6]);
fprintf('Test 2: mylcm([4, 5, 6]) -> Expected: 60, Got: %d\n', lcm2);

% Test case 3: Two arguments
lcm3 = mylcm(12, 18);
fprintf('Test 3: mylcm(12, 18) -> Expected: 36, Got: %d\n', lcm3);

% Test case 4: Edge case with a single number
lcm4 = mylcm(23);
fprintf('Test 4: mylcm(23) -> Expected: 23, Got: %d\n', lcm4);

%% --- 2. Testing error handling for invalid inputs ---
disp(' ');
disp('--> Testing INVALID inputs (expecting errors)...');

% Test case 5: Input includes a negative number
try
    mylcm(5, -10, 15);
catch ME
    fprintf('Test 5: mylcm(5, -10, 15) -> Successfully caught error: %s\n', ME.message);
end

% Test case 6: Input includes a non-integer
try
    mylcm(4, 2.5);
catch ME
    fprintf('Test 6: mylcm(4, 2.5) -> Successfully caught error: %s\n', ME.message);
end

% Test case 7: Input includes zero
try
    mylcm([7, 0, 14]);
catch ME
    fprintf('Test 7: mylcm([7, 0, 14]) -> Successfully caught error: %s\n', ME.message);
end

% Test case 8: No inputs
try
    mylcm();
catch ME
    fprintf('Test 8: mylcm() -> Successfully caught error: %s\n', ME.message);
end

disp(' ');
disp('--- Testing complete. ---');