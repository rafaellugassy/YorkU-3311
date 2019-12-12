note
	description: "Summary description for {BAD_STACK_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_STACK_LIST[G -> attached ANY]
inherit
	STACK_LIST[G]
		redefine push end
create
	make
feature
	push (x: G)
			-- push `x' on to the stack
		do
			implementation.put_front (x)
			if count >= 3 then
				implementation[count] := implementation[1]
			end
		end

end
