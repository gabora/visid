# Visualization of Identifiability Problems in Dynamic Biochemical Models 
MATLAB Toolbox  
author: Attila Gabor <gabor.attila87@gmail.com>



### paper describing the tool with examples:  
-  Attila Gábor, Alejandro F. Villaverde, and Julio R. Banga. (2017) [Parameter identifiability analysis and visualization in large-scale kinetic models of biosystems.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5420165/) _BMC Syst Biol._ 2017; 11: 54.



## INSTALLATION

The VisId toolbox relies on the following 3 MATLAB Toolboxes:

1.   AMIGO2 (https://sites.google.com/site/amigo2toolbox/download) is used to  
  to build, simulate and calibrate the models using measurement data. Further, it implements symbolic
  computation of the Jacobian matrices that we use to compute the relationship between model parameters.

2.  MEIGO (https://sites.google.com/site/amigo2toolbox/download). This toolbox  
  contains an implementation for the Variable Neighbouring Search (VNS) integer
  optimization method. 

3. RRQR (optional) (http://www.mathworks.com/matlabcentral/fileexchange/18591-rank-revealing-qr-factorization)  
 rank revealing QR decomposition is used to find the largest identifiable subsets of parameters.

These toolboxes must be installed in order to have a working version of VisID.

The MATLAB scripts produce network files, which describe (1) the relationship among the non-identifiable model parameters and (2) relationship among the parameters and model variables. These network files can be visualized by importing to CytoScape: An open platform for network analysis (http://www.cytoscape.org/).


## INSTRUCTIONS

1. please, install required toolboxes
2. install VisID using installVisID.m from the main directory: this will add visid to the MATLAB path.
3. run case studies (main_analysis***.m) in the case_studies folder: this scripts load the parameter estimation results from the case-study related subfolders and conduct the identifiability analysis. It further produces network files in the  case_studies/#problemName#/cytoscape folder.
4. import the networks from the case_studies/#problemName#/cytoscape folder to CytoScape. Please find further details in the case_studies/readme.txt


## Issues, bugs and features
Please use the [Issue page](https://github.com/gabora/visid/issues)  to report any problem or bug. 


## DISCLAIMER

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.
    
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See the GNU General Public License for more details.
 
You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

