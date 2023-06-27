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
	exits: LINKED_LIST [EXIT]
	isFinal: BOOLEAN
	id: INTEGER

	make (id_: INTEGER)
	do
		id := id_
		isFinal := false
		create exits.make
	end

	addExit (exit: EXIT)
	do
		exits.extend (exit)
	end

	setFinal (isFinal_: BOOLEAN)
	do
		isFinal := isFinal_
	end

end
