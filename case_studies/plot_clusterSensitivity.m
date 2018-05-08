function h = plot_clusterSensitivity(g_corr_mat,variables)
timer1 = tic;
noStandardize = 2;
dist = 'Euclidean';%'cosine'; 'correlation';
clusterRows = 3;
gco2 = clustergram(abs(g_corr_mat),'Standardize',noStandardize,'Linkage','Average','RowPDist', ...
    dist,'ColumnPDist',dist,'Cluster',clusterRows,'OptimalLeafOrder', true,'Colormap','jet');
set(gco2,'ColumnLabels',variables,'RowLabels',variables)
set(gco2,'Linkage','complete','Dendrogram',3)
colorbar
disp('time for cluster sensitivity matrix:')
toc(timer1)
h = plot(gco2);