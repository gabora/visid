function plot_sensBar(cnRjac,variables)
myblue = [0.3010    0.7450    0.9330];
myred = [0.8500    0.3250    0.0980];
mygreen = [0.4660    0.6740    0.1880];


figure()
tickpos = 1:size(cnRjac,2);

bar(tickpos,cnRjac,'Facecolor',myblue)
ylabel('sensitivity norm')
xlabel('parameters')
title([caseStudy ' parameter sensitivity'])
set(gca,'yscale','log','xtick',tickpos,'xticklabel',variables,'xticklabelrotation',90)
 xlim( [0.5 size(cnRjac,2)-0.5])
%AMIGO_fig2publish(gcf,12)
