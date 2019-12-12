note
	description: "Summary description for {DIVISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIVISION

inherit
	BINARY_EXPRESSION

create
	make

feature -- Query
	operator: STRING
			-- String representation of division.
		do
			Result := "/"
		end

end
