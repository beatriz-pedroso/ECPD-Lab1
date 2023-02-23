%% Quadratic function
%
%--------------------------------------------------------------------------

function f = P1_2func(x)
%   This function computes a quadratic function in 2 dimensions at a point
%   The argument x of the function is a 2-dimensional vector;
%   The function computes the value of a quadratic function at x.
%
%--------------------------------------------------------------------------

f = x(1)^4 - 10*x(1)^2 + x(2)^4 -10*x(2)^2;

end

%End of File