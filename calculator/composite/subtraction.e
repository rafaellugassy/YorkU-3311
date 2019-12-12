note
	description: "Summary description for {SUBTRACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUBTRACTION

inherit
	BINARY_EXPRESSION

create
	make

feature -- Query
	operator: STRING
			-- String representation of subtraction.
		do
			Result := "-"
		end

end
