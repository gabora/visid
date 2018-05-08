function plot_sensBar(sensMat,varNames)
% plot the sensitivities of each parameter using barplot.
% Args:
%   sensMat: sensitivity matrix, each column for a parameter
%   varNames: cell vector, same length as number of columns in sensMat

myblue = [0.3010    0.7450    0.9330];

figure()
tickpos = 1:size(sensMat,2);

bar(tickpos,sensMat,'Facecolor',myblue)
ylabel('sensitivity norm')
xlabel('parameters')

set(gca,'yscale','log','xtick',tickpos,'xticklabel',varNames,'xticklabelrotation',90)
xlim( [0.5 size(sensMat,2)-0.5])

