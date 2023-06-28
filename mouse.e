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

	make (position: POINT; board_: BOARD)
	do
		alive := true
		inSubway := -1
		reachedFinal := false
		currentPosition := position
		board := board_

		-- getPath
	end

	-- prints the shortest path (only nodes)
	-- test purposes
	getPath
	local
		graph: GRAPH
		dijkstra: DIJKSTRA
		tmp: LINKED_LIST[INTEGER]
		i: INTEGER
	do

		create graph.make (CURRENT, board)
		--graph.printgraph
		create dijkstra.make (graph, board.getFinalSubway, board)
		tmp := dijkstra.dijkstra (1, (board.getfinalsubway.id-1) * board.subways.count + board.getfinalsubway.exits.at (1).id)

		io.put_string_32 ("%N")
		from
			i := 1
		until
			i > tmp.count
		loop
			io.put_integer (tmp[i])
			io.put_string_32 (" ")
			i := i+1
		end

	end

	kill
	do
		alive := false
	end

	-- calculates the dijkstra
	-- goes one step nearer to the next node
	step
	local
		graph: GRAPH
		dijkstra: DIJKSTRA
		path : LINKED_LIST[INTEGER]
		nextExit: EXIT
	do
		create graph.make (CURRENT, board)
		create dijkstra.make (graph, board.getfinalsubway, board)
		path := dijkstra.dijkstra (1, (board.getfinalsubway.id-1) * board.exits + 2)
		nextExit := graph.getexit (path.at (1))
		if currentPosition.x < nextExit.x then
			currentPosition.setx (currentPosition.x +1)
		elseif currentPosition.x > nextExit.x then
			currentPosition.setx (currentPosition.x -1)
		elseif currentPosition.y < nextExit.y then
			currentPosition.sety (currentPosition.y +1)
		elseif currentPosition.y > nextExit.y then
			currentPosition.sety (currentPosition.y -1)
		elseif currentPosition.distanceto (nextExit) = 0 then
			if path.count = 1 then
				reachedFinal := true
			else
				nextExit := graph.getexit (path.at (2))
				currentPosition.setx (nextExit.x)
				currentPosition.sety (nextExit.y)
			end
		end
	end


end
