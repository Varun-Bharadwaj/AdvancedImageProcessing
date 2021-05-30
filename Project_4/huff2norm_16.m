function vector = huff2norm_16(zipped,info)
%HUFF2NORM_16   Huffman codification (decoder)
%   For vectors, HUFF2NORM_16(X,INFO) returns a decoded vector from a Huffman coded version X
%   with code words given by INFO.
%   For matrices, X(:) is used as input.
%
%   Input X must be of uint16 type, while the output is a uint16 array.
%
%   For more details about how is INFO structured, see NORM2HUFF_16 help.
%
%   See also NORM2HUFF_16


%   $Author: Giuseppe Ridino' $
%   $Revision: 1.0 $  $Date: 10-May-2004 15:03:04 $
%   modifed for uint16 by Cameron Wright on 25 Mar 2009


% ensure to handle uint16 input vector
if ~isa(zipped,'uint16'),
	error('input argument must be a uint16 vector')
end

% create the 01 sequence
len = length(zipped);
string = repmat(uint16(0),1,len.*16);
bitindex = 1:16;
for index = 1:len,
	string(bitindex+16.*(index-1)) = uint16(bitget(zipped(index),bitindex));
end
	
% adjust string
string = logical(string(:)'); % make a row of it
len = length(string);
string((len-info.pad+1):end) = []; % remove 0 padding
len = length(string);

% build output
weights = 2.^(0:51);
vector = repmat(uint16(0),1,info.length);
vectorindex = 1;
codeindex = 1;
code = 0;
for index = 1:len,
	code = bitset(code,codeindex,string(index));
	codeindex = codeindex+1;
	byte = decode(bitset(code,codeindex),info);
	if byte>0, % a code has been found
		vector(vectorindex) = byte-1;
		codeindex = 1;
		code = 0;
		vectorindex = vectorindex+1;
	end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function byte = decode(code,info)
byte = info.huffcodes(code);
