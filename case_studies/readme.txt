The case studies can be run by executing the following MATLAB scripts:
 - main_analysis_TGFB.m,
 - main_analysis_circadian.m, or 
 - main_analysis_B4.m

The scripts are using the calibration results of the AMIGO2 Toolbox, saved
in the case study subfolders as .mat files: tgfb, circadian and B4, respectively.

These .mat files also contains the 'inputs' structures, which contain the 
description of the Parameter Estimation Task for AMIGO2 Toolbox. Therefore the results
of the parameter estimation can be reproduced. However, note that due to the 
stochastic nature of the global optimization method, minor differences are 
expected. 

The script generates figures and saves them in the case study folders. 
Further subfolders are created with network files. These can be importerd to 
Cytoscape to visualize the highly collinear groups:
 - *.sif files encodes the structure of the network
 - *node_table.txt files contain the descritpion of the nodes and they have
                   to be imported to Cytoscape as node tables
 - *edgeTable.txt files contains the description of the edges (collinearity index 
                   based weights) and have to be included as edge tables in Cytoscape. 



*****************
Visualize Influence network and parameter identifiability in Cytoscape:
 
 - run the main analysis MATLAB script, which create the neccessary files in the problem/cytoscape subfolder (already generated for the examples).
 - start Cytoscape 
 - import style-file from visid/code: Visid_Cytoscape_StyleFile.xml and select NetworkStructure_parID style from the styles. 
 - import network_network.sif: contains the influence graph between parameters, states and observables
 - import network_node_table.txt: description of the nodes
 
 *****************
 Visualize Correlated Group of Parameters in Cytoscape:
 
 - run the main analysis MATLAB script, which create the neccessary files in the problem/cytoscape subfolder (already generated for the examples).
 - start Cytoscape 
 - import style-file from visid/code: Visid_Cytoscape_StyleFile.xml and select HCGrps style from the styles. 
 - import hcgrps_HCI.sif: contains the parameters and the group labels as nodes
 - import hcgrps_HCI_edgeTabl.txt and hcgrps_HCI_nodeTable.txt as edge table and node table, respectively.
