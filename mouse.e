note
	description: "Summary description for {MOUSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE

create
	make

feature
	alive, reachedFinal: BOOLEAN
	inSubway: INTEGER
	currentPosition: POINT
	board: BOARD
	subwaysVisited: LINKED_LIST[INTEGER]

	make (position: POINT; board_: BOARD)
	local
		i,j: INTEGER
		graph: GRAPH
	do
		alive := true
		inSubway := -1
		reachedFinal := false
		currentPosition := position
		board := board_
		create subwaysVisited.make

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

				if currentPosition.distanceto (board.subways.at (i).exits.at (j)) = 0 then
					inSubway := board.subways.at (i).id
				end

				j := j+1
			end

			i := i+1
		end

		create graph.make (CURRENT, board)
		graph.printGraph
	end

	step
	local
		j, k, shortestDistance, distance: INTEGER
		point: POINT
		subwayId: INTEGER
	do

		shortestDistance := 2147483647
		from
			j := 1
		until
			j > board.subways.count
		loop

			from
				k := 1
			until
				k > board.subways.at (j).exits.count
			loop
				distance := currentPosition.distanceto (board.subways.at(j).exits.at(k))
				if distance < shortestDistance then
					point := board.subways.at (j).exits.at (k)
					shortestDistance := distance
					subwayid := board.subways.at(j).id
				end
				k := k+1
			end

			j := j+1

		end


	end



end
