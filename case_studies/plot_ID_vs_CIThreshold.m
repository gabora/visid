function plot_ID_vs_CIThreshold(nRjac,CI_threshold,caseStudy)

myblue = [0.3010    0.7450    0.9330];
myred = [0.8500    0.3250    0.0980];
mygreen = [0.4660    0.6740    0.1880];

npar = size(nRjac,2);
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
