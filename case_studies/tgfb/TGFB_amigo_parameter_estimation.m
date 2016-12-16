% This code prepares the TGFB parameter estimation problem and calls AMIGO_PE
% to estimate the model parameters.

clear 
TGFB_amigo

AMIGO_Prep(inputs)
results = AMIGO_PE(inputs);