note
	description: "Summary description for {DIJKSTRA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIJKSTRA

create
	make

feature
	graph: GRAPH
	final: SUBWAY
	board: BOARD

	make (graph_: GRAPH; final_: SUBWAY; board_: BOARD)
	do
		graph := graph_
		final := final_
		board := board_
	end

	dijkstra (source: INTEGER; target: INTEGER): LINKED_LIST [INTEGER]
	local
		visited: ARRAY [BOOLEAN]
		distances: ARRAY [INTEGER]
		previous: ARRAY [INTEGER]
		currentNode, distance: INTEGER
		i: INTEGER
	do
		create visited.make_filled (false, 1, graph.matrix.width)
		create distances.make_filled (2147483647, 1, graph.matrix.width)
		create previous.make_filled (0, 1, graph.matrix.width)

		distances[source] := 0

		from
			currentNode := minDistanceNode (visited, distances)
		until
			currentNode / board.subways.count = target / board.subways.count or currentNode = -1
		loop
			visited[currentNode] := true

			from
				i := 1
			until
				i > graph.matrix.width
			loop
				if not visited.at (i) then
					distance := distances.at (i) + graph.matrix[currentNode,i]
					if distance < distances.at (i) then
						distances[i] := distance
						previous[i] := currentNode
						io.put_string_32 ("A")
						io.put_integer (currentNode)
						io.put_integer (distances)
					end
				end
				i := i+1
			end

			currentNode := minDistanceNode (visited, distances)
		end

		Result := reconstructPath (previous, target)
	end

	reconstructPath (previous: ARRAY [INTEGER]; target: INTEGER): LINKED_LIST [INTEGER]
        local
            path: LINKED_LIST [INTEGER]
            currentNode,i: INTEGER
        do
            create path.make

            io.put_string_32 ("%N")

            from
            	i := 1
            until
            	i > previous.count
            loop
            	io.put_integer (previous.at(i))
            	i := i+1
            end

            currentNode := target
            path.extend (currentNode)

            from
                currentNode := previous.at (currentNode)
            until
                currentNode = -1
            loop
                path.extend (currentNode)
                currentNode := previous.at (currentNode)
            end

            --path.reverse
            Result := path
        end

	minDistanceNode (visited: ARRAY [BOOLEAN]; distances: ARRAY [INTEGER]): INTEGER
    local
		minDistance, minNode, node: INTEGER
	do
		minDistance := 2147483647
		minNode := -1

		from
			node := 1
		until
			node > graph.matrix.width
		loop
			if not visited.at (node) and distances.at (node) < minDistance then
				minDistance := distances.item (node)
				minNode := node
			end
			node := node + 1
		end

		Result := minNode
	end

end
