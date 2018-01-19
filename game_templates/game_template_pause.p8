pico-8 cartridge // http://www.pico-8.com
made on v0.1.11g
__lua__
-- -your game title here-
-- by -your name here-

-- you can call reset_game function to go back to title screen

-- custom vars
gametitle="game title"
transparentpause=true
uitextcolor=7

-- draw your game here
function draw_game()
end

-- update your game here
function update_game()
end


-------------------------------
-------------------------------
---you don't need to change----
--------the code below---------
-------------------------------
-------------------------------
istitlescreen=true
ispaused=false

function start_game()
    istitlescreen=false
end

function reset_game()
    istitlescreen=true
    ispaused=false
end

function pause_game() 
    ispaused=true
end

function resume_game()
    ispaused=false
end

function _init()
end

function _update()
    if btnp(4) then
        if istitlescreen then 
            start_game()
        elseif ispaused then
            resume_game()
        elseif not ispaused then
            pause_game() 
        end
    elseif not ispaused and not istitlescreen then 
        update_game()
    end
end

function _draw()
    if istitlescreen then
        cls()
        draw_title_screen()
    elseif ispaused then
        draw_pause_menu()
    else
        cls()
        draw_game()
    end
end

function draw_title_screen()
    print(gametitle, 64 - ((#gametitle*4)/2), 40, uitextcolor)
	print("press a to start",32,75, uitextcolor)	
end

function draw_pause_menu()
    if not transparentpause then
        cls()
    end
    print('paused', 52, 40, uitextcolor)
	print("press a to resume",30,75, uitextcolor)	
end