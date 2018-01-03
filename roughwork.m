 cs = crystalSymmetry('-43m');
 ss=specimenSymmetry('mmm');
b=Miller(1,1,0,cs);
 n=Miller(1,-1,1,cs);
 R=SchmidTensor(n,b);
 sigma=EinsteinSum(tensor(1),1,tensor(2),2,'name','stress');
 m=double(EinsteinSum(R,[-1,-2],sigma,[-1,-2]));
 
 