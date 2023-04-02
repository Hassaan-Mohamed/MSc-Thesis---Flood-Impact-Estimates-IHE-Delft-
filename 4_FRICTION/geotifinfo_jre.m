function [I]=geotifinfo_jre(varargin)
% GEOTIFF_READ: read geotiff using imread and assign map info from infinfo.
%
% I = GEOTIFF_READ('filename');
% Reads whole images
% I = GEOTIFF_READ('filename','pixel_subset', [minx maxx miny maxy]);
% I = GEOTIFF_READ('filename','map_subset'  , [minx maxx miny maxy]);
% extract subset of the specified.

% output:
% I.z, image data
% I.x, x coordinate in map
% I.y, y coordinate in map
% I.info, misc. info

% imshow(I.z, 'xdata', I.x, 'ydata', I.y);
% shows image with map coordinate

% Version by Yushin Ahn, ahn.74@osu.edu
% Glacier Dynamics Laboratory, 
% Byrd Polar Resear Center, Ohio State University 
% Referenced enviread.m (Ian Howat)

name = varargin{1};

Tinfo        = imfinfo(name);
info.samples = Tinfo.Width;
info.lines   = Tinfo.Height;
info.imsize  = Tinfo.Offset;
info.bands   = Tinfo.SamplesPerPixel;


sub = [1, info.samples, 1, info.lines];

info.map_info.dx = Tinfo.ModelPixelScaleTag(1);
info.map_info.dy = Tinfo.ModelPixelScaleTag(2);
info.map_info.minx = Tinfo.ModelTiepointTag(4);
info.map_info.maxy = Tinfo.ModelTiepointTag(5);

minx = info.map_info.minx;
maxy = info.map_info.maxy;
maxx = minx + (info.samples-1).*info.map_info.dx;
miny = maxy - (info.lines-1  ).*info.map_info.dy;
% ModelTiepointTag =[i,j,0,x,y,0]  i,j=0,0 is upper left corner
info.BoundingBox = round([info.map_info.minx miny-info.map_info.dy; maxx+info.map_info.dx info.map_info.maxy],8);

xm = info.map_info.minx;
ym = info.map_info.maxy;
x_ = xm + ((0:info.samples-1).*info.map_info.dx);
y_ = ym - ((0:info.lines  -1).*info.map_info.dy);
       
I.x = x_(sub(1):sub(2));
I.y = y_(sub(3):sub(4));

I.info = info;














