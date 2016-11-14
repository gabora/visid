%% Main Script to do the identifiability analysis. 


%% PROBLEM SPECIFIC INPUTS


% AMIGO PE result to obtain the sensitivities at the optima
caseStudy = 'B5';
amigoResFile = 'B5/B5_nl2sol_6877';
cytoscapeFolder = 'B5/cytoscape/';
mkdir(cytoscapeFolder)


cramerRaoCorrFile = 'B5/B5_corrmat';
clusterCorrFlag = true;
clusterredCorrFile= 'B5/B5_clustCorrmat';

allLargestSubsetsFlag = false;

costcontourplots_FLAG = false;
costFuncPlotsFolder= 'B5/costfunction/';
mkdir(costFuncPlotsFolder)

kmax = 3;       % largest correlated group to be searched for
Clim = 20;      % collinearity threshold for the groups

sensitivity_bar_plot_file = 'B5/B5_sensitivity_bar.pdf'; 
ci_threshold_idsubsetsize_plot_file = 'B5/B5_CI_idsubsetsize.pdf';

myblue = [0.3010    0.7450    0.9330];
myred = [0.8500    0.3250    0.0980];
mygreen = [0.4660    0.6740    0.1880];

%% load input, preprocess
load(amigoResFile)


% compute the sensitivity vector at the optimum

inputs.PEsol.global_theta_guess = results.fit.thetabest';
inputs.plotd.plotlevel='min';
inputs.model.odes_file=fullfile(pwd,'/B5/logic.c');
inputs.pathd.results_folder='B5';
AMIGO_Prep(inputs)

%TODO
%calculate  finite difference jacobian
inputs.plotd.plotlevel = 'noplot';
xref = results.fit.thetabest';

for ipar = 1:length(inputs.PEsol.global_theta_guess)
x = xref;
dx = 0.05*x(ipar);
x(ipar) = x(ipar) + dx;

inputs.PEsol.global_theta_guess = x;
results = AMIGO_SData(inputs);
for iexp = 1:inputs.exps.n_exp
    sim
J(,results.sim.exp_data




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

disp('plotting correlation matrix')
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
saveas(gca,cramerRaoCorrFile)

% cluster output
if clusterCorrFlag
    disp('clustering corr matrix')
    noStandardize = 2;
    dist = 'cosine'; 'correlation';
    clusterRows = 3;
    gco2 = clustergram(abs(g_corr_mat),'Standardize',noStandardize,'Linkage','Average','RowPDist', ...
        dist,'ColumnPDist',dist,'Cluster',clusterRows,'OptimalLeafOrder', true,'Colormap','jet');
    set(gco2,'ColumnLabels',variables,'RowLabels',variables)
    %set(gco2,'Linkage','complete','Dendrogram',3)
    colorbar
    h = plot(gco2);
    saveas(h,clusterredCorrFile)
end

%% see contourplots of the cost function vs 2 variables
if costcontourplots_FLAG
    inputs.plotd.plotlevel = 'min';
    par = results.fit.thetabest';
    inputs.PEsol.global_theta_guess = par;
    
    AMIGO_ContourP_local(inputs)
    figHandles = findobj('Type','figure');
    for i = 1:length(figHandles)
        h = figure(figHandles(i));
        a = gca;
        fname = regexprep(a.Title.String, '\s+', '_');
        saveas(gcf,[costFuncPlotsFolder fname '.pdf'])
    end
    
    % arrange them in a subplot
    figHandles = figHandles(end:-1:1);
    figure
    ifig = 0;
    for i = 1:npar  % diagonals
        ifig = ifig+1;
        sp = subplot(npar,npar,i+(i-1)*npar);
        fig = get(figHandles(ifig),'Children');
        ax = get(fig,'children');
        copyobj(ax,sp)
        set(gca,'xtick',[],'ytick',[])
        if i==1
            set(sp,'XAxisLocation', 'top')
            xlabel(fig.XLabel.String)
        elseif i == npar
            set(sp,'YAxisLocation', 'right')
            xlabel(fig.YLabel.String)
        end
        
        axis tight
    end
    
    for ipar = 1:(npar-1)
        
        for jpar = (ipar+1):npar
            ifig = ifig+1;
            sp = subplot(npar,npar,jpar+(ipar-1)*npar);
          
            fig = get(figHandles(ifig),'Children');
           
            ax = get(fig(2),'children');
            copyobj(ax,sp)
            set(gca,'xtick',[],'ytick',[])
            if ipar== 1
                set(sp,'XAxisLocation', 'top')
                xlabel(fig(2).YLabel.String)
            end
            if jpar == npar
                set(sp,'yAxisLocation', 'right')
                ylabel(fig(2).XLabel.String)
            end
            axis tight
        end
    end
    
end

%% Plot the sensitivities using barplots
figure()
tickpos = 1:size(cnRjac,2);

bar(tickpos,cnRjac,'Facecolor',myblue)
ylabel('sensitivity norm')
xlabel('parameters')
title([caseStudy ' parameter sensitivity'])
set(gca,'yscale','log','xtick',tickpos,'xticklabel',variables,'xticklabelrotation',90)
 xlim( [0.5 size(cnRjac,2)-0.5])
%AMIGO_fig2publish(gcf,12)
saveas(gca,sensitivity_bar_plot_file)

%% Identifiability
 
% show the ID group-size vs. threshold level 
CI_threshold = [5:5:100];
subset_size = zeros(1,length(CI_threshold));
for i_ci = 1:length(CI_threshold)
    subset = locally_identifiable_subset(nRjac,  CI_threshold(i_ci));
    subset_size(i_ci) = numel(subset);
end

figure()
plot(CI_threshold,subset_size,'o','markersize',8,'markerfacecolor',myblue, 'markeredgecolor','black')
xlabel('CI threshold')
ylabel('Identifiable subset size')
title({caseStudy 'subset size dependence on collinearity threshold'})
ylim([1 npar])
grid on
hold on
line([Clim Clim],[1 npar],'LineStyle',':'  ,  'Color', myred, 'Linewidth',2 )

shg
saveas(gca,ci_threshold_idsubsetsize_plot_file)


%% compute all the largest subsets
% not possible for B4, MATLAB out of memory
if allLargestSubsetsFlag
    [largest_subsets largest_subsets_ci] = all_largest_subsets(nRjac,Clim);
    ngroups = size(largest_subsets_ci,1);
    
    
    % Generate latex table containing the identifiable parameters
    disp([variables(largest_subsets)])
    for i = 1:ngroups
        rowlabel{i} = sprintf('set %d',i);
        ci_text{i} = num2str(largest_subsets_ci(i),'%.4g');
    end
    latex.data = [ ci_text' [variables(largest_subsets)] ];
    latex.tableRowLabels =rowlabel;
    latex.tableBorders = 0;
    disp('%**************** COPY TO LATEX **************************')
    latextxt = latexTable(latex);
    disp('%**************** END **************************')
end

%%  compute the correlated groups.  
[hcgrps, hci] = highCollinearityUptoKgroup(nRjac,kmax,Clim);

%export correlated groups using dummy nodes to cytoscape. Nothing can be seen on the figure. too crowded. 
higherCI2Cytoscape(hcgrps,hci,variables,[cytoscapeFolder 'hcgrps'])

% export only pairwise correlation without dummy nodes
pairwiseCI2cytoscape(hcgrps{2},hci{2},variables,[cytoscapeFolder 'pairs'])

% export pairwise and triplet but without dummy node
pair_tripletCI2cytoscape(hcgrps{2},hci{2},hcgrps{3},hci{3},variables,[cytoscapeFolder 'upto3'])


%% print latex table with the collinear groups
% B4: we got 225 pairs and 1473 triplets. We dont want to print all of
% these
% dummy = {};
% nline = 0;
% ncolumn = 0;
% for i = 1:length(hcgrps)
%     if isempty(hcgrps{i}), continue,    end
%     [ngrps, npars] = size(hcgrps{i});
%     nline = nline + ngrps;
%     if ncolumn < npars
%         ncolumn = npars;
%     end
% end
% 
% text_array = cell(nline,ncolumn);
% nsets = 0;
% iline = 0;
% for idim = 1:length(hcgrps)
%     if isempty(hcgrps{idim}), continue,    end
%     for igroup = 1:size(hcgrps{idim},1)
%         nsets = nsets +1;
%         setname = ['G' ,num2str(idim),'(',num2str(igroup),')'];
%         CI_str = sprintf('%.3g',hci{idim}(igroup));
%         
%         text_array{nsets,1} = setname;
%         text_array{nsets,2} = CI_str;
%         pars = {variables{hcgrps{idim}(igroup,:)}};
%         text_array(nsets,2+(1:length(pars))) = pars;
%     end
%     
% end
% latex = struct();
% latex.data = text_array; 
% latex.tableBorders = 0;
% disp('%**************** COPY TO LATEX **************************')
% latextxt = latexTable(latex);
% disp('%**************** END **************************')


%% export an identifiable/non-identifiable susbsets of parameters together
% with the network

id_param = identifiable_subset2cytoscape(nRjac,variables,Clim, [cytoscapeFolder 'network']);

network2Cytoscape(inputs,[cytoscapeFolder 'network'],id_param)

