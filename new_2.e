note
	description: "Summary description for {SUBWAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUBWAY

create
	make

feature
	exits: LINKED_LIST [POINT]
	isFinal: BOOLEAN
	id: INTEGER

	make (id_: INTEGER)
	do
		id := id_
		isFinal := false
		create exits.make
	end

	addExit (point: POINT)
	do
		exits.extend (point)
	end

	setFinal (isFinal_: BOOLEAN)
	do
		isFinal := isFinal_
	end

end
