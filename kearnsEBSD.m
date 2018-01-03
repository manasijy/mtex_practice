clear;
close;

%% Import Script for EBSD Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = {... 
  'notIndexed',...
  crystalSymmetry('6/mmm', [3.231 3.231 5.148], 'X||a*', 'Y||b', 'Z||c', 'mineral', 'Zr-Hex', 'color', 'light blue')};

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');

%% Specify File Names

% path to files
pname = 'C:\Documents and Settings\nilesh\My Documents\MATLAB\MKY1\mtex_practice';

% which files to be imported
fname = [pname '\Project 1 Specimen 1 Site 4 Map Data 6.ctf'];

%% Import the Data

% create an EBSD variable containing the data
ebsd = loadEBSD(fname,CS,'interface','ctf',...
  'convertEuler2SpatialReferenceFrame');
%plot(ebsd)

%% To plot ipf map

plot(ebsd('Zr-Hex'),ebsd('Zr-Hex').orientations) 
figure
oM = ipdfHSVOrientationMapping(ebsd('Zr-Hex'));
plot(oM) % this plots the ipf color code traingle
% The data are colorized according to its orientation. By default color of an orientation is determined by its position in the
% 001 inverse pole figure which itself is colored as

%oM = ipdfHSVOrientationMapping(ebsd);
% oM = ipdfHSVOrientationMapping(ebsd('Zr-Hex'));
% plot(oM) % this plots the ipf color code traingle
% figure
% plot(ebsd,oM.orientation2color(ebsd.orientations))
% 
% 
% oM.inversePoleFigureDirection = zvector

%%
% CS = crystalSymmetry('6/mmm', [1 1 1.593], 'X||a*', 'Y||b', 'Z||c');
% m = Miller(0,0,0,2,CS);
% basal = ebsd*m
%% Calculate kearn's fractions from the odf

CS1 = crystalSymmetry('6/mmm', [1 1 1.593], 'X||a*', 'Y||b', 'Z||c');
SS1 = specimenSymmetry('1');

m = Miller(0,0,0,2,CS1);

basal = ebsd*m;
X = angle(basal,xaxisdirection)/degree;
Y = angle(basal,yaxisdirection)/degree;
Z = angle(basal,zaxis)/degree;

xcount = 0;
ycount = 0;
zcount = 0;
N = size(ebsd);
for i=1:1:10000
    if (X(i,1)==Y(i,1))&&(Y(i,1)==Z(i,1)) 
        xcount = xcount+0;
        ycount = ycount+0;
        zcount = zcount+0;
    end
    
    if X(i,1)< Y(i,1) 
        if X(i,1)<Z(i,1)
            xcount = xcount+1;
        else zcount = zcount+1;
        end
    elseif Y(i,1)<Z(i,1)
        ycount = ycount+1;
    else zcount = zcount+1;
    end 
end
Fx = xcount/N;
Fy = ycount/N;
Fz = zcount/N;