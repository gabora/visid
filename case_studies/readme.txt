The case studies can be run by executing the following MATLAB scripts:
 - main_analysis_TGFB.m,
 - main_analysis_circadian.m, or 
 - main_analysis_CHO.m

The scripts are using the calibration results of the AMIGO2 Toolbox, saved
in the case study subfolders as .mat files: tgfb, circadian and CHO, respectively.

These .mat files also contains the 'inputs' structures, which contain the 
description of the Parameter Estimation Task for AMIGO2 Toolbox. Therefore the results
of the parameter estimation can be reproduced. However, note that due to the 
stochastic nature of the global optimization method, minor differences are 
expected. 

The script generates figures and saves them in the respective folders. 
Further subfolders are created with network files. These can be importerd to 
Cytoscape.

