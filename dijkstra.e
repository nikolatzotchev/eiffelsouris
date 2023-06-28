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

	-- calculates the shortest distance to the final subway
	-- returns an array of nodes
	dijkstra (source: INTEGER; target: INTEGER): LINKED_LIST [INTEGER]
	local
		visited: ARRAY [BOOLEAN]
		distances: ARRAY [INTEGER]
		previous: ARRAY [INTEGER]
		currentNode, distance: INTEGER
		i, nearest, nearestNode: INTEGER
	do
		create visited.make_filled (false, 1, graph.matrix.width)
		create distances.make_filled (2147483647, 1, graph.matrix.width)
		create previous.make_filled (-1, 1, graph.matrix.width)

		distances[source] := 0

		from
			currentNode := minDistanceNode (visited, distances)
		until
			currentNode /= 1 and ((currentNode-2) // board.exits) +1 = ((target-2) // board.exits) +1 or currentNode = -1
		loop
			visited[currentNode] := true

			from
				i := 1
			until
				i > graph.matrix.width
			loop
				if not visited.at (i) then
					distance := distances.at (currentNode) + graph.matrix[currentNode,i]
					if distance < distances.at (i) then
						distances[i] := distance
						previous[i] := currentNode
					end
				end
				i := i+1
			end

			currentNode := minDistanceNode (visited, distances)
		end

		nearest := 2147483647
		nearestNode := target

		from
			i := 1
		until
			i > board.exits
		loop
			if distances[(final.id-1)*board.exits+1 +i] < nearest then
				nearest := distances[(final.id-1)*board.exits+1 +i]
				nearestNode := (final.id-1)*board.exits+1 +i
			end
			i := i+1
		end

		Result := reconstructPath (previous, nearestNode)
	end

	-- reconstructs the path from target to actual position
	reconstructPath (previous: ARRAY [INTEGER]; target: INTEGER): LINKED_LIST [INTEGER]
        local
            path: LINKED_LIST [INTEGER]
            currentNode: INTEGER
        do
            create path.make

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


            Result := reversePath(path)
        end

	-- gets the node with the minimal distance that is not visited
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

	-- reverses the path and removes the start position (last from the reconstructed path)
	reversePath (path: LINKED_LIST[INTEGER]): LINKED_LIST[INTEGER]
	require
		path.count > 1
	local
		reversed: LINKED_LIST[INTEGER]
		i: INTEGER
	do
		create reversed.make
		from
			i := path.count-1
		until
			i < 1
		loop
			reversed.extend (path.at (i))
			i := i-1
		end

		Result := reversed
	ensure
		Result.count = path.count -1
	end

end
