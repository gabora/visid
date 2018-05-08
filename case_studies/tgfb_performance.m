% performance comparison

%TGFB
clear

amigoResFile = 'tgfb/tgfb_pe_results';
load(amigoResFile)

Clim = 20; 

variables = cellstr(inputs.PEsol.id_global_theta);
Rjac = results.fit.Rjac;
npar = size(Rjac,2);
for i = 1:size(Rjac,2);
    cnRjac(i) = norm(Rjac(:,i));
    nRjac(:,i) = Rjac(:,i)/norm(Rjac(:,i)); 
end

%% compute Statistics
nTrial = 10;
tAllLargest = zeros(1,nTrial);
tCIPairs = zeros(1,nTrial);
tCITriplets = zeros(1,nTrial);
tLargestIDSet = zeros(1,nTrial);
for i = 1:nTrial
timer2=tic();
[largest_subsets largest_subsets_ci] = all_largest_subsets(nRjac,Clim);
tAllLargest(i) = toc(timer2);


kmax = 2;
timer3 = tic();
[hcgrps2, hci2] = highCollinearityUptoKgroup(nRjac,kmax,Clim);
disp('time for CI(all pairs):')
tCIPairs(i) = toc(timer3);

kmax = 3;
timer3 = tic();
[hcgrps3, hci3] = highCollinearityUptoKgroup(nRjac,kmax,Clim);
disp('time for CI(all triplets):')
tCITriplets(i) = toc(timer3);

timer3 = tic();
id_subset = locally_identifiable_subset(nRjac,Clim);
tLargestIDSet(i) = toc(timer3);
end
fprintf(1,'largest: %f +/- %f \n',mean(tLargestIDSet),std(tLargestIDSet))
fprintf(1,'CIpairs: %f +/- %f \n',mean(tCIPairs),std(tCIPairs))
fprintf(1,'CItriplets: %f +/- %f \n',mean(tCITriplets),std(tCITriplets))
fprintf(1,'All largest: %f +/- %f \n',mean(tAllLargest),std(tAllLargest))
