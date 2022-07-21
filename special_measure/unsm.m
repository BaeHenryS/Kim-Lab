function [data] = unsm(smfile)

if nargin==0
    [filename,pathname,filterindex]=uigetfile('*.mat');
    st = open(filename);
else
    st = open([smfile '.mat']);
end

for i=1:length(st.scan.consts)
    s=st.scan.consts(i).setchan;
    s(ismember(s,' ,.:;!')) = [];
    data.(sprintf('%s',s))=st.scan.consts(i).val;
end

for i=1:length(st.scan.loops)
    s=st.scan.loops(i).setchan{1};
    s(ismember(s,' ,.:;!')) = [];
    data.(sprintf('%s',s))=linspace(st.scan.loops(i).setchanranges{1}(1),st.scan.loops(i).setchanranges{1}(2),st.scan.loops(i).npoints)';
end

numinloop=zeros(size(st.scan.loops));
for i=1:length(st.scan.loops)
    numinloop(i)=length(st.scan.loops(i).getchan);
end

cellnum = 1;

for i=1:length(numinloop)
    for j=1:numinloop(i)
        s=st.scan.loops(i).getchan{j};
        s(ismember(s,' ,.:;!')) = [];
        data.(sprintf('%s',s)) = st.data{cellnum};
        cellnum = cellnum + 1;
    end
end


data.comments=st.scan.comments;