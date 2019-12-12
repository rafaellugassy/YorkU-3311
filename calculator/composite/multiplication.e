note
	description: "Summary description for {MULTIPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLICATION

inherit
	BINARY_EXPRESSION

create
	make

feature -- Query
	operator: STRING
			-- String representation of multiplication.
		do
			Result := "*"
		end

end
