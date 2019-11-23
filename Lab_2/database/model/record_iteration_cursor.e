note
	description: "Summary description for {RECORD_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RECORD_ITERATION_CURSOR [V1, V2, K]

inherit
	ITERATION_CURSOR [ RECORD [V1, V2, K] ]

create make

feature

	make (values_1 : ARRAY[V1] ; values_2 : LINKED_LIST[V2] ; keys : LINKED_LIST[K])
	do
		create records.make
		across 1 |..| values_1.count as i
		loop
			records.force (create {RECORD[V1, V2, K]}.make(values_1.at (i.item), values_2.at (i.item), keys.at (i.item)))
		end
		pos := records.lower
	end

feature {NONE}
	records : LINKED_LIST[RECORD[V1, V2, K]]
	pos : INTEGER

feature -- Access

	item: RECORD [V1, V2, K]
			-- Item at current cursor position.
		do
			Result := records.at (pos)
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := not records.valid_index (pos)
		end

feature -- Cursor movement

	forth
			-- Move to next position
		do
			pos := pos + 1
		end


end
