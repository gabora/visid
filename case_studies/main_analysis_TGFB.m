%% Main Script to do the identifiability analysis. 


%% PROBLEM SPECIFIC INPUTS


% AMIGO PE result to obtain the sensitivities at the optima
caseStudy = 'TGFB';
amigoResFile = 'tgfb/tgfb_pe_results';
cytoscapeFolder = 'tgfb/cytoscape/';
mkdir(cytoscapeFolder)

cramerRaoCorrFile = 'tgfb/tgfb_corrmat';
clusterCorrFlag = false;
clusterredCorrFile= 'tgfb/tgfb_clustCorrmat';

allLargestSubsetsFlag = true;

costcontourplots_FLAG = false;
costFuncPlotsFolder= 'tgfb/costfunction/';
mkdir(costFuncPlotsFolder)

kmax = 6;       % largest correlated group to be searched for
Clim = 20;      % collinearity threshold for the groups

sensitivity_bar_plot_file = 'tgfb/tgfb_sensitivity_bar'; 
ci_threshold_idsubsetsize_plot_file = 'tgfb/tgfb_CI_idsubsetsize';

myblue = [0.3010    0.7450    0.9330];
myred = [0.8500    0.3250    0.0980];
mygreen = [0.4660    0.6740    0.1880];

%% load input, preprocess
load(amigoResFile)
%% compute the Jacobian for the CPU time
tic
for i = 1:100
[~,~,Rjac] = AMIGO_getPEJac(results.fit.thetabest,inputs);
end
toc
%%

variables = cellstr(inputs.PEsol.id_global_theta);
Rjac = results.fit.Rjac;
npar = size(Rjac,2);
for i = 1:size(Rjac,2);
    cnRjac(i) = norm(Rjac(:,i));
    nRjac(:,i) = Rjac(:,i)/norm(Rjac(:,i)); 
end

%% plot the cramer rao correlation matrix
g_corr_mat = results.fit.g_corr_mat;
corr_mat = zeros(size(g_corr_mat)+1);
corr_mat(1:end-1,1:end-1)= g_corr_mat;


figure
pcolor(corr_mat)
caxis([-1,1])

colorbar
colormap jet
ticklabels = char(variables);
set(gca,'YTick',1+0.5:1:length(variables)+0.5,'YTickLabel',ticklabels);
set(gca,'xticklabel',[])
ticksX = 1+0.5:1:length(variables)+0.5;
xlabels = cellstr(ticklabels);
set(gca,'XTick',1+0.5:1:length(variables)+0.5)
set(gca,'xticklabel',xlabels,'xticklabelrotation',90)
shg
saveas(gca,cramerRaoCorrFile,'pdf')
saveas(gca,cramerRaoCorrFile,'fig')

% cluster output
if clusterCorrFlag
    h = plot_clusterSensitivity(g_corr_mat,variables);
    
    saveas(h,clusterredCorrFile,'fig')
    saveas(h,clusterredCorrFile,'pdf')
end

%% see contourplots of the cost function vs 2 variables
if costcontourplots_FLAG
    plot_costContours(inputs,results,costFuncPlotsFolder)
end

%% Plot the sensitivities using barplots
plot_sensBar(cnRjac,variables)

saveas(gca,sensitivity_bar_plot_file,'fig')
saveas(gca,sensitivity_bar_plot_file,'pdf')

%% Identifiability
% show the ID group-size vs. threshold level 
CI_threshold = [5:5:100];
plot_ID_vs_CIThreshold(nRjac,CI_threshold,caseStudy)

shg
saveas(gca,ci_threshold_idsubsetsize_plot_file,'fig')
saveas(gca,ci_threshold_idsubsetsize_plot_file,'pdf')


%% compute all the largest subsets
if allLargestSubsetsFlag
    timer2=tic();
    [largest_subsets largest_subsets_ci] = all_largest_subsets(nRjac,Clim);
    ngroups = size(largest_subsets_ci,1);
    
    
    % Generate latex table containing the identifiable parameters
    disp([variables(largest_subsets)])
    for i = 1:ngroups
        rowlabel{i} = sprintf('set %d',i);
        ci_text{i} = num2str(largest_subsets_ci(i),'%.4g');
    end
    %latex.data = [ ci_text' [variables(largest_subsets)] ];
    %latex.tableRowLabels =rowlabel;
    %latex.tableBorders = 0;
    %disp('%**************** COPY TO LATEX **************************')
    %latextxt = latexTable(latex);
    %disp('%**************** END **************************')
    disp('time for all largest subset:')
    toc(timer2)
end

%%  compute the correlated groups.  
timer3 = tic();
[hcgrps, hci] = highCollinearityUptoKgroup(nRjac,kmax,Clim);
disp('time highCollinearityUptoKgroup:')
toc(timer3)


%export correlated groups using dummy nodes to cytoscape. Nothing can be seen on the figure. too crowded. 
higherCI2Cytoscape(hcgrps,hci,variables,[cytoscapeFolder 'hcgrps'])

% export only pairwise correlation without dummy nodes
pairwiseCI2cytoscape(hcgrps{2},hci{2},variables,[cytoscapeFolder 'pairs'])

% export pairwise and triplet but without dummy node
pair_tripletCI2cytoscape(hcgrps{2},hci{2},hcgrps{3},hci{3},variables,[cytoscapeFolder 'upto3'])


%% print latex table with the groups
dummy = {};
nline = 0;
ncolumn = 0;
for i = 1:length(hcgrps)
    if isempty(hcgrps{i}), continue,    end
    [ngrps, npars] = size(hcgrps{i});
    nline = nline + ngrps;
    if ncolumn < npars
        ncolumn = npars;
    end
end

text_array = cell(nline,ncolumn);
nsets = 0;
iline = 0;
for idim = 1:length(hcgrps)
    if isempty(hcgrps{idim}), continue,    end
    for igroup = 1:size(hcgrps{idim},1)
        nsets = nsets +1;
        setname = ['G' ,num2str(idim),'(',num2str(igroup),')'];
        CI_str = sprintf('%.3g',hci{idim}(igroup));
        
        text_array{nsets,1} = setname;
        text_array{nsets,2} = CI_str;
        pars = {variables{hcgrps{idim}(igroup,:)}};
        text_array(nsets,2+(1:length(pars))) = pars;
    end
    
end
%latex = struct();
%latex.data = text_array; 
%latex.tableBorders = 0;
%disp('%**************** COPY TO LATEX **************************')
%latextxt = latexTable(latex);
%disp('%**************** END **************************')


% export an identifiable/non-identifiable susbsets of parameters together
% with the network
timer4 = tic();
id_param = identifiable_subset2cytoscape(nRjac,variables,Clim, [cytoscapeFolder 'network']);
disp('finding largest identifiable group')
toc(timer4)

network2Cytoscape(inputs,[cytoscapeFolder 'network'],id_param)



%CI = pe2CI(results);
%CI2cytoscape_th20(CI,variables,'tgfb2');

