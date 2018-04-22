clear;
clc;

%-------------------------------------
%Variabler

%f0
f0Funk = @(x,y) peaks(x,y);

%Rand
intervallXY=[-5 5; -5 5];

%Antall punkter xu
antallPunkterXY=[80 80];

%TidsInterval
intervallT=[0 20];

%Antall steg i tiden
antallSteg=intervallT(2)*24;

%Hvor u skal plottes
intervallU=[-5 5];

%Landa
landa=0.5;


%----------------------------------------

%Lager tn,xn,yn
tn=linspace(intervallT(1),intervallT(2),antallSteg+1);
xn=linspace(intervallXY(1,1),intervallXY(1,2),antallPunkterXY(1));
yn=linspace(intervallXY(2,1),intervallXY(2,2),antallPunkterXY(2));

hxy(1)=xn(2)-xn(1);
hxy(2)=yn(2)-yn(1);
h=tn(2)-tn(1);

%Lager u
u=zeros(antallPunkterXY(1),antallPunkterXY(2),2,antallSteg+1);

for xi=2:antallPunkterXY(1)-1
    for yi=2:antallPunkterXY(2)-1
        u(xi,yi,1,1)=f0Funk(xn(xi),yn(yi));
    end
end

uDerfunk = @(t,u) uPartDerT(t,u,landa,hxy);

%-------------------------------------------
%Tar euler steg
for i=1:antallSteg
    u(:,:,:,i+1)=u(:,:,:,i)+h*uDerfunk(tn(i),u(:,:,:,i));
end


%------------------------------------------
%Plotter resualtet


%Lager vektor til axis
axisVektor(1:2)=intervallXY(1,:);
axisVektor(3:4)=intervallXY(2,:);
axisVektor(5:6)=intervallU;

minfigur=figure('CloseRequestFcn',@stopProgramMedKlikk,'units','normalized','outerposition',[0 0 1 1]);
global tegnMere;
tegnMere=true;

%Video capture
v = VideoWriter('last_captured_video.avi');
v.FrameRate=round(1/h);
open(v);


for i=1:antallSteg+1
    if tegnMere
        surf(xn,yn,u(:,:,1,i));%'EdgeColor','none');
        axis(axisVektor);
        frame = getframe(minfigur);
        writeVideo(v,frame);
        %pause(h);
    end
end

close(v);


