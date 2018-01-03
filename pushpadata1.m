clear;
close;

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = {... 
  'notIndexed',...
  crystalSymmetry('62', [3.231 3.231 5.148], 'X||a', 'Y||b*', 'Z||c', 'color', 'red')};

% specimen symmetry
SS = crystalSymmetry('orthorhombic');

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','outOfPlane');

%% Specify File Names

% path to files
pname = 'C:\Documents and Settings\nilesh\My Documents\MATLAB\MKY1\mtex_practice';

% which files to be imported
fname = [pname '\pushpa1.osc'];

%% Import the Data

% create an EBSD variable containing the data
ebsd = loadEBSD(fname,CS,SS,'interface','osc',...
  'wizard');

% ebsd = loadEBSD_generic(fname,'CS',CS,'SS',SS, 'ColumnNames', ...
%   {'Index' 'Phase' 'x' 'y' 'Euler1' 'Euler2' 'Euler3' 'MAD' 'BC' 'BS'...  'Bands' 'Error' 'ReliabilityIndex'}, 'Bunge')    

% setMTEXpref('xAxisLabel','micron');

region = [0 0 4 1]*10^2;
rectangle('position',region,'edgecolor','r','linewidth',2);
ebsd = ebsd(inpolygon(ebsd,region));

%plot(ebsd)

%% Note, that you can also select a polygon by mouse using the command
% poly = selectPolygon

%% To plot only selected phase

%ebsd('phase1') % only phase 1 data is assigned to ebsd var
% ebsd({'phase1','phase2'}) for two ans similar for more no of phases

%% To plot ipf map

%plot(ebsd('phase1'),ebsd('phase1').orientations) 

%The data are colorized according to its orientation. By default color of an orientation is determined by its position in the
%001 inverse pole figure which itself is colored as

% oM = ipdfHSVOrientationMapping(ebsd); %oM = ipdfHSVOrientationMapping(ebsd('phase1'))
% plot(oM) % this plots the ipf color code traingle
% figure
% plot(ebsd,oM.orientation2color(ebsd.orientations))


% oM.inversePoleFigureDirection = zvector

%%

%plotx2east

%% MAD (mean angular deviation) in the case of Oxford Channel programs, or by CI (Confidence Index) in the case of OIM-TSL programs
         

% plot(ebsd,ebsd.mad)
% mtexColorbar

% hist(ebsd.mad) % will plot the histogram

% % take only those measurements with MAD smaller then one
% ebsd_corrected = ebsd(ebsd.mad<0.8)
% ebsd_corrected = ebsd(ebsd.mad<0.8)

% Or

% plot(ebsd,ebsd.imagequality)
% mtexColorbar   
% colormap gray

% To make bar chart of IQ of the ebsd map

% [freq,x1]= hist(ebsd.imagequality,15); % will plot the histogram
% rfreq = freq/(length(ebsd.imagequality));
% bar(x1,rfreq)

% ebsd_corrected = ebsd(ebsd.imagequality<0.8);


%ebsd(1:end) % it lists out the data recorded for each position in the
%particular data format e.g. in osc format(TSL,oim) following info is
%provided

        %Phase   Orientations  Mineral  Color  Symmetry  Crystal reference frame
        %      1  126327 (100%)             red       622        X||a, Y||b*, Z||c

        %  Properties: confidenceindex, fit, imagequality, semsignal, x, y
        %  Scan unit : um (micron)
 % So while selecting the field of ebsd data to be plotted inthe map we
 % select ebsd.imagequality or ebsd.con

%% To reduce ebsd data

% ebsd = reduce(ebsd,2); % take every second pixel horiz. and vert.
% ebsd = reduce(ebsd,3); % take every third pixel horiz. and vert.
% plot(ebsd)

%% select grains by orientation or position
q0 = orientation('Miller',[1 0 0], [0 1 1],CS ,SS);
epsilon = 8*degree;
ebsd = findByOrientation(ebsd,q0,epsilon);
plot(ebsd)
% select EBSD data by spatial coordinates        
%             map = findByLocation( ebsd, xy )

%% Calculate grains
% grains = calcGrains(ebsd,'angle',10*degree)


%% rotation of ebsd data 

% ebsd = g * ebsd % rotates the EBSD data by orientation g
% ebsd = ebsd * v % rotate a vector3d v by EBSD data

%%  KAM

% kam = KAM(ebsd,'threshold',10*degree);
% plot(ebsd,ebsd.KAM./degree)
% 
% % ignore grain boundary misorientations
% [ebsd, ebsd.grainId] = calcGrains(ebsd)
% kam = KAM(ebsd);
% plot(ebsd,ebsd.KAM./degree)
% 
% % consider also second order neigbors
% kam = KAM(ebsd,'order',2);


%% Combining different plots can be done either by plotting only subsets of the ebsd data, 
% or via the option 'translucent'. Note that the option 'translucent' requires the renderer of the figure to be set to 'opengl'

% close all;
% plot(ebsd,ebsd.bc)
% mtexColorMap white2black
% 
% oM = ipdfCenterOrientationMapping(csFo);
% oM.inversePoleFigureDirection = zvector;
% oM.center = Miller(1,1,1,csFo);
% oM.color = [0 0 1];
% oM.psi = deLaValeePoussinKernel('halfwidth',7.5*degree);
% 
% hold on
% plot(ebsd('fo'),oM.orientation2color(ebsd('fo').orientations),'FaceAlpha',0.5)
% hold off

%% Color coding

% oM = ipdfHSVOrientationMapping(CS);
% plot(oM, 'antipodal')
%% 