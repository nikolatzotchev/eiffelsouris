note
	description: "Summary description for {EXIT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXIT
inherit
	POINT

create
	makeExit

feature
	id: INTEGER

	makeExit (x_, y_, id_: INTEGER)
	do
		x := x_
		y := y_
		id := id_
	end

end
