% This code prepares the B4 parameter estimation problem and calls AMIGO_PE
% to estimate the model parameters.

clear inputs
B4_amigo_nl2sol

AMIGO_Prep(inputs)
results = AMIGO_PE(inputs);