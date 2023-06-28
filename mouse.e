note
	description: "Summary description for {MOUSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE

inherit
  THREAD
  	redefine
  		make
  	end

create
	make

feature{NONE}
make
do
    Precursor
    io.put_string("TESTETJESLTJLKESJTLKSET")
    alive := true
    inSubway := -1
    reachedFinal := false
    create currentPosition.make(1,1)
end

feature
	alive, reachedFinal: BOOLEAN
	inSubway: INTEGER
	currentPosition: POINT

	make_mouse(position: POINT)
	local
		graph: GRAPH
		dijkstra: DIJKSTRA
		tmp: LINKED_LIST[INTEGER]
		i: INTEGER
	do
    alive := true
    inSubway := -1
    reachedFinal := false
    currentPosition := position

	end

	kill
	do
		alive := false
	end

  execute
  do
    io.put_string("ASD")
  end

	step(board:BOARD)
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
				io.put_string_32("asdf")
				nextExit := graph.getexit (path.at (2))
				currentPosition.setx (nextExit.x)
				currentPosition.sety (nextExit.y)
			end
		end
	end


end
