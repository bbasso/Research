function sub = indtosub(siz, ndx)
%INDTOSUB Multiple subscripts from linear index.
%   Unlike the vastly inferior Matlab function, ind2sub, indtosub
%   returns a vector of subscript values - no variable output. This
%   is useful if you are calling the function in a loop with variable 
%   inputs and want the full output each time.

%   SUB = INDTOSUB is used to determine the equivalent subscript values
%   corresponding to a given single index into an array.

%   Copyright 2011 BrandonBassoWorks, Inc. 



nout = length(siz);
siz = double(siz);

if length(siz)<=nout,
  siz = [siz ones(1,nout-length(siz))];
else
  siz = [siz(1:nout-1) prod(siz(nout:end))];
end
n = length(siz);
k = [1 cumprod(siz(1:end-1))];
for i = n:-1:1,
  vi = rem(ndx-1, k(i)) + 1;         
  vj = (ndx - vi)/k(i) + 1; 
  sub(i,:) = vj;
  ndx = vi;     
end
