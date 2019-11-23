note
	description: "Documentation of how DATABASE should be used."
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_DATABASE_TESTS

inherit
	ES_TEST
		redefine
			setup, teardown
		end

create
	make

feature  -- Add tests

	make
			-- Run application.
		do
			create d.make
			check d.count = 0 end

			add_boolean_case (agent test_array_comparison)
			add_boolean_case (agent test_setup)
			add_boolean_case (agent test_get_keys)
			add_boolean_case (agent test_remove)
			add_boolean_case (agent test_iterable_database)
			add_boolean_case (agent test_iteration_cursor)
			add_boolean_case (agent test_another_cursor)
		end

feature -- Setup
	d: DATABASE[STRING, CHARACTER, INTEGER]

	setup
			-- Initialize 'd' as a 4-record database.
			-- This feature is executed in the beginning of every test feature.
		do
			d.add_record ("A", 'a', 1)
			d.add_record ("B", 'b', 2)
			d.add_record ("C", 'c', 3)
			d.add_record ("D", 'd', 4)
		end

	teardown
			-- Recreate 'd' as an empty database.
			-- This feature is executed at end of every test feature.
		do
			create d.make
		end

feature -- Test for array comparison
	test_array_comparison: BOOLEAN
		local
			a1, a2: ARRAY[STRING]
		do
			comment ("test_array_comparison: test ref. and obj. comparison")
			create a1.make_empty
			create a2.make_empty
			a1.force ("A", 1)
			a1.force ("B", 2)
			a1.force ("C", 3)

			a2.force ("A", 1)
			a2.force ("B", 2)
			a2.force ("C", 3)

			Result :=
						not a1.object_comparison
				and	not a2.object_comparison
				and 	not (a1 ~ a2)
			check Result end

			a1.compare_objects
			a2.compare_objects
			Result :=
						a1.object_comparison
				and	a2.object_comparison
				and 	a1 ~ a2
		end

feature -- Tests
	test_setup: BOOLEAN
		local
			tuples: LINKED_LIST[TUPLE[k: INTEGER; v1: STRING; v2: CHARACTER]]
		do
			comment ("test_setup: test the initial database")
			create tuples.make
			across
				d as tuple_cursor
			loop
				tuples.extend (tuple_cursor.item)
			end

			Result :=
					d.count = 4
				and tuples.count = 4
				and	tuples[1].k ~ 1 and tuples[1].v1 ~ "A" and tuples[1].v2 ~ 'a'
				and	tuples[2].k ~ 2 and tuples[2].v1 ~ "B" and tuples[2].v2 ~ 'b'
				and	tuples[3].k ~ 3 and tuples[3].v1 ~ "C" and tuples[3].v2 ~ 'c'
				and	tuples[4].k ~ 4 and tuples[4].v1 ~ "D" and tuples[4].v2 ~ 'd'
		end

	test_remove: BOOLEAN
		local
			tuples: LINKED_LIST[TUPLE[k: INTEGER; v1: STRING; v2: CHARACTER]]
		do
			comment ("test_remove: test record removal")
			d.remove_record (2)
			create tuples.make
			across
				d as tuple_cursor
			loop
				tuples.extend (tuple_cursor.item)
			end

			Result :=
					d.count = 3
				and tuples.count = 3
				-- Note: Look at the type declaration of local variable 'tuples',
				-- where 1st element has name 'k', 2nd element 'v1', and 3rd element 'v2'.
				-- So we can use 'k', 'v1', and 'v2' to access tuple elements here,
				-- equivalent to writing 'item(1)', 'item(2)', and 'item(3)'.
				and	tuples[1].k ~ 1 and tuples[1].v1 ~ "A" and tuples[1].v2 ~ 'a'
				and	tuples[2].k ~ 3 and tuples[2].v1 ~ "C" and tuples[2].v2 ~ 'c'
				and	tuples[3].k ~ 4 and tuples[3].v1 ~ "D" and tuples[3].v2 ~ 'd'
		end

	test_get_keys: BOOLEAN
		local
			keys: ARRAY[INTEGER]
		do
			comment ("test_get_keys: test iterable keys")
			create keys.make_empty
			d.add_record ("A", 'a', 5)

			create keys.make_empty
			across
				d.get_keys ("A", 'a') as k
			loop
				keys.force (k.item, keys.count + 1)
			end
			Result :=
						keys.count = 2
				 and		keys[1] = 1
				 and 	keys[2] = 5
			check Result end
		end

	test_iterable_database: BOOLEAN
		local
			tuples: ARRAY[TUPLE[INTEGER, STRING, CHARACTER]]
		do
			comment ("test_iterable_database: test iterating through database")
			create tuples.make_empty
			across
				d as tuple
			loop
				tuples.force (tuple.item, tuples.count + 1)
			end
			Result :=
					 d.count = 4
				 and	 tuples.count = 4
				-- Note: Look at the type declaration of local variable 'tuples',
				-- where no names are given to 1st, 2nd, and 3rd elements.
				-- So we can only write 'item(1)', 'item(2)', and 'item(3)'.
				 and	 tuples[1].item(1) = 1 and tuples[1].item(2) ~ "A" and tuples[1].item (3) = 'a'
				 and	 tuples[2].item(1) = 2 and tuples[2].item(2) ~ "B" and tuples[2].item (3) = 'b'
				 and tuples[3].item(1) = 3 and tuples[3].item(2) ~ "C" and tuples[3].item (3) = 'c'
				 and tuples[4].item(1) = 4 and tuples[4].item(2) ~ "D" and tuples[4].item (3) = 'd'
		end

	test_iteration_cursor: BOOLEAN
		local
			tic: TUPLE_ITERATION_CURSOR[INTEGER, STRING, CHARACTER]
			tuples: ARRAY[TUPLE[INTEGER, STRING, CHARACTER]]
		do
			comment ("test_iteration_cursor: test the returned cursor from database")
			create tuples.make_empty
			-- Static type of d.new_cursor is ITERATION_CURSOR, and given that
			-- its dynamic type is TUPLE_ITERATION_CURSOR, we can do a type cast.
			check  attached {TUPLE_ITERATION_CURSOR[INTEGER, STRING, CHARACTER]} d.new_cursor as nc then
				tic := nc
			end
			from
			until
				tic.after
			loop
				tuples.force (tic.item, tuples.count + 1)
				tic.forth
			end
			Result :=
					 tuples.count = 4
				 and	 tuples[1].item(1) = 1 and tuples[1].item(2) ~ "A" and tuples[1].item (3) = 'a'
				 and	 tuples[2].item(1) = 2 and tuples[2].item(2) ~ "B" and tuples[2].item (3) = 'b'
				 and tuples[3].item(1) = 3 and tuples[3].item(2) ~ "C" and tuples[3].item (3) = 'c'
				 and tuples[4].item(1) = 4 and tuples[4].item(2) ~ "D" and tuples[4].item (3) = 'd'
		end

	test_another_cursor: BOOLEAN
		local
			ric: RECORD_ITERATION_CURSOR[STRING, CHARACTER, INTEGER]
			entries: ARRAY[RECORD[STRING, CHARACTER, INTEGER]]
		do
			comment ("test_another_cursor: test the alternative returned cursor from database")
			create entries.make_empty
			-- Static type of d.another_cursor is ITERATION_CURSOR, and given that
			-- its dynamic type is RECORD_ITERATION_CURSOR, we can do a type cast.
			check attached {RECORD_ITERATION_CURSOR[STRING, CHARACTER, INTEGER]} d.another_cursor as nc then
				ric := nc
			end
			from
			until
				ric.after
			loop
				entries.force (ric.item, entries.count + 1)
				ric.forth
			end
			Result :=
						entries.count = 4
				 and	entries [1] ~ (create {RECORD[STRING, CHARACTER, INTEGER]}.make ("A", 'a', 1))
				 and	entries [2] ~ (create {RECORD[STRING, CHARACTER, INTEGER]}.make ("B", 'b', 2))
				 and	entries [3] ~ (create {RECORD[STRING, CHARACTER, INTEGER]}.make ("C", 'c', 3))
				 and	entries [4] ~ (create {RECORD[STRING, CHARACTER, INTEGER]}.make ("D", 'd', 4))
		end
end
