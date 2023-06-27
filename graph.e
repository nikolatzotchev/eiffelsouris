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

	make (mouse_: MOUSE; board_: BOARD)
	local
		i,j,k,l, distance, counter, subwayCount: INTEGER
	do
		mouse := mouse_
		board := board_

		counter := 1
		subwayCount := board.subways.count

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
				counter := counter +1
				j := j+1
			end

			i := i+1
		end

		create matrix.make_filled (0, counter, counter)

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
					matrix [1, ((i-1)*board.subways.count + j +1)] := 0
					matrix [((i-1)*board.subways.count + j +1), 1] := 0
				end
				if mouse.insubway = -1 then
					distance := mouse.currentposition.distanceto (board.subways.at(i).exits.at(j))
					--create pair.make (board.subways.at(i).exits.at(j), distance)
					matrix [1, ((i-1)*board.subways.count + j +1)] := distance
					matrix [((i-1)*board.subways.count + j +1), 1] := distance
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

						matrix [((i-1)*board.subways.count+j +1),((k-1)*board.subways.count+l +1)] := distance
						matrix [((k-1)*board.subways.count+l +1),((i-1)*board.subways.count+j +1)] := distance

						l := l+1
					end

					k := k+1
				end

				j := j+1
			end

			i := i+1
		end

	end

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
