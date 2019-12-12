note
	description: "Summary description for {BINARY_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BINARY_EXPRESSION

inherit
	EXPRESSION

	COMPOSITE[EXPRESSION]

feature -- Iterable
	new_cursor: ITERATION_CURSOR[STRING]
		local
			linearizied: LINKED_LIST[STRING]
		do
			create linearizied.make
			linearizied.extend ("(")
			across
				left as c
			loop
				linearizied.extend (c.item)
			end
			linearizied.extend (operator)
			across
				right as c
			loop
				linearizied.extend (c.item)
			end
			linearizied.extend (")")
			Result := linearizied.new_cursor
		end

feature -- Queries
	operator: STRING
		deferred
		end

	left: EXPRESSION
		do
			Result := children[children.lower]
		end

	right: EXPRESSION
		do
			Result := children[children.lower + 1]
		end

feature -- Commands
	make (l: EXPRESSION; r: EXPRESSION)
		do
			create children.make
			children.extend (l)
			children.extend (r)
		end

invariant
	binary_operands: children.count = 2
end
