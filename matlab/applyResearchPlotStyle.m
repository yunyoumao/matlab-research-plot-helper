function palette = applyResearchPlotStyle(fig, opts)
%APPLYRESEARCHPLOTSTYLE Apply publication-style defaults to a MATLAB figure.
%   PALETTE = APPLYRESEARCHPLOTSTYLE(FIG, OPTS) updates axes, lines, legends,
%   and figure size. The function avoids toolbox dependencies.

if nargin < 1 || isempty(fig)
    fig = gcf;
end
if nargin < 2
    opts = struct();
end

opts = setDefault(opts, 'widthCm', 14.0);
opts = setDefault(opts, 'heightCm', 8.0);
opts = setDefault(opts, 'fontName', 'Arial');
opts = setDefault(opts, 'fontSize', 10);
opts = setDefault(opts, 'axisLineWidth', 0.8);
opts = setDefault(opts, 'lineWidth', 1.8);
opts = setDefault(opts, 'markerSize', 5);

palette = [
    0.0000 0.4470 0.7410
    0.8500 0.3250 0.0980
    0.0000 0.6000 0.5000
    0.4940 0.1840 0.5560
    0.9290 0.6940 0.1250
    0.3010 0.7450 0.9330
    0.6350 0.0780 0.1840
];

set(fig, 'Color', 'w');
set(fig, 'Units', 'centimeters');
pos = get(fig, 'Position');
pos(3) = opts.widthCm;
pos(4) = opts.heightCm;
set(fig, 'Position', pos);
set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPosition', [0 0 opts.widthCm opts.heightCm]);
set(fig, 'PaperSize', [opts.widthCm opts.heightCm]);

axesList = findall(fig, 'Type', 'axes');
for k = 1:numel(axesList)
    ax = axesList(k);
    set(ax, 'FontName', opts.fontName);
    set(ax, 'FontSize', opts.fontSize);
    set(ax, 'LineWidth', opts.axisLineWidth);
    set(ax, 'Box', 'on');
    set(ax, 'Color', 'w');
    set(ax, 'XColor', [0.15 0.15 0.15]);
    set(ax, 'YColor', [0.15 0.15 0.15]);
    set(get(ax, 'XLabel'), 'Color', [0.15 0.15 0.15]);
    set(get(ax, 'YLabel'), 'Color', [0.15 0.15 0.15]);
    set(get(ax, 'Title'), 'Color', [0.15 0.15 0.15]);
    set(ax, 'XGrid', 'on');
    set(ax, 'YGrid', 'on');
    set(ax, 'GridAlpha', 0.15);
    set(ax, 'MinorGridAlpha', 0.08);
    set(ax, 'TickDir', 'out');
    set(ax, 'ColorOrder', palette);
end

lineList = findall(fig, 'Type', 'line');
for k = 1:numel(lineList)
    set(lineList(k), 'LineWidth', opts.lineWidth);
    set(lineList(k), 'MarkerSize', opts.markerSize);
end

legendList = findall(fig, 'Type', 'legend');
for k = 1:numel(legendList)
    set(legendList(k), 'Box', 'off');
    set(legendList(k), 'FontName', opts.fontName);
    set(legendList(k), 'FontSize', opts.fontSize);
    set(legendList(k), 'TextColor', [0.15 0.15 0.15]);
end
end

function opts = setDefault(opts, name, value)
if ~isfield(opts, name) || isempty(opts.(name))
    opts.(name) = value;
end
end
