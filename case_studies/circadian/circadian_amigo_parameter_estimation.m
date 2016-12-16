% This code prepares the Circadian model's parameter estimation problem and calls AMIGO_PE
% to estimate the model parameters.

clear 
circadian_model

AMIGO_Prep(inputs)
results = AMIGO_PE(inputs);