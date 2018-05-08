function plot_cramerRao(g_corr_mat,varNames)
% plot the sensitivities of each parameter using barplot.
% Args:
%   g_corr_mat: correlation matrix of parameters
%   varNames: cell vector, same length as number of columns in sensMat

corr_mat = zeros(size(g_corr_mat)+1);
corr_mat(1:end-1,1:end-1)= g_corr_mat;


figure
pcolor(corr_mat)
caxis([-1,1])

colorbar
colormap jet
ticklabels = char(varNames);
set(gca,'YTick',1+0.5:1:length(varNames)+0.5,'YTickLabel',ticklabels);
set(gca,'xticklabel',[])
ticksX = 1+0.5:1:length(varNames)+0.5;
xlabels = cellstr(ticklabels);
set(gca,'XTick',1+0.5:1:length(varNames)+0.5)
set(gca,'xticklabel',xlabels,'xticklabelrotation',90)