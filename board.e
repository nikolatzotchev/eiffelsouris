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
	cells, exits: INTEGER
	catLocation: POINT
	subways: LINKED_LIST [SUBWAY]
	mice: LINKED_LIST [MOUSE]
	finished: BOOLEAN

	display
		local
			i, j, k, l, m, s: INTEGER
			subwayFound, isFinal, mouseFound: BOOLEAN

		do
			io.put_integer (subways.count)
			io.put_string_32 ("%N")
			print ("%/27/[2J")
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

					s := 0
					subwayFound := false
					isFinal := false

					from
						k := 1
					until
						k > subways.count
					loop

						from
							l := 1
						until
							l > subways.at (k).exits.count
						loop
							if j = subways.at (k).exits.at (l).x and i = subways.at (k).exits.at (l).y then
								subwayFound := true
								--s := (subways.at (k).id -1) * 3 + subways.at (k).exits.at (l).id
								if subways.at (k).isfinal then
									isFinal := true
								end
							end
							l := l + 1
						end
						k := k + 1

					end

					mouseFound := false

					from
						m := 1
					until
						m > mice.count
					loop
						if mice.at (m).alive and j = mice.at (m).currentposition.x and i = mice.at (m).currentposition.y and not mice.at (m).reachedfinal then
							mouseFound := true
						end
						m := m + 1
					end

					if j = catLocation.x and i = catLocation.y then
						io.put_string_32 ("C ")
					else
						if mouseFound then
							io.put_string_32 ("M ")
						else
							if subwayFound then
								if isFinal then
									io.put_string_32 ("F ")
								else
									io.put_string_32 ("0 ")
								end
							else
								io.put_string_32 ("%/0x25FC/ ")
							end
						end
					end
					j := j + 1
				end
				print ("%N")
				i := i + 1
			end
		end

	move_cat_up
		do
			if catLocation.y > 1 then
				catLocation.setY (catLocation.y - 1)
			end
		end
	move_cat_left
		do
			if catLocation.x > 1 then
				catLocation.setX (catLocation.x - 1)
			end
		end
	move_cat_down
		do
			if catLocation.y < cells then
				catLocation.setY (catLocation.y + 1)
			end
		end
	move_cat_right
		do
			if catLocation.x < cells then
				catLocation.setX (catLocation.x + 1)
			end
		end

	make (c, s, e, m: INTEGER)
			-- Initialization for `Current'.
		local
			randomGenerator: RANDOM
			initX: INTEGER
			initY: INTEGER
			index, mouseIndex: INTEGER
			finalSubway: INTEGER
		do
			finished := false
			cells := c
			exits := e

			create randomGenerator.set_seed (8) -- ... is the initial "seed"
			randomGenerator.start
			initX := randomGenerator.item \\ c + 1
			randomGenerator.forth
			initY := randomGenerator.item \\ c + 1

			create catLocation.make (initX, initY)
			create subways.make

			from
				index := 1
			until
				index > s
			loop
				addRandomSubway (index, c, randomGenerator)
				index := index + 1
			end

			randomGenerator.forth
			finalSubway := randomGenerator.item \\ s + 1

			subways.at (finalSubway).setFinal (true)

			create mice.make

			from
				mouseIndex := 1
			until
				mouseIndex > m
			loop
				addRandomMouse (c, randomGenerator)
				mouseIndex := mouseIndex + 1
			end

		end

	addRandomMouse (c: INTEGER; randomGenerator: RANDOM)
		local
			mouse: MOUSE
			point: POINT
			initX, initY: INTEGER
		do

			randomGenerator.forth
			initX := randomGenerator.item \\ c + 1
			randomGenerator.forth
			initY := randomGenerator.item \\ c + 1
			create point.make (initX, initY)

			create mouse.make (point, Current)

			mice.extend (mouse)

			io.put_string ("mouse created%N")

		end

	addRandomSubway (id, c: INTEGER; randomGenerator: RANDOM)
		local
			subway: SUBWAY
			index: INTEGER
			initX: INTEGER
			initY: INTEGER
			exit: EXIT
		do
			create subway.make (id)

			from
				index := 1
			until
				index > exits
			loop

				randomGenerator.forth
				initX := randomGenerator.item \\ c + 1
				randomGenerator.forth
				initY := randomGenerator.item \\ c + 1
				create exit.makeExit (initX, initY, index)
				subway.addExit (exit)

				index := index + 1

			end

			subways.extend (subway)

		end

	getFinalSubway: SUBWAY
		local
			subway: SUBWAY
			i: INTEGER
		do
			create subway.make (-1)
			from
				i := 1
			until
				i > subways.count
			loop
				if subways.at (i).isFinal then
					subway := subways.at (i)
				end
				i := i + 1
			end

			RESULT := subway
		end

	updateGameStatus
	local
		i, dead, final: INTEGER
	do

		dead := 0
		final := 0
		from
			i := 1
		until
			i > mice.count
		loop
			if mice.at (i).alive then
				if mice.at (i).currentposition.distanceto (catLocation) = 0 then
					if not mice.at (i).reachedfinal then
						mice.at (i).kill
					end
				else
					mice.at (i).step
					if mice.at (i).currentposition.distanceto (catLocation) = 0 and not mice.at (i).reachedfinal then
						mice.at (i).kill
					end
				end
				if mice.at (i).alive and mice.at (i).reachedfinal then
					final := final +1
				end
			else
				dead := dead+1
			end

			i := i+1
		end

		if dead + final = mice.count then
			finished := true
		end

	end

	hasReachedFinal (mouse: MOUSE): BOOLEAN
	local
		final: BOOLEAN
		i: INTEGER
		finalSubway: SUBWAY
	do
		final := false
		finalSubway := getFinalSubway
		from
			i := 1
		until
			i > finalSubway.exits.count
		loop
			if mouse.currentposition.distanceto (finalSubway.exits.at (i)) = 0 then
				final := true
			end
			i := i+1
		end

		Result := final
	end

	getKilledMice: INTEGER
	local
		i, kills: INTEGER
	do
		kills := 0

		from
			i := 1
		until
			i > mice.count
		loop
			if not mice.at (i).alive then
				kills := kills +1
			end
			i := i+1
		end

		Result := kills
	end

	getFinalMice: INTEGER
	local
		i, final: INTEGER
	do
		final := 0

		from
			i := 1
		until
			i > mice.count
		loop
			if mice.at (i).alive and mice.at (i).reachedfinal then
				final := final +1
			end
			i := i+1
		end

		Result := final
	end

end
