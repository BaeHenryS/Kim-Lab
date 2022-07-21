function [] = arblinecut(plothandle)
%ARBLINECUT Linecut in an arbitrary direction of data on a 2D grid
%   ARBLINECUT(H) enables mouse selection of an arbitrary line through a
%   surf or pcolor plot. Data along this line is interpolated and plotted
%   in a new figure. H must be the handle to a plot object. Once ARBLINECUT
%   is called, click on the plot at one endpoint of the desired linecut and
%   drag to the other endpoint, then release. Right click on the plot to
%   stop ARBLINECUT.

%   --PTM 7/2/12

hand.pcolor=0;
hand.mainplot=plothandle;
hand.mainax=get(hand.mainplot,'Parent');
hand.mainfig=get(hand.mainax,'Parent');
hand.Xdata=get(hand.mainplot,'Xdata');
hand.Ydata=get(hand.mainplot,'Ydata');
hand.Zdata=get(hand.mainplot,'Zdata');
if all(hand.Zdata(:)==0)
    hand.Zdata=get(hand.mainplot,'Cdata');
    hand.pcolor=1;
end

set(hand.mainfig,'WindowButtonDownFcn',{@MouseDown,hand})
set(hand.mainfig,'WindowButtonUpFcn',@MouseUp)


guidata(hand.mainfig, hand);
end

function MouseDown(src,eventData, hand)
clickType = get(src, 'SelectionType');
if strcmp(clickType,'alt')
    set(hand.mainfig,'WindowButtonDownFcn',{})
    set(hand.mainfig,'WindowButtonUpFcn',{})
else
    point=get(hand.mainax,'CurrentPoint');
    hand.origx=point(1,1); hand.origy=point(1,2);
    hand.line=line([hand.origx hand.origx], [hand.origy hand.origy]);
    guidata(src,hand);
    set(hand.mainfig,'WindowButtonMotionFcn',{@MouseMove,hand})
end
end

function MouseMove(src,eventData,hand)
point=get(hand.mainax,'CurrentPoint');
set(hand.line,'XData',[hand.origx point(1,1)]);
set(hand.line,'YData',[hand.origy point(1,2)]);
end

function MouseUp(src,eventData)
hand=guidata(src);
xdata=get(hand.line,'XData');ydata=get(hand.line,'YData');
arbxaxis=linspace(xdata(1),xdata(2),200);
arbyaxis=linspace(ydata(1),ydata(2),200);
arbline=interp2(hand.Xdata,hand.Ydata,hand.Zdata,arbxaxis,arbyaxis);
figure;
cutaxes=axes;
cutplot=plot(cutaxes,arbxaxis,arbline);
set(hand.mainfig,'WindowButtonMotionFcn',{});
p=polyfit(xdata,ydata,1);
set(get(cutaxes,'Title'),'String',['y = ' num2str(p(1)) 'x + ' num2str(p(2))]);
end