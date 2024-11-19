function  [X,Y]=ode4(dy,xBound, y0, dX)

    X=xBound(1,1):dX:xBound(1,2);
    X=X';
    a=size(X);
    numX=a(1,1);
    
    b=size(y0);
    numY=b(2);
    Y=zeros(numX,numY);
    Y(1,:)=y0;

    num_out=100;
    delt_num=floor(numX/num_out);
    k=1;
    while(k<numX)
%         if (floor((k+1)/delt_num)-floor(k/delt_num)>0.5)
%             X(k)
%         end

        Xk=X(k);
        Yk=Y(k,:)';
        K1=dX*dy(Xk,Yk);
        K2=dX*dy(Xk+dX/2,Yk+K1/2);
        K3=dX*dy(Xk+dX/2,Yk+K2/2);
        K4=dX*dy(Xk+dX,Yk+K3);
        Y(k+1,:)=(Yk+(K1+2*K2+2*K3+K4)/6)';
        k=k+1;
    end
end