function exportResearchFigure(fig, basePath, opts)
%EXPORTRESEARCHFIGURE Export a figure to PNG, PDF, and SVG.
%   EXPORTRESEARCHFIGURE(FIG, BASEPATH) writes BASEPATH.png, BASEPATH.pdf,
%   and BASEPATH.svg. If exportgraphics is unavailable, print is used.

if nargin < 1 || isempty(fig)
    fig = gcf;
end
if nargin < 2 || isempty(basePath)
    error('A base output path is required.');
end
if nargin < 3
    opts = struct();
end

opts = setDefault(opts, 'resolution', 300);
[folder, ~, ~] = fileparts(basePath);
if ~isempty(folder) && ~exist(folder, 'dir')
    mkdir(folder);
end

set(fig, 'Color', 'w');
set(fig, 'InvertHardcopy', 'off');

pngPath = [basePath '.png'];
pdfPath = [basePath '.pdf'];
svgPath = [basePath '.svg'];

if exist('exportgraphics', 'file') == 2
    exportgraphics(fig, pngPath, 'Resolution', opts.resolution);
    exportgraphics(fig, pdfPath, 'ContentType', 'vector');
    exportgraphics(fig, svgPath, 'ContentType', 'vector');
else
    set(fig, 'PaperPositionMode', 'auto');
    print(fig, pngPath, '-dpng', ['-r' num2str(opts.resolution)]);
    print(fig, pdfPath, '-dpdf', '-painters');
    print(fig, svgPath, '-dsvg', '-painters');
end
end

function opts = setDefault(opts, name, value)
if ~isfield(opts, name) || isempty(opts.(name))
    opts.(name) = value;
end
end
