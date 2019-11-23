note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR [K, V1, V2]

inherit
	ITERATION_CURSOR [ TUPLE[K, V1, V2] ]
create make

feature

	make (values_1 : ARRAY[V1] ; values_2 : LINKED_LIST[V2] ; keys : LINKED_LIST[K])
	local
		tuple : TUPLE [K, V1, V2]
	do
		create tuples.make
		across 1 |..| values_1.count as i
		loop
			create tuple.default_create
			tuple.put (keys.at (i.item), 1)
			tuple.put (values_1.at (i.item), 2)
			tuple.put (values_2.at (i.item), 3)
			tuples.force (tuple)
		end
		pos := tuples.lower
	end

feature {NONE}
	tuples : LINKED_LIST[TUPLE[K, V1, V2]]
	pos : INTEGER

feature -- Access

	item: TUPLE [K, V1, V2]
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
