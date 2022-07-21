function cmap = bluered(length)
%BLUERED blue-white-red colormap
%   BLUERED(M) returns an M-by-3 matrix containing a "bluered" colormap
%   similar to the one in the defunct program Transform.
%       --PTM 6/18/12
if nargin < 1, length = size(get(gcf,'colormap'),1); end
cmap=zeros(length,3);

q1=floor(length/2-length/4);
q2=floor(length/2);
q3=floor(length/2+length/4);

mincolor=0.5;

cmap(1:q1,3)=linspace(mincolor,1,q1);

cmap(q1+1:q2,1)=linspace(0,1,q2-q1);
cmap(q1+1:q2,2)=linspace(0,1,q2-q1);
cmap(q1+1:q2,3)=1;

cmap(q2+1:q3,1)=1;
cmap(q2+1:q3,2)=linspace(1,0,q3-q2);
cmap(q2+1:q3,3)=linspace(1,0,q3-q2);

cmap(q3+1:end,1)=linspace(1,mincolor,length-q3);
