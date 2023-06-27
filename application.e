note
	description: "project application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization
	board: BOARD
	make
			-- Run application.
		local
			c: CHARACTER
		do
			create board.make (20, 3, 5)
			board.display
			game_loop
		end
	game_loop
		local
			c: CHARACTER
		do
			from
					-- Your loop body code here

			until
				False
			loop
				c := read_char
				if c = 'a' then
					board.move_cat_left
				elseif c = 'd' then
					board.move_cat_right
				elseif c = 's' then
					board.move_cat_down
				elseif c = 'w' then
					board.move_cat_up
				end
				board.display
					-- Your loop body code heress
			end
		end
	read_char: CHARACTER
			-- Read a character from a console without waiting for Enter.
		external "C++ inline use <curses.h>, <iostream>, <termios.h>, <unistd.h> "
		alias "{
        			struct termios oldSettings, newSettings;
    				tcgetattr(STDIN_FILENO, &oldSettings);
    				newSettings = oldSettings;
    				newSettings.c_lflag &= ~(ICANON | ECHO);
    				tcsetattr(STDIN_FILENO, TCSANOW, &newSettings);
    				char ch;
    				read(STDIN_FILENO, &ch, 1);
					tcsetattr(STDIN_FILENO, TCSANOW, &oldSettings);
    				return ch;
			}"
		end

end
