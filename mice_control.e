note
	description: "Summary description for {MICE_CONTROL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MICE_CONTROL


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
  io.put_string("ASD")
end

feature

  execute
  do
    io.put_string("ASD")
  end


end
