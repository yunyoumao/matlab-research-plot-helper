function demoTimeSeriesPlot(repoRoot)
%DEMOTIMESERIESPLOT Create before/after synthetic time-series figures.

if nargin < 1 || isempty(repoRoot)
    repoRoot = fileparts(fileparts(mfilename('fullpath')));
end

dataPath = fullfile(repoRoot, 'data', 'synthetic_timeseries.csv');
data = readtable(dataPath);

beforeDir = fullfile(repoRoot, 'examples', 'before');
afterDir = fullfile(repoRoot, 'examples', 'after');

fig = figure('Visible', 'off');
plot(data.time_s, data.reference, '--');
hold on;
plot(data.time_s, data.response);
plot(data.time_s, data.disturbance);
xlabel('Time (s)');
ylabel('Normalized value');
legend('Reference', 'Response', 'Disturbance');
exportResearchFigure(fig, fullfile(beforeDir, 'timeseries_before'));
close(fig);

fig = figure('Visible', 'off');
plot(data.time_s, data.reference, '--');
hold on;
plot(data.time_s, data.response);
plot(data.time_s, data.disturbance);
xlabel('Time (s)');
ylabel('Normalized value');
legend('Reference', 'Response', 'Disturbance', 'Location', 'northeastoutside');
xlim([0 10]);
ylim([-0.25 1.25]);
applyResearchPlotStyle(fig, struct('widthCm', 16, 'heightCm', 7.5));
exportResearchFigure(fig, fullfile(afterDir, 'timeseries_after'));
close(fig);
end
