note
	description: "Summary description for {GRAPH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPH

create
	make

feature
	mouse: MOUSE
	board: BOARD
	matrix: ARRAY2[INTEGER]

	-- calculates a matrix that has the distances from every node (subway exit) to each other
	-- at index 1 is the distance from the currentPosition of the mouse
	make (mouse_: MOUSE; board_: BOARD)
	local
		i,j,k,l, distance, size, subwayCount: INTEGER
	do
		mouse := mouse_
		board := board_

		size := 1 + board.subways.count * board.exits

		create matrix.make_filled (0, size, size)

		from
			i := 1
		until
			i > board.subways.count
		loop

			from
				j := 1
			until
				j > board.subways.at (i).exits.count
			loop

				if mouse.insubway = board.subways.at(i).id then
					--create pair.make (board.subways.at(i).exits.at(j), distance)
					matrix [1, ((board.subways.at (i).id-1)*board.exits + board.subways.at(i).exits.at(j).id +1)] := 0
					matrix [((board.subways.at(i).id-1)*board.exits + board.subways.at(i).exits.at(j).id +1), 1] := 0
				end
				if mouse.insubway = -1 then
					distance := mouse.currentposition.distanceto (board.subways.at(i).exits.at(j))
					--create pair.make (board.subways.at(i).exits.at(j), distance)
					matrix [1, ((board.subways.at(i).id-1)*board.exits + board.subways.at(i).exits.at(j).id +1)] := distance
					matrix [((board.subways.at(i).id-1)*board.exits + board.subways.at(i).exits.at(j).id +1), 1] := distance
				end

				j := j+1
			end

			i := i+1
		end

		from
			i := 1
		until
			i > board.subways.count
		loop

			from
				j := 1
			until
				j > board.subways.at (i).exits.count
			loop

				from
					k := 1
				until
					k > board.subways.count
				loop

					from
						l := 1
					until
						l > board.subways.at (k).exits.count
					loop

						if board.subways.at (i).id = board.subways.at (k).id then
							distance := 0
						else
							distance := board.subways.at(i).exits.at(j).distanceto (board.subways.at(k).exits.at(l))
						end

						matrix [((board.subways.at(i).id-1)*board.exits+board.subways.at(i).exits.at(j).id +1),((board.subways.at(k).id-1)*board.exits+board.subways.at(k).exits.at(l).id +1)] := distance
						matrix [((board.subways.at(k).id-1)*board.exits+board.subways.at(k).exits.at(l).id +1),((board.subways.at(i).id-1)*board.exits+board.subways.at(i).exits.at(j).id +1)] := distance

						l := l+1
					end

					k := k+1
				end

				j := j+1
			end

			i := i+1
		end

	end

	-- get the respective exit from an index
	-- calculated by (subwayId-1)*number of exits + exitId +1
	getExit(marker: INTEGER): EXIT
	local
		exit: EXIT
		i,j: INTEGER
	do
		create exit.makeexit (0, 0, -1)
		from
			i := 1
		until
			i > board.subways.count
		loop
			if board.subways.at(i).id = (marker-2) // board.exits +1 then
				from
					j := 1
				until
					j > board.subways.at(i).exits.count
				loop
					if board.subways.at(i).exits.at(j).id = (marker-2) \\ board.exits +1 then
						exit := board.subways.at(i).exits.at(j)
					end
					j := j+1
				end
			end
			i := i+1
		end

		RESULT := exit
	end

	-- prints the distance matrix
	-- nly for testing purposes
	printGraph
	local
		i,j: INTEGER
	do
		from
			i := 1
		until
			i > matrix.height
		loop
			from
				j := 1
			until
				j > matrix.width
			loop
				io.put_integer (matrix[i,j])
				io.put_string_32 (" ")
				j := j+1
			end
			io.put_string_32 ("%N")
			i := i+1
		end
		io.put_string_32 ("%N")
	end

end
