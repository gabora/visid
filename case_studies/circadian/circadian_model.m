

%%
% inputs
%



%%
% inputs.PEsol
%

inputs.PEsol.PEcostJac_type=	'llk';
inputs.PEsol.PEcost_type=	'llk';
inputs.PEsol.global_theta_guess=	[	      7.5038       0.6801       1.4992       3.0412      10.0982       1.9685       3.7511       2.3422       7.2482       1.8981          1.2       3.8045       5.3087       4.1946       2.5356        1.442         4.86          1.2       2.1994        9.444          0.5       0.2817       0.7676       0.4364       7.3021       4.5703            1 ];
inputs.PEsol.global_theta_max=	[	          20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20           20 ];
inputs.PEsol.global_theta_min=	[	           0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0            0 ];
inputs.PEsol.id_global_theta=	char(	'n1',...
	'n2',...
	'g1',...
	'g2',...
	'm1',...
	'm2',...
	'm3',...
	'm4',...
	'm5',...
	'm6',...
	'm7',...
	'k1',...
	'k2',...
	'k3',...
	'k4',...
	'k5',...
	'k6',...
	'k7',...
	'p1',...
	'p2',...
	'p3',...
	'r1',...
	'r2',...
	'r3',...
	'r4',...
	'q1',...
	'q2');
inputs.PEsol.llk_type=	'homo_var';


%%
% inputs.exps
%

inputs.exps.data_type=	'real';
inputs.exps.error_data=	{ 	[	    0.037642     0.059832 
	    0.072461     0.013999 
	    0.002877     0.020809 
	    0.050324     0.002705 
	    0.042936     0.017832 
	    0.044338     0.022538 
	    0.016335     0.017981 
	    0.164745     0.035301 
	    0.010631     0.102381 
	    0.127745     0.065791 
	    0.081671     0.049568 
	    0.126739     0.050306 
	    0.006308     0.018894 
	    0.054665     0.066953 
	    0.082163     0.015295 ],
 [	    0.146016     0.018152 
	    0.066547     0.045194 
	    0.184009     0.101495 
	    0.047431     0.030858 
	     0.17528     0.033712 
	    0.031945     0.048733 
	    0.107148     0.008715 
	    0.019847     0.072804 
	    0.111892      0.00184 
	    0.104932     0.058752 
	    0.059721     0.033324 
	    0.056537      0.00036 
	    0.051815     0.037473 
	    0.103393     0.028094 
	    0.008084     0.012024 
	    0.188444     0.022982 
	    0.046354     0.031981 
	    0.043436     0.003749 
	    0.030177      0.04256 
	    0.116245     0.110535 
	    0.059345     0.025112 
	    0.218587     0.000564 
	    0.115783     0.043708 
	    0.099239     0.002678 
	    0.010644      0.05299 ]};
inputs.exps.exp_data=	{ 	[	    0.037642     0.059832 
	     1.39862     0.983442 
	     1.60676     0.433379 
	    0.265345     0.628819 
	     1.41729     0.858973 
	     1.38161     0.496637 
	    0.504584     0.717923 
	     1.24025     0.862584 
	     1.18019     0.634508 
	    0.775945     0.679648 
	     1.51451     0.735783 
	    0.904653     0.593644 
	    0.753736     0.759013 
	     1.38931     0.678665 
	    0.833228     0.574736 ],
 [	    0.146016     0.018152 
	    0.831813       1.0025 
	     1.87487     0.816779 
	     1.92758     0.544111 
	     1.13954     0.354476 
	    0.876938     0.520424 
	      0.5596     0.802322 
	     1.27355     0.939453 
	     1.69648     0.687495 
	      1.0655     0.577896 
	     0.84746     0.524076 
	     0.51752     0.738095 
	     1.16223     0.826737 
	      1.4215     0.779833 
	     1.34064     0.550493 
	    0.563822     0.515605 
	    0.402755     0.714877 
	     1.02986     0.871118 
	     1.49074     0.840174 
	     1.58087     0.692047 
	     0.69661     0.459481 
	    0.141546     0.646803 
	    0.804194     0.925806 
	     1.62238     0.824711 
	     1.52519     0.537398 ]};
inputs.exps.exp_y0=	{ 	[	           0            0            0            0            0            0            0 ],
 [	           0            0            0            0            0            0            0 ]};
inputs.exps.n_exp=	2;
inputs.exps.n_obs=	{ 	[	           2 ],
 [	           2 ]};
inputs.exps.n_pulses=	{  [	           5 ]};
inputs.exps.n_s=	{ 	[	          15 ],
 [	          25 ]};
inputs.exps.noise_type=	'homo_var';
inputs.exps.obs=	{ 	char(	'Lum=CL_m  ',...
	'mRNAa=CT_m');
,
 char(	'Lum=CL_m  ',...
	'mRNAa=CT_m');
};
inputs.exps.obs_names=	{ 	char(	'Lum  ',...
	'mRNAa');
,
 char(	'Lum  ',...
	'mRNAa');
};
inputs.exps.t_f=	{ 	[	         120 ],
 [	         120 ]};

 inputs.exps.u_interp{1}='sustained';                  %Stimuli definition for experiment 1:
                                                       %OPTIONS:u_interp: 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down' 
 inputs.exps.t_con{1}=[0 120];                         % Input swithching times: Initial and final time    
 inputs.exps.u{1}=[1];                                 % Values of the inputs 
 
 inputs.exps.u_interp{2}='pulse-down';                 %Stimuli definition for experiment 2
 inputs.exps.n_pulses{2}=5;                            %Number of pulses |-|_|-|_|-|_|-|_|-|_    
 inputs.exps.u_min{2}=0;inputs.exps.u_max{2}=1;        %Minimum and maximum value for the input
 inputs.exps.t_con{2}=[0 :12: 120];                    %Times of switching: Initial time, Intermediate times, Final time
                           
%%
% inputs.model
%

inputs.model.AMIGOjac=	1;
inputs.model.AMIGOsensrhs=	1;
inputs.model.eqns=	char(	'R1 = q1*CP_n*light        ',...
	'R2 = n1*CT_n/(g1+CT_n)    ',...
	'R3 = m1*CL_m/(k1+CL_m)    ',...
	'R4 = p1*CL_m              ',...
	'R5 = r1*CL_c              ',...
	'R6 = r2*CL_n              ',...
	'R7 = m2*CL_c/(k2+CL_c)    ',...
	'R8 = m3*CL_n/(k3+CL_n)    ',...
	'R9 = n2*g2^2/(g2^2+CL_n^2)',...
	'R10 = m4*CT_m/(k4+CT_m)   ',...
	'R11 = p2*CT_m             ',...
	'R12 = r3*CT_c             ',...
	'R13 = r4*CT_n             ',...
	'R14 = m5*CT_c/(k5+CT_c)   ',...
	'R15 = m6*CT_n/(k6+CT_n)   ',...
	'R16 = (1-light)*p3        ',...
	'R17 = m7*CP_n/(k7+CP_n)   ',...
	'R18 = q2*light*CP_n       ',...
	'dCL_m=R1+R2-R3            ',...
	'dCL_c=R4-R5+R6-R7         ',...
	'dCL_n=R5-R6-R8            ',...
	'dCT_m=R9-R10              ',...
	'dCT_c=R11-R12+R13-R14     ',...
	'dCT_n=R12-R13-R15         ',...
	'dCP_n=R16-R17-R18         ');
inputs.model.input_model_type=	'charmodelC';
inputs.model.n_par=	27;
inputs.model.n_st=	7;
inputs.model.n_stimulus=	1;
inputs.model.par=	[	      7.5038       0.6801       1.4992       3.0412      10.0982       1.9685       3.7511       2.3422       7.2482       1.8981          1.2       3.8045       5.3087       4.1946       2.5356        1.442         4.86          1.2       2.1994        9.444          0.5       0.2817       0.7676       0.4364       7.3021       4.5703            1 ];
inputs.model.par_names=	char(	'n1',...
	'n2',...
	'g1',...
	'g2',...
	'm1',...
	'm2',...
	'm3',...
	'm4',...
	'm5',...
	'm6',...
	'm7',...
	'k1',...
	'k2',...
	'k3',...
	'k4',...
	'k5',...
	'k6',...
	'k7',...
	'p1',...
	'p2',...
	'p3',...
	'r1',...
	'r2',...
	'r3',...
	'r4',...
	'q1',...
	'q2');
inputs.model.st_names=	char(	'CL_m',...
	'CL_c',...
	'CL_n',...
	'CT_m',...
	'CT_c',...
	'CT_n',...
	'CP_n');
inputs.model.stimulus_names=	'light';


%%
% inputs.nlpsol
%

inputs.nlpsol.nlpsolver=	'ess';


%%
% inputs.nlpsol.eSS
%

inputs.nlpsol.eSS.maxeval=	10000;


%%
% inputs.nlpsol.eSS.local
%

inputs.nlpsol.eSS.local.finish=	'nl2sol';
inputs.nlpsol.eSS.local.solver=	'nl2sol';


%%
% inputs.pathd
%

inputs.pathd.results_folder=	'circadian_structure';
inputs.pathd.short_name=	'circadian';
