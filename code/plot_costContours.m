function plot_costContours(inputs,results,costFuncPlotsFolder)

inputs.plotd.plotlevel = 'min';
    par = results.fit.thetabest';
    npar = length(par);
    inputs.PEsol.global_theta_guess = par;
    
    AMIGO_ContourP_local(inputs)
    figHandles = findobj('Type','figure');
    for i = 1:length(figHandles)
        %h = figure(figHandles(i));
        a = gca;
        fname = regexprep(a.Title.String, '\s+', '_');
        saveas(gcf,[costFuncPlotsFolder fname '.pdf'])
        saveas(gcf,[costFuncPlotsFolder fname '.fig'])
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
    
