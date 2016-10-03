% Run Kanerva
% Calls kanerva.m

%%
clear all
% Select range or LTUs to use
LTUs = round(linspace(10,500,10));
% number of training examples to generate
ntraining = 5000;
training = generate_kanerva_examples(ntraining,1);
% number of validation examples to generate
nsample = 5000;
sample = generate_kanerva_examples(nsample,1);
% Unimplemented
group = 1;

for i = 1:length(LTUs)
    kout(i,:) = kanerva(sample, training, group, LTUs(i))
end

plot(LTUs,kout(:,1),LTUs,kout(:,2),LTUs,kout(:,3))
xlabel('Hidden Kanerva Units')
ylabel('Percent correct')
title('Kanerva Coding v. KNN classification')
legend('Kanerva','KNN-1','KNN-3')