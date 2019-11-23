class
 	 ETF_TYPE_CONSTRAINTS
feature -- list of enumeratd constants
	enum_items : HASH_TABLE[INTEGER, STRING]
		do
			create Result.make (10)
		end

	enum_items_inverse : HASH_TABLE[STRING, INTEGER_64]
		do
			create Result.make (10)
		end
feature -- query on declarations of event parameters
	evt_param_types_table : HASH_TABLE[HASH_TABLE[ETF_PARAM_TYPE, STRING], STRING]
		local
			set_number_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			start_game_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			put_number_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			undo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			redo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			restart_game_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
		do
			create Result.make (10)
			Result.compare_objects
			create set_number_param_types.make (10)
			set_number_param_types.compare_objects
			set_number_param_types.extend (create {ETF_INT_PARAM}, "num")
			set_number_param_types.extend (create {ETF_INT_PARAM}, "row")
			set_number_param_types.extend (create {ETF_INT_PARAM}, "col")
			Result.extend (set_number_param_types, "set_number")
			create start_game_param_types.make (10)
			start_game_param_types.compare_objects
			Result.extend (start_game_param_types, "start_game")
			create put_number_param_types.make (10)
			put_number_param_types.compare_objects
			put_number_param_types.extend (create {ETF_INT_PARAM}, "num")
			put_number_param_types.extend (create {ETF_INT_PARAM}, "row")
			put_number_param_types.extend (create {ETF_INT_PARAM}, "col")
			Result.extend (put_number_param_types, "put_number")
			create undo_param_types.make (10)
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make (10)
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
			create restart_game_param_types.make (10)
			restart_game_param_types.compare_objects
			Result.extend (restart_game_param_types, "restart_game")
		end
feature -- query on declarations of event parameters
	evt_param_types_list : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
		local
			set_number_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			start_game_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			put_number_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			undo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			redo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			restart_game_param_types: LINKED_LIST[ETF_PARAM_TYPE]
		do
			create Result.make (10)
			Result.compare_objects
			create set_number_param_types.make
			set_number_param_types.compare_objects
			set_number_param_types.extend (create {ETF_INT_PARAM})
			set_number_param_types.extend (create {ETF_INT_PARAM})
			set_number_param_types.extend (create {ETF_INT_PARAM})
			Result.extend (set_number_param_types, "set_number")
			create start_game_param_types.make
			start_game_param_types.compare_objects
			Result.extend (start_game_param_types, "start_game")
			create put_number_param_types.make
			put_number_param_types.compare_objects
			put_number_param_types.extend (create {ETF_INT_PARAM})
			put_number_param_types.extend (create {ETF_INT_PARAM})
			put_number_param_types.extend (create {ETF_INT_PARAM})
			Result.extend (put_number_param_types, "put_number")
			create undo_param_types.make
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
			create restart_game_param_types.make
			restart_game_param_types.compare_objects
			Result.extend (restart_game_param_types, "restart_game")
		end
feature -- comments for contracts
	comment(etf_s: STRING): BOOLEAN
		do
			Result := TRUE
		end
end