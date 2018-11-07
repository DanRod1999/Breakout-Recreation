Paddlex = [0,10,10,0,0];
Paddley = [0,0,-3,-3,0];
move = 2;

while(Paddlex(2) ~= 100)
    Paddlex = Paddlex + 0;
w = waitforbuttonpress;
if w
    p = get(gcf, 'CurrentCharacter');
    
        if(p == 29 && Paddlex(2) < 100)
            Paddlex = Paddlex + move;
        
        elseif(p == 28 && Paddlex(1) >=  0 )
            Paddlex = Paddlex + (-move);
        
    else
        Paddlex = Paddlex + 0;
        
   
        end
end
    fill(Paddlex,Paddley,'c');
    axis([-5,105 -5,105]);
pause(1/120);
end

