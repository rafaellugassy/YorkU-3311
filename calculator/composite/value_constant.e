note
	description: "Summary description for {INTEGER_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_CONSTANT

inherit
	EXPRESSION

create
	make

feature -- Iterable
	new_cursor: ITERATION_CURSOR[STRING]
		local
			linearized: LINKED_LIST[STRING]
		do
			create linearized.make
			linearized.extend (value.out)
			Result := linearized.new_cursor
		end

feature -- Constructor
	make (v: REAL)
		do
			value := v
		end

feature -- Attributes
	value: REAL

end
