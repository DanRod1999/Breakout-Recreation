b = randi(25)+10;
x = 1;
m = -1;
a=1;
y = m*x+b;



while(y>=0)
    
    xNew = x - (1);
    yNew = y - (1);
    
    xBall = [xNew,xNew+2,xNew+2,xNew,xNew];
    yBall = [yNew,yNew,yNew+2,yNew+2,yNew];
    
    x = x+a;
    y = m*x+b;
    %plot([0,100,100,0,0],[0,0,100,100,0],'b-');
    fill(xBall,yBall,'r-');

    if (y == 0 )
        b = -(y - m*x);
        m = m*(-1);
    elseif (x <= 0)
        m = m*(-1);
        a = 1;
    elseif (x >= 100)
        b= 2*y-b;
        m = -1*m;
        a = -1;
     elseif(y >= 100)
        b=2*y-b;
        m = m*(-1);
    end
    axis([-5,105 -5,105])
    pause(1/60);
    
end
    