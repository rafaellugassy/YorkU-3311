note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR [V, K]

inherit
	ITERATION_CURSOR [ TUPLE[V, K] ]
create make

feature

	make (values : LINKED_LIST[V] ; keys : ARRAY[K])
	local
		tuple : TUPLE [V, K]
	do
		create tuples.make
		across 1 |..| values.count as i
		loop
			create tuple.default_create
			tuple.put (values.at (i.item), 1)
			tuple.put (keys.at (i.item), 2)
			tuples.force (tuple)
		end
		pos := tuples.lower
	end

feature {NONE}
	tuples : LINKED_LIST[TUPLE[V, K]]
	pos : INTEGER

feature -- Access

	item: TUPLE [V, K]
			-- Item at current cursor position.
		do
			Result := tuples.at (pos)
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := not tuples.valid_index (pos)
		end

feature -- Cursor movement

	forth
			-- Move to next position
		do
			pos := pos + 1
		end


end
