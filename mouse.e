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
		board := board_

		create graph.make (CURRENT, board)
		--graph.printgraph
		io.put_string_32 ("qwer")
		create dijkstra.make (graph, board.getFinalSubway, board)
		tmp := dijkstra.dijkstra (1, (board.getfinalsubway.id-1) * board.subways.count + board.getfinalsubway.exits.at (1).id)

		from
			i := 1
		until
			i > tmp.count
		loop
			io.put_string_32 ("asd ")
			i := i+1
		end

	end


end
