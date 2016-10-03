function [i,j] = grid_idx2ij(s,n)

i = mod(s-1,n)+1;

j = floor((s-1)/n)+1;

