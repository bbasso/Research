function [kex, ptype] = generate_kanerva_examples(nEx, noise_flag)

dir = 'C:\Users\Brandon\Documents\MATLAB\Research\common';
if strcmp(dir,pwd) ~= 1
    cd(dir)
    pwd
end


% Generates 'nEx' kanerva examples of 'bits'. By convention, we choose the 
% first 8 bits to be relevant and the odd bits to be irrelevant.

% Generate random examples with 16 bits
bits = 16;
pnoise = .05;
bf_counter = 0;                                                                   
kex.values  = randint(nEx,bits);
np = 8;
% Prototypes - Statically defined
ptype.values(1,:) = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
ptype.values(2,:) = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0];
ptype.values(3,:) = [0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1];
ptype.values(4,:) = [1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0];
ptype.values(5,:) = [0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1];
ptype.values(6,:) = [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0];
ptype.values(7,:) = [0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1];
ptype.values(8,:) = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
ptype.labels(1) = 0;
ptype.labels(2) = 1;
ptype.labels(3) = 0;
ptype.labels(4) = 1;
ptype.labels(5) = 0;
ptype.labels(6) = 1;
ptype.labels(7) = 0;
ptype.labels(8) = 1;

% Compute distance between each prototype and each example
% D is m x n where the rows are examples and colums are protypes. For
% example, D(1,2) is the distance between example 1 and prototype 2.
% Only the first 8 bits are relevant by assumption (n goes from 1:bits/2)
for m = 1:nEx
    for n = 1:size(ptype.values,1)
        D(m,n) = pdist([kex.values(m,1:bits/2);ptype.values(n,1:bits/2)],'hamming');
    end
end

% Choose index of smallest distance
[Y,I]=min(D,[],2);

% Assign labels to examples based on hamming distance from prototypes
% Ties broken according to arbitrary ordering of prototypes above
for m = 1:nEx
    kex.labels(m) = ptype.labels(I(m));
    if noise_flag
        if (rand < pnoise)
            kex.labels(m) = ~kex.labels(m);
            bf_counter = bf_counter + 1;
        end
    end
end

kex.labels = kex.labels';
kex.nex = nEx;
kex.bits = bits;


disp(['Generated ',num2str(nEx),' ',num2str(bits),'-bit kanerva examples and ',num2str(np),' prototypes'])
if noise_flag
    disp(['Kanerva Examples: Class label flipped on ',num2str(bf_counter/nEx*100),'% of examples']);
end

% Find labels for random examples based on hamming distance from prototypes

