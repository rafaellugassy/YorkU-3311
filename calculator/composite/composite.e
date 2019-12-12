note
	description: "Summary description for {COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPOSITE[G]

feature -- Queries
	children: LINKED_LIST[G]

feature -- Commands
	make_empty
			-- Create an empty list.
		do
			create children.make
		end

	add_child (c: G)
			-- Add a new child 'c'.
		do
			children.extend (c)
		end

end
