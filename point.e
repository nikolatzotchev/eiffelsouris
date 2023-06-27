note
	description: "Summary description for {POINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POINT
create
	make
feature
	x:INTEGER
	y:INTEGER

	make (x_, y_: INTEGER)
	do
		x := x_
		y := y_
	end

	setY(y_:INTEGER)
	do
		y:=y_
	end
	setX(x_:INTEGER)
	do
		x:=x_
	end

	distanceTo (point: POINT) : INTEGER
	local
		distanceX, distanceY, distance: INTEGER
	do
		distanceX:= x - point.x
		distanceY:= y - point.y
		distance := distanceX.abs + distanceY.abs
		Result := distance
	end

end
