function [uDer] = uPartDerT(t,u,landa,hxy)
    
    dimU=size(u);
    uDer=zeros(dimU);
    
    uDer(:,:,1)=u(:,:,2);
    
    for xi=2:dimU(1)-1
        for yi=2:dimU(2)-1
            partDerX=(u(xi-1,yi,1)-2*u(xi,yi,1)+u(xi+1,yi,1))/(hxy(1)^2);
            partDerY=(u(xi,yi-1,1)-2*u(xi,yi,1)+u(xi,yi+1,1))/(hxy(2)^2);
            uDer(xi,yi,2)=partDerX+partDerY;
            
        end
    end
    uDer=landa*uDer;
    
end

