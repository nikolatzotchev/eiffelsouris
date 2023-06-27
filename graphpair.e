note
	description: "Summary description for {GRAPHPAIR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHPAIR

create
	make

feature
	point: POINT
	value: INTEGER

	make (point_: POINT; value_: INTEGER)
	do
		point := point_
		value := value_
	end

end
