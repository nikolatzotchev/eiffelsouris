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
		i, nearest, nearestNode: INTEGER
		stop: BOOLEAN
	do
		create visited.make_filled (false, 1, graph.matrix.width)
		create distances.make_filled (2147483647, 1, graph.matrix.width)
		create previous.make_filled (-1, 1, graph.matrix.width)

		distances[source] := 0
		io.put_string_32 ("WOS ")
		io.put_integer (target)
		io.put_string_32 (" SOW")

		from
			currentNode := minDistanceNode (visited, distances)
			stop := currentNode /= 1 and (currentNode-2) // board.exits = (target-2) // board.exits
		until
			currentNode /= 1 and ((currentNode-2) // board.exits) +1 = ((target-2) // board.exits) +1 or currentNode = -1
		loop
			visited[currentNode] := true
			io.put_integer (currentNode)
			io.put_boolean (stop)

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
			stop := currentNode /= 1 and (currentNode-2) // board.subways.count = (target-2) // board.subways.count
		end

		nearest := 2147483647
		nearestNode := target

		from
			i := 1
		until
			i > board.exits
		loop
			io.put_string (" B")
			io.put_integer (nearest)
			if distances[(final.id-1)*board.exits+1 +i] < nearest then
				nearest := distances[(final.id-1)*board.exits+1 +i]
				nearestNode := (final.id-1)*board.exits+1 +i
			end
			i := i+1
		end

		Result := reconstructPath (previous, nearestNode)
	end

	reconstructPath (previous: ARRAY [INTEGER]; target: INTEGER): LINKED_LIST [INTEGER]
        local
            path: LINKED_LIST [INTEGER]
            currentNode, i: INTEGER
        do
            create path.make

            io.put_string_32 ("AHA ")
            from
            	i := 1
            until
            	i > previous.count
            loop
            	io.put_integer (previous.at (i))
            	i := i+1
            end

            currentNode := target
            path.extend (currentNode)
            io.put_string_32 (" AHA ")

            from
                currentNode := previous.at (currentNode)
            until
                currentNode = -1
            loop
            	io.put_integer (currentNode)
                path.extend (currentNode)
                currentNode := previous.at (currentNode)
            end


            Result := reversePath(path)
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

	reversePath (path: LINKED_LIST[INTEGER]): LINKED_LIST[INTEGER]
	local
		reversed: LINKED_LIST[INTEGER]
		i: INTEGER
	do
		io.put_integer (path.count)
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
	end

end
