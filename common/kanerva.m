function kout = kanerva(sample, training, group, LTUs )

% Kanerva Coding Classifier
% Brandon Basso, June 2011

% Takes inputs similar to knnclassify.m.  If the training data is
% unspecified outside of the function, set 'training' to a scalar. Kanerva
% will generate 'training' # of examples with generate_kanerva_examples(),
% which also specifies the class labels based on hardcoded prototypes.

dir = 'C:\Users\Brandon\Documents\MATLAB\Research\common';
if strcmp(dir,pwd) ~= 1
    cd(dir)
    pwd
end

% clear all
% training = 5000;
% sample = 5000;
% LTUs = 25;
%% Grab data
disp('Setup...')
% If no training data is specified
if isnumeric(training)
    examples = generate_kanerva_examples(training,1);
    training = examples.values;
    group = examples.labels;
else
    examples = training;
    training = examples.values;
    group = examples.labels;
end

%% Setup learning network
M = LTUs;               % number of (random) linear threshold units
N = examples.bits;      % num bits
Beta = .6;              % bit match proportion
V = randint(M,N,-2);    % V is a random MxN matrix of -1 or 1 values, wep
Smin = sum(V,2);        % Smin is min possible value for jth unit's weighted sum
V(find(V==0))=1;        % replace zeros with ones - V is now a rand matrix of 1, -1
theta = Beta*N + Smin;  % taken from paper, not sure on the 'N' multiplication
w = zeros(1,M+1);       % init weight vector, to be learned
w(1) = 0;               % 0th weight acts as a bias
alpha = 1;              % learning rate


%% Loop over all examples to learn weights
disp('Learning...')
close all
clear x fstar h y nA p delta_w f nc nnc ncorrect corrent_nc pcorrect
nc = 0;                 % number of correct counter
nnc = 0;
counter = [0,0];
ncorrect = zeros(examples.nex,1);

for i = 1:examples.nex
    x = training(i,:)';  % training data
    fstar = group(i);   % class label
    h = V*x;            % weighted sum of hidden units
    y = h > theta;      % thresholded output of hidden units
    y = [1;y];          % 0th input (1st entry in matlab), acts as bias, always set to 1
    nA = sum(y.^2);     % number of active hidden units   
    p = 1/(1+exp(-w*y));    % estimated prob that fstar = 1
    delta_w = alpha/nA*(fstar-p)*y';
    w = w + delta_w;
    f = w*y > 0;
    if f==fstar
        nc = nc + 1;
        nnc = nnc + 1;
    end
    ncorrect(i) = nc;
    current_nc = [i,nnc];
    pcorrect(i) = nc/i;
    if (mod(i,examples.nex/100)==0)
        counter = [counter;current_nc];
        nnc = 0;
    end
end

plot(counter(:,1),counter(:,2)./(examples.nex/100))
xlabel('Example number')
ylabel('Percent correct')
title('Kanerva Coding :: Learning')
%% Validation
disp('Validating...')
clear nc nnc ncorrect pcorrect counter
close all
if isnumeric(sample)
    validation = generate_kanerva_examples(sample,1);
else
    validation = sample;
end

nc = 0;
nnc = 0;
counter = [0,0];
ncorrect = zeros(validation.nex,1);

for i = 1:validation.nex
    x = validation.values(i,:)';
    fstar = validation.labels(i);   % class label - used to count num correct
    h = V*x;            % weighted sum of hidden units
    y = h > theta;      % thresholded output of hidden units
    y = [1;y];          % 0th input (1st entry in matlab), acts as bias, always set to 1
    nA = sum(y.^2);     % number of active hidden units   
    f = w*y > 0;         % weights nearned in previous cell
    if f==fstar
        nc = nc + 1;
%         nnc = nnc + 1;
    end
%     ncorrect(i) = nc;
%     current_nc = [i,nnc];
%     pcorrect(i) = nc/i;
%     if (mod(i,examples.nex/100)==0)
%         counter = [counter;current_nc];
%         nnc = 0;
%     end
end
kanerva_pcorrect = nc/validation.nex*100;

% compare with knn classification
k1=1;
k2=3;
knn1.labels = knnclassify(validation.values,examples.values,examples.labels, k1, 'hamming','nearest');
knn1_pcorrect = sum(knn1.labels==validation.labels)/validation.nex*100;
knn2.labels = knnclassify(validation.values,examples.values,examples.labels, k2, 'hamming','nearest');
knn2_pcorrect = sum(knn2.labels==validation.labels)/validation.nex*100;

% Output stats
disp(['Training on ',num2str(examples.nex),' examples, Kanerva ',num2str(M),' got ',num2str(kanerva_pcorrect),'% right out of ', num2str(validation.nex),' validation examples'])
disp(['Training on ',num2str(examples.nex),' examples, KNN ',num2str(k1),' got ',num2str(knn1_pcorrect),'% right out of ', num2str(validation.nex),' validation examples'])
disp(['Training on ',num2str(examples.nex),' examples, KNN ',num2str(k2),' got ',num2str(knn2_pcorrect),'% right out of ', num2str(validation.nex),' validation examples'])

kout = [kanerva_pcorrect, knn1_pcorrect, knn2_pcorrect];
