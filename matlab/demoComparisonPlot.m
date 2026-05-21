function demoComparisonPlot(repoRoot)
%DEMOCOMPARISONPLOT Create before/after synthetic method comparison figures.

if nargin < 1 || isempty(repoRoot)
    repoRoot = fileparts(fileparts(mfilename('fullpath')));
end

dataPath = fullfile(repoRoot, 'data', 'synthetic_timeseries.csv');
data = readtable(dataPath);

beforeDir = fullfile(repoRoot, 'examples', 'before');
afterDir = fullfile(repoRoot, 'examples', 'after');

fig = figure('Visible', 'off');
plot(data.time_s, data.baseline);
hold on;
plot(data.time_s, data.method_a);
plot(data.time_s, data.method_b);
xlabel('Time (s)');
ylabel('Response');
legend('Baseline', 'Method A', 'Method B');
exportResearchFigure(fig, fullfile(beforeDir, 'comparison_before'));
close(fig);

fig = figure('Visible', 'off');
plot(data.time_s, data.baseline);
hold on;
plot(data.time_s, data.method_a);
plot(data.time_s, data.method_b);
xlabel('Time (s)');
ylabel('Normalized response');
legend('Baseline', 'Method A', 'Method B', 'Location', 'northeastoutside');
xlim([0 10]);
ylim([0 1.45]);
applyResearchPlotStyle(fig, struct('widthCm', 16, 'heightCm', 7.5));
exportResearchFigure(fig, fullfile(afterDir, 'comparison_after'));
close(fig);
end
