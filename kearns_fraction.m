clear;
close;

%% Import Script for PoleFigure Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = crystalSymmetry('6/mmm', [1 1 1.593], 'X||a*', 'Y||b', 'Z||c', 'color', 'light blue');

% specimen symmetry
SS = specimenSymmetry('1');

% plotting convention
setMTEXpref('xAxisDirection','north');
setMTEXpref('zAxisDirection','outOfPlane');

%% Specify File Names

% path to files
pname = 'C:\Documents and Settings\nilesh\My Documents\MATLAB\MKY1\mtex_practice\CR-1700-10';

% which files to be imported
fname = {...
  [pname '\0002.TXT'],...
  [pname '\01-11.TXT'],...
  [pname '\01-12.TXT'],...
  [pname '\01-13.TXT'],...
  };

%% Specify Miller Indice

h = { ...
  Miller(0,0,0,2,CS),...
  Miller(0, 1,-1, 1,CS),...
  Miller(0, 1,-1, 2,CS),...
  Miller(0, 1,-1, 3,CS),...
  };

%% Import the Data

% create a Pole Figure variable containing the data
pf = loadPoleFigure(fname,h,CS,SS,'interface','rigaku_txt');

%%
% condition = (pf.r.theta) > 70*degree;
% 
% % cap the values in the pole figures
% pf(condition)= [];
% 
% rot = rotation('axis', zvector, 'angle',0*degree);
% pf = rotate(pf, rot);

%%
odf = calcODF(pf, 'resolution',5*degree);

% plotPDF(odf,h,'contourf','complete','colorrange',[1,8],'antipodal','linewidth',2.5)

%% Calculate kearn's fractions from the odf

ori = calcOrientations(odf,10000);
m = Miller(0,0,0,2,CS);
basal = ori*m;
X = angle(basal,xvector)/degree;
Y = angle(basal,yvector)/degree;
Z = angle(basal,zvector)/degree;

xcount = 0;
ycount = 0;
zcount = 0;

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
Fx = xcount/10000;
Fy = ycount/10000;
Fz = zcount/10000;