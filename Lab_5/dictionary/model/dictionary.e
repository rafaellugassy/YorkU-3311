note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	-- Constrained genericity because V and K will be used
	-- in the math model class FUN, which require both to be always
	-- attached for void safety.
	DICTIONARY[V -> attached ANY, K -> attached ANY]
inherit
	ITERABLE[TUPLE[V, K]]

create
	make
feature -- Do not modify this export status!
	values: LINKED_LIST[V]
	keys: ARRAY[K]

feature -- Abstraction function
	model: FUN[K, V] -- Do not modify the type of this query.
			-- Abstract the dictionary ADT as a mathematical function.
		local
			pair : PAIR[K, V]
		do
			create Result.make_empty
			across 1 |..| count as i
			loop
				create pair.make (keys.at (i.item), values.at (i.item))
				Result.extend (pair)
			end
			-- Your Task
		ensure
			consistent_model_imp_counts: Result.count = count
				-- Your Task: sizes of model and implementations the same
			consistent_model_imp_contents: across 1 |..| count as i all Result.item (keys.at (i.item)) ~ values.at (i.item) end
				-- Your Task: applying the model function on each key gives back the corresponding value
		end

feature -- feature required by ITERABLE
	new_cursor: TUPLE_ITERATION_CURSOR[V, K] -- Do not change this return type.
		do
			-- Your Task
			create Result.make (values, keys)
		end

feature -- Constructor
	make
			-- Initialize an empty dictionary.
		do
			create values.make
			create keys.make_empty
			-- Your Task: add more code here
			values.compare_objects
			keys.compare_objects
		ensure
			empty_model: model.count = 0
				-- Your Task.
			object_equality_for_keys:
				-- Do not modify this.
				keys.object_comparison
			object_equality_for_values:
				-- Do not modify this.
				values.object_comparison
		end

feature -- Commands

	add_entry (v: V; k: K)
		require
			non_existing_key_in_model: not model.has (create {PAIR[K, V]}.make (k, v))
				-- Your Task.
		do
			-- Your Task.
			keys.force (k, keys.count + 1)
			values.force (v)

		ensure
			entry_added_to_model: model.has (create {PAIR[K, V]}.make (k, v))
				-- Your Task.
				-- Hint: Look at feature 'test_add' in class 'EXAMPLE_DICTIONARY_TESTS'.
		end

	add_entries (entries: SET[TUPLE[k: K; v: V]])
		require
			non_existing_keys_in_model: across entries as cursor all not model.has (create {PAIR[K, V]}.make_from_tuple (cursor.item)) end
				-- Your Task.
		local
			entries_array : ARRAY [TUPLE [k: K; v: V]]
			entry : TUPLE [k: K; v: V]
		do
			entries_array := entries.as_array
			-- Your Task.
			across 1 |..| entries_array.count as i
			loop
				entry := entries_array.at (i.item)
				add_entry(entry.v, entry.k)
			end
		ensure
			entries_added_to_model: across entries as cursor all model.has (create {PAIR[K, V]}.make_from_tuple (cursor.item)) end
				-- Your Task.
				-- Hint: Look at feature 'test_add' in class 'EXAMPLE_DICTIONARY_TESTS'.
		end

	remove_entry (k: K)
		require
			existing_key_in_model: model.domain.has (k)
				-- Your Task.
		local
			removed : BOOLEAN
			i : INTEGER
		do
			removed := False
			from
				i := 1
			until
				removed
			loop
				if keys.at (i) ~ k then
					keys.subcopy (keys, i + 1, keys.count, i)
					keys.remove_tail (1)
					values.go_i_th (i)
					values.remove
					values.go_i_th (1)
					removed := True
				end
				i := i + 1
			end
			-- Your Task.
		ensure
			entry_removed_from_model: not model.domain.has (k)
				-- Your Task.
				-- Hint: Look at feature 'test_remove' in class 'EXAMPLE_DICTIONARY_TESTS'.
		end

	remove_entries(ks: SET[K])
		require
			existing_keys_in_model: across 1 |..| ks.count as i all model.domain.has (ks.as_array.at (i.item)) end
				-- Your Task.
		local
			ks_array : ARRAY[K]
		do
			-- Your Task.
			ks_array := ks.as_array
			across 1 |..| ks_array.count as i
			loop
				remove_entry(ks_array.at(i.item))
			end

		ensure
			entries_removed_from_model: across ks as cursor all not model.domain.has (cursor.item) end
				-- Your Task.
				-- Hint: Look at feature 'test_add' in class 'EXAMPLE_DICTIONARY_TESTS'.
		end

feature -- Queries

	count: INTEGER
			-- Number of keys in dictionary.
		do
			-- Your Task
			Result := keys.count
		ensure
			correct_result: model.count = Result
				-- Your Task
		end

	get_keys (v: V): ITERABLE[K]
			-- Keys that are associated with value 'v'.
		local
			arr : ARRAY[K]
		do
			-- Your Task.
			create arr.make_empty
			across 1 |..| count as i
			loop
				if values.at (i.item) ~ v then
					arr.force (keys.at (i.item), arr.count + 1)
				end
			end
			Result := arr
		ensure
			correct_result: across Result as cursor all model.item (cursor.item) ~ v end
				-- Your Task: Every key in the result has the right corresponding value in model
		end

	get_value (k: K): detachable V
			-- Assocated value of 'k' if it exists.
			-- Void if 'k' does not exist.
		do
			-- Your task.
			if keys.has (k) then
				across 1 |..| count as i
				loop
					if keys.at (i.item) ~ k then
						Result := values.at (i.item)
					end
				end
			else
			end

		ensure
			case_of_void_result: Result ~ Void implies not model.domain.has (k)
				-- Your Task: void result means the key does not exist in model
			case_of_non_void_result: Result /~ Void implies model.domain.has (k)
				-- Your Task: void result means the key exists in model
		end
invariant
	-- Do not modify these two invariants.
	consistent_keys_values_counts:
		keys.count = values.count
	consistent_imp_adt_counts:
		keys.count = count
end
