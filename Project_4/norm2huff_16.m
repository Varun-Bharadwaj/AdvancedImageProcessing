function [zipped,info] = norm2huff_16(vector)
%NORM2HUFF_16   Huffman codification (encoder)
%   For vectors, NORM2HUFF_16(X) returns a Huffman coded version of the input vector.
%   For matrices, X(:) is used as input.
%
%   Input must be of uint16 type, while the output is a uint16 array.
%
%   [...,INFO] = ... returns also a structure with data required to convert it back
%   to normal vector:
%
%      INFO.pad        = eventually added bits at the end of bit sequence;
%      INFO.huffcodes  = Huffman codewords;
%      INFO.ratio      = compression ratio;
%      INFO.length     = original data length;
%      INFO.maxcodelen = max codeword length;
%
%   Codewords are stored in the 52 available bits of a double. To avoid anbiguities,
%   after the last codeword bit, a "1" bit is added to terminate the codeword.
%   I.e. the max codeword length can be 51 bits.
%
%   See also HUFF2NORM_16


%   $Author: Giuseppe Ridino' $
%   $Revision: 1.0 $  $Date: 10-May-2004 15:03:04 $
%   modifed for uint16 by Cameron Wright on 25 Mar 2009


% ensure to handle uint16 input vector
% if ~isa(vector,'uint16')
% 	error('input argument must be a uint16 vector')
% end

% vector as a row
vector = vector(:)';

% frequency
f = frequency_16(vector);

% simbols presents in the vector are
simbols = find(f~=0); % first value is 1 not 0!!!
f = f(simbols);

% sort using the frequency
[f,sortindex] = sort(f);
simbols = simbols(sortindex);

% generate the codewords as the 52 bits of a double
len = length(simbols);
simbols_index = num2cell(1:len);
codeword_tmp = cell(len,1);
while length(f)>1,
	index1 = simbols_index{1};
	index2 = simbols_index{2};
	codeword_tmp(index1) = addnode(codeword_tmp(index1),uint8(0));
	codeword_tmp(index2) = addnode(codeword_tmp(index2),uint8(1));
	f = [sum(f(1:2)) f(3:end)];
	simbols_index = [{[index1 index2]} simbols_index(3:end)];
	% resort data in order to have the two nodes with lower frequency as first two
	[f,sortindex] = sort(f);
	simbols_index = simbols_index(sortindex);
end

% arrange cell array to have correspondance simbol <-> codeword
codeword = cell(65536,1);
codeword(simbols) = codeword_tmp;

% calculate full string length
len = 0;
for index=1:length(vector),
	len = len+length(codeword{double(vector(index))+1});
end
	
% create the full 01 sequence
string = repmat(uint16(0),1,len);
pointer = 1;
for index=1:length(vector),
	code = codeword{double(vector(index))+1};
	len = length(code);
	string(pointer+(0:len-1)) = code;
	pointer = pointer+len;
end

% calculate if it is necessary to add padding zeros
len = length(string);
pad = 16-mod(len,16);
if pad>0,
	string = [string uint16(zeros(1,pad))];
end

% now save only usefull codewords
codeword = codeword(simbols);
codelen = zeros(size(codeword));
weights = 2.^(0:51);
maxcodelen = 0;
for index = 1:length(codeword),
	len = length(codeword{index});
	if len>maxcodelen,
		maxcodelen = len;
	end
	if len>0,
		code = sum(weights(codeword{index}==1));
		code = bitset(code,len+1);
		codeword{index} = code;
		codelen(index) = len;
	end
end
codeword = [codeword{:}];

% calculate zipped vector
cols = length(string)/16;
string = reshape(string,16,cols);
weights = 2.^(0:15);
zipped = uint16(weights*double(string));

% store data into a sparse matrix
huffcodes = sparse(1,1); % init sparse matrix
for index = 1:numel(codeword),
	huffcodes(codeword(index),1) = simbols(index);
end

% create info structure
info.pad = pad;
info.huffcodes = huffcodes;
info.ratio = cols./length(vector);
info.length = length(vector);
info.maxcodelen = maxcodelen;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function codeword_new = addnode(codeword_old,item)
codeword_new = cell(size(codeword_old));
for index = 1:length(codeword_old),
	codeword_new{index} = [item codeword_old{index}];
end
