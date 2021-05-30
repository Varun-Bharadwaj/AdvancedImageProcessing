function f = frequency_16(vector)
%FREQUENCY   Simbols frequencies
%   For vectors, FREQUENCY_16(X) returns a [1x65536] sized double array with frequencies
%   of simbols 0-65535.
%
%   For matrices, X(:) is used as input.
%
%   Input must be of uint16 type, while the output is a double array.


%   $Author: Giuseppe Ridino' $
%   $Revision: 1.1 $  $Date: 02-Jul-2004 16:30:00 $


% ensure to handle uint16 input vector
if ~isa(vector,'uint16'),
	error('input argument must be a uint16 vector')
end

% create f
f = histc(vector(:), 0:65535); f = f(:)'/sum(f); % always make a row of it
