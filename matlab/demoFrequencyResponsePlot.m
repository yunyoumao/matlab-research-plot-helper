function demoFrequencyResponsePlot(repoRoot)
%DEMOFREQUENCYRESPONSEPLOT Create before/after frequency-response-like plots.

if nargin < 1 || isempty(repoRoot)
    repoRoot = fileparts(fileparts(mfilename('fullpath')));
end

dataPath = fullfile(repoRoot, 'data', 'synthetic_frequency_response.csv');
data = readtable(dataPath);

beforeDir = fullfile(repoRoot, 'examples', 'before');
afterDir = fullfile(repoRoot, 'examples', 'after');

fig = figure('Visible', 'off');
subplot(2, 1, 1);
semilogx(data.frequency_hz, data.magnitude_db);
ylabel('Magnitude (dB)');
subplot(2, 1, 2);
semilogx(data.frequency_hz, data.phase_deg);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
exportResearchFigure(fig, fullfile(beforeDir, 'frequency_response_before'));
close(fig);

fig = figure('Visible', 'off');
subplot(2, 1, 1);
semilogx(data.frequency_hz, data.magnitude_db);
ylabel('Magnitude (dB)');
xlim([min(data.frequency_hz) max(data.frequency_hz)]);
subplot(2, 1, 2);
semilogx(data.frequency_hz, data.phase_deg);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
xlim([min(data.frequency_hz) max(data.frequency_hz)]);
applyResearchPlotStyle(fig, struct('widthCm', 14, 'heightCm', 9));
exportResearchFigure(fig, fullfile(afterDir, 'frequency_response_after'));
close(fig);
end
