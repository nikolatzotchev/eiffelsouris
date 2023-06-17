note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

create
	make
feature --??????
	cells: INTEGER
	catLocation: POINT

	display
	local
            i, j: INTEGER
	do
		print("%/27/[2J")
	    from
                i := 1
            until
                i > cells
            loop
                from
                    j := 1
                until
                    j > cells
                loop
                	if i = catLocation.x and j = catLocation.y then
 						io.put_string_32("%/0x1F638/")

 					else
 						io.put_string_32("%/0x25FC/ ")
                	end
                    j := j + 1
                end
                print("%N")
                i := i + 1
            end
	end

	move_cat_up
	do
		if catLocation.x > 1 then
			catLocation.setX(catLocation.x - 1)
		end
	end
	move_cat_left
	do
		if catLocation.y > 1 then
			catLocation.setY(catLocation.y - 1)
		end
	end
	move_cat_down
	do
		if catLocation.x < cells then
			catLocation.setX(catLocation.x + 1)
		end
	end
	move_cat_right
	do
		if catLocation.y < cells then
			catLocation.setY(catLocation.y + 1)
		end
	end
feature {NONE} -- Initialization

	make(c: INTEGER)
			-- Initialization for `Current'.
			local
			randomGenerator: RANDOM
			initX: INTEGER
			initY: INTEGER
		do
			cells := c

	        create randomGenerator.set_seed (4) -- ... is the initial "seed"
	        randomGenerator.start
	        initX := randomGenerator.item \\ c + 1
	        randomGenerator.forth
	 		initY := randomGenerator.item \\ c + 1

			create catLocation.make(initX, initY)
		end

end
