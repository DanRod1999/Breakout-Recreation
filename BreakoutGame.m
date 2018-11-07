function [activefig] = BreakoutGame()

%close all; clear all; clc;
b = randi(34)+10;
x = 1;
m = -1;

ballSpeed =(1);
map = ones(4,10); %the block matrix to delete the collided boxes
move = 1;

y = m*x+b;

% Constants
speed = 1;

% Plot two squares
Paddlex = [0,10,20,20,0,0];
Paddley = [0,0,0,-3,-3,0];

left = 0;
blockTotal = 40;
activefig = figure('KeyPressFcn',@Key_Down,'KeyReleaseFcn',@Key_Up);

while (y > -1)
    %Ball placement in realtion to original plot
    xNew = x - (1);
    yNew = y - (1);
    
    %Ball Coordinates
    xBall = [xNew,xNew+2,xNew+2,xNew,xNew];
    yBall = [yNew,yNew,yNew+2,yNew+2,yNew];
  
    fill(xBall,yBall,'r.',Paddlex,Paddley,'g-'); %plot moving ball'
    blockX = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]; %coordinates of the blocks
    blockX_right = [9, 19, 29, 39, 49, 59, 69, 79, 89, 99];
    blockY = [80, 70, 60, 50];
    blockY_upper = [89, 79, 69, 59];

    %Moving the ball
    x = x + ballSpeed; %moving ball
    y = m * x + b; %ball trajectory
    
    if (x < -1) || (x > 101) || (y > 121) || (y < -1)
        break

    elseif (x >= 100) %if the ball hits the vertical wall
        b = 2 * y - b; %the ball change trajectory
        m = m * (-1);
        ballSpeed = -ballSpeed; %while changing the increment of x

    elseif (x <= 0) %if the ball hits the vertical wall

        m = m * (-1); %the ball change trajectory
        ballSpeed = -ballSpeed; %while changing the increment of x

    elseif (y >= 120) %if the ball hits the ceiling
        b = 2 * y - b; %the ball change trajectory
        m = m *(-1); 

    elseif ((y <= 0) && (x >= Paddlex(1)) && (x <= Paddlex(3))) %when the ball lands within the paddle

        if (x >= Paddlex(2)) %on the right side of the paddle

            if (m > 0) %if the ball comes from the right
                ballSpeed = -ballSpeed; %then the ball travels in the reverse direction

            else %if the ball comes from the left
                m = m * (-1); %then the ball change trajectory
                b = -b;
                
            end

        else %if(x<Paddlex(2)) as in the right side of the paddle

            if (m<0) %if the ball comes from the left
                ballSpeed = -ballSpeed; %then the ball travels in the reverse direction

            else %if the ball comes from the right
                m = m *(-1); %then the ball change trajectory
                b = -b;

            end
        end
        
    else
        %Horizontal collision
        yMatch = find(blockY == y);        
        yMatch_upper = find(blockY_upper == y);
        xMatch = find(blockX == x);
        xMatch_right = find(blockX_right == x);

        %to delete a block when hit from below
        if (isempty(yMatch) == 0) %when the y-coord of the ball reaches the blocks
            a = floor(x / 10) * 10; %find the x-coord of which block the ball is hitting
            k = find(blockX == a); %find whether the block still exists

            if (isempty(k) == 0) && (map(yMatch, k) == 1) %if the block exist
                map(yMatch, k) = 0; %set the position of that block to zero on the block matrix
                m = m * (-1); %change trajectory upon collision
                b = 2 * y - b;
                blockTotal = blockTotal - 1;                
            end

        %to delete a block when hit from above
        elseif (isempty(yMatch_upper) == 0)
            a = floor(x / 10) * 10; %find which block the ball is hitting
            k = find(blockX == a); %find whether the block still exists

            if (isempty(k) == 0) && (map(yMatch_upper, k) == 1) %if the block exist
                map(yMatch_upper, k) = 0; %set the position of that block to zero on the block matrix
                blockTotal = blockTotal - 1;              
                m = m * (-1); %change trajectory upon collision
                b = 2 * y - b;
            end
            
        %Vertical collision
        %to delete a block when hit from the left
        elseif (isempty(xMatch) == 0)
            a = floor(y / 10) * 10; %find the position of the ball
            k = find(blockY == a); %find whether the block (still) exists

            if (isempty(k) == 0) && (map(k, xMatch) == 1) %if the block exist
                map(k, xMatch) = 0; %set the position of that block to zero                
                blockTotal = blockTotal - 1;
                m = m * (-1); %change trajectory upon collision
                b = 2 * y - b;
                ballSpeed = -ballSpeed;           
            end
            
        %to delete a block when hit from the right

        elseif (isempty(xMatch_right) == 0)
            a = floor(y / 10) * 10; %find the position of the ball
            k = find(blockY == a); %find whether the block (still) exists
            
            if (isempty(k) == 0) && (map(k, xMatch_right) == 1) %if the block exist
                map(k, xMatch_right) = 0; %set the position of that block to zero
                blockTotal = blockTotal - 1;
                m = m * (-1); %change trajectory upon collision
                b = 2 * y - b;
                ballSpeed = -ballSpeed;
            end
        end
    end
        
    % Calculate new blue square position
    Paddlex = Paddlex + (left * speed);
    
    if Paddlex(1) < 0
        Paddlex = [0,10,20,20,0,0];

    elseif Paddlex(3) > 100
       Paddlex = [80,90,100,100,80,80]; 

    end

    %Plotting the blocks
    % plot new values

    rectangle('position', [0,0,100,120]); %the walls of the game
    axis([-5,105 -5,125])
        
        for i = 1:size(map, 1) %loop through the rows
            for j = 1:size(map, 2) %and the columns
                if map(i, j) > 0 %plot a block as long as the block matrix indicates its position as 1
                    rectangle('Position', [blockX(j), blockY(i), 9, 9], 'Facecolor', 'b');
          
                end
            end
        end
        %hold off
                
    if blockTotal == 0
        break
    end
    
    pause(1/40);     

end

if blockTotal > 0
    message = { 'Mamma Mia! You lose!' };
    msgbox(message);
    
else
    message = { 'Huzzah! You win!' };
    msgbox(message)
    
end

function [] =  Key_Down(src,event)

      user_var=event.Key;

      if (strcmp(user_var,'0')==1)
          disp('out')
          close all;

      elseif strcmp(user_var,'leftarrow')==1
          left = -1;

      elseif strcmp(user_var,'rightarrow')==1
          left = 1;

      end    
end

 function [] = Key_Up(~,~)
     left = 0;

 end
end