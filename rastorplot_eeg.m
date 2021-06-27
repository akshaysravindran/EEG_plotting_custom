function rastorplot_eeg(eeg, srate, offset, chans2plot,args)
%% plot time series as a rastor plot
% Different rows will be plotted on the same figure raised with offset
% difference between adjacent channels
% eeg        : CH x time eeg data (matrix)
% offset     : value by which each row should be raised (integer value)
% chans2plot : channel numbers to plot (array)
% args       : plot parameters (title, fontsize, xlabel, ylabel, channel_names)


% Define figure window
% figure('color','w','units','inches','position',[1, 4, 7.5, 5]);

ax =gca
% Plot each EEG timeseries
hold on;
for i = 1:length(chans2plot)
    % Get channel index to plot
    idx = chans2plot(i);
    
    % Offset each channels
    data = eeg(idx,:) - (i-1)*offset;
    
    % Plot data
    plot([1:size(eeg,2)]/srate,data,'k');
    
end

% Add a line to get perspective of scales
yscale        = line([length(data)+0.01*srate*ones(1,2)]/srate, [-offset,offset] - 2*offset,'color','k','linewidth',1);
yscale_text   = text([length(data)+0.02*srate]/srate, - 2*offset, [num2str(offset*2),' \muV']);

% Set Y limits
ulim = max(eeg(chans2plot(1),:))+offset;
llim = -(length(chans2plot))*offset;
ylim([llim, ulim])
% Set X limits
xlim([0 (size(eeg,2) + 0.1*srate)/srate]);

% Add x and y label
if isfield(args,'xlabel')
    xlabel(args.xlabel)
end
if isfield(args,'ylabel')
    ylabel(args.xlabel)
end

% Add title
if isfield(args,'title')
    title(args.title)        
end
% Adjust the yticks and add channel names to y ticks
ax.YTick      = fliplr(0 - ((1:length(chans2plot))-1)*offset);
if isfield(args,'channel_names')
    ax.YTickLabel = fliplr(args.channel_names(chans2plot));
end

if isfield(args,'fontsize')
    set(gca,'FontName','Times New Roman','fontsize',args.fontsize)
else
    set(gca,'FontName','Times New Roman','fontsize',11)
end

end