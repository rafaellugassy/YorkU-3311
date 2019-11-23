note
	description: "A DATABASE ADT mapping from keys to two kinds of values"
	author: "Jackie Wang and You"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE[V1, V2, K]
inherit
	ITERABLE[TUPLE[K, V1, V2]]

create
	make

feature {EXAMPLE_DATABASE_TESTS} -- Do not modify this export status!
	-- You are required to implement all database features using these three attributes.
	values_1: ARRAY[V1]
	values_2: LINKED_LIST[V2]
	keys: LINKED_LIST[K]

feature -- feature(s) required by ITERABLE
	-- Your Task
	new_cursor: TUPLE_ITERATION_CURSOR [K, V1, V2]
	do
		create Result.make(values_1.deep_twin, values_2.deep_twin, keys.deep_twin)
	end
	-- See test_iterable_databse and test_iteration_cursor in EXAMPLE_DATABASE_TESTS.
	-- As soon as you make the current class iterable,
	-- define the necessary feature(s) here.

feature -- alternative iteration cursor
	-- Your Task
	another_cursor : RECORD_ITERATION_CURSOR [V1, V2, K]
	do
		create Result.make(values_1.deep_twin, values_2.deep_twin, keys.deep_twin)
	end
	-- See test_another_cursor in EXAMPLE_DATABASE_TESTS.
	-- A feature 'another_cursor' is expected to be defined here.

feature -- Constructor
	make
			-- Initialize an empty database.
		do
			-- Your Task
			create values_1.make_empty
			create values_2.make
			create keys.make
			keys.compare_objects
			values_1.compare_objects
			values_2.compare_objects
		ensure
			empty_database: -- Your Task
				across Current as c all False end
			-- Do not modify the following three postconditions.
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values_1:
				values_1.object_comparison
			object_equality_for_values_2:
				values_2.object_comparison
		end

feature -- Commands

	add_record (v1: V1; v2: V2; k: K)
			-- Add a new record into current database.
		require
			non_existing_key: -- Your Task
				not Current.exists (k)
		do
			-- Your Task
			if attached v1 as v_1 AND attached v2 as v_2 AND attached k as key then
				values_1.force (v_1.deep_twin, values_1.count + 1)
				values_2.force (v_2.deep_twin)
				keys.force (key.deep_twin)
			end
		ensure
			record_added: -- Your Task
				-- Hint: At least a record in current database.
				-- has its key 'k', value 1 'v1', and value 2 'v2'.
				across 1 |..| Current.count as i
				some
					keys.at (i.item) ~ k AND values_1.at (i.item) ~ v1 AND values_2.at (i.item) ~ v2
				end
		end

	remove_record (k: K)
			-- Remove a record from current database.
		require
			existing_key: -- Your Task
				across Current as tuple some k ~ tuple.item.item(1) end
		local
			done : BOOLEAN
		do
			-- Your Task
			done := False
			across 1 |..| keys.count as i
			loop
				if not done AND k ~ keys.at (i.item) then
					keys.go_i_th (i.item)
					keys.remove
					values_1.subcopy (values_1, i.item + 1, values_1.count, i.item)
					values_1.remove_tail (1)
					values_2.go_i_th (i.item)
					values_2.remove
					done := True
					--values_1 := values_1.subarray (0, i.item - 1).
				end
			end
		ensure
			database_count_decremented: -- Your Task
				Current.count = old Current.count - 1
			key_removed: -- Your Task
				across Current as tuple all k /~ tuple.item.item(1) end
		end

feature -- Queries

	count: INTEGER
			-- Number of records in database.
		do
			-- Your Task
			Result := keys.count
		ensure
			correct_result: -- Your Task
				Result = keys.count AND Result = values_1.count AND Result = values_2.count
		end

	exists (k: K): BOOLEAN
			-- Does key 'k' exist in the database?
		do
			-- Your Task
			Result := across keys as ks
				some
					k ~ ks.item
				end
		ensure
			correct_result: -- Your Task
				across Current as tuple some (attached {K} tuple.item.item(1) as k1 implies k1 ~ k) AND attached {K} tuple.item.item(1)  end
		end


	get_keys (v1: V1; v2: V2): ITERABLE[K]
			-- Keys that are associated with values 'v1' and 'v2'.
		local
			ks : LINKED_LIST[K]
		do
			-- Your Task
			create ks.make

			across 1 |..| Current.count as i
			loop
				if v1 ~ values_1.at (i.item) AND v2 ~ values_2.at (i.item) then
					ks.force (keys.at (i.item))
				end
			end

			Result := ks

		ensure
			result_contains_correct_keys_only: -- Your Task
				-- Hint: Each key in Result has its associated values 'v1' and 'v2'.
				across Result as k all across Current as tuple all k ~ tuple.item.item(1) implies (v1 ~ tuple.item.item(2) AND v2 ~ tuple.item.item(3)) end end
			correct_keys_are_in_result: -- Your Task
				-- Hint: Each record with values 'v1' and 'v2' has its key included in Result.
				-- Notice that Result is ITERABLE and does not support the feature 'has',
				-- Use the appropriate across expression instead.
				across 1 |..| Current.count as i all (v1 ~ values_1.at (i.item) AND v2 ~ values_2.at (i.item)) implies across Result as k some k.item ~ keys.at (i.item) end end
				--across Result as k all across Current as tuple all (v1 ~ tuple.item.item(2) AND v2 ~ tuple.item.item(3)) implies k ~ tuple.item.item(1) end end
		end

invariant
	unique_keys: -- Your Task
		-- Hint: No two keys are equal to each other.   TEST HERE
		across 1 |..| keys.count as i
		all
			across 1 |..| keys.count as j
			all
				i.item /= j.item implies keys.at (i.item) /~ keys.at (j.item)
			end
		end

	-- Do not modify the following three class invariants.
	implementation_contraint:
		values_1.lower = 1
	consistent_keys_values_counts:
		keys.count = values_1.count
		and
		keys.count = values_2.count
	consistent_imp_adt_counts:
		keys.count = count
end
