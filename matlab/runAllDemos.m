%RUNALLDEMOS Generate synthetic data and export all example figures.
%   Run from the repository root:
%       run("matlab/runAllDemos.m")

repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(repoRoot, 'matlab'));

set(groot, 'defaultFigureColor', 'w');
set(groot, 'defaultAxesColor', 'w');
set(groot, 'defaultAxesXColor', 'k');
set(groot, 'defaultAxesYColor', 'k');
set(groot, 'defaultTextColor', 'k');

generateSyntheticData(fullfile(repoRoot, 'data'));
demoTimeSeriesPlot(repoRoot);
demoFrequencyResponsePlot(repoRoot);
demoComparisonPlot(repoRoot);

fprintf('Generated synthetic data and example figures in %s\n', repoRoot);
