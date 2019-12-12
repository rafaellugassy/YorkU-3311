note
	description: "Summary description for {ADDITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADDITION

inherit
	BINARY_EXPRESSION

create
	make

feature -- Query
	operator: STRING
			-- String representation of addition.
		do
			Result := "+"
		end
end
