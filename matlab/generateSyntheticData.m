function generateSyntheticData(outputDir)
%GENERATESYNTHETICDATA Create deterministic synthetic plotting fixtures.
%   The generated data are generic and do not represent any experiment,
%   compressor, test rig, or unpublished manuscript.

if nargin < 1 || isempty(outputDir)
    outputDir = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'data');
end
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

time_s = linspace(0, 10, 501).';
reference = ones(size(time_s));
disturbance = 0.16 * exp(-0.35 * (time_s - 3.0)) .* sin(2 * pi * 0.9 * (time_s - 3.0));
disturbance(time_s < 3.0) = 0;
response = 1 - exp(-0.9 * time_s) .* (cos(2.4 * time_s) + 0.32 * sin(2.4 * time_s)) + disturbance;
baseline = 1 - exp(-0.42 * time_s) .* (cos(1.7 * time_s) + 0.58 * sin(1.7 * time_s));
method_a = response;
method_b = 1 - exp(-1.25 * time_s) .* (cos(2.1 * time_s) + 0.18 * sin(2.1 * time_s)) + 0.45 * disturbance;

time_s = round(time_s, 4);
reference = round(reference, 4);
response = round(response, 4);
disturbance = round(disturbance, 4);
baseline = round(baseline, 4);
method_a = round(method_a, 4);
method_b = round(method_b, 4);

timeTable = table(time_s, reference, response, disturbance, baseline, method_a, method_b);
writetable(timeTable, fullfile(outputDir, 'synthetic_timeseries.csv'));

frequency_hz = logspace(-1, 2, 240).';
omega = 2 * pi * frequency_hz;
wn = 2 * pi * 4.0;
zeta = 0.34;
ratio = omega ./ wn;
magnitude = 1 ./ sqrt((1 - ratio.^2).^2 + (2 * zeta * ratio).^2);
magnitude_db = 20 * log10(magnitude);
phase_deg = -atan2d(2 * zeta * ratio, 1 - ratio.^2);

frequency_hz = round(frequency_hz, 4);
magnitude_db = round(magnitude_db, 4);
phase_deg = round(phase_deg, 4);

freqTable = table(frequency_hz, magnitude_db, phase_deg);
writetable(freqTable, fullfile(outputDir, 'synthetic_frequency_response.csv'));
end
