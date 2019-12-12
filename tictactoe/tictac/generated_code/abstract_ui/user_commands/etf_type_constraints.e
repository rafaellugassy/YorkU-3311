class
 	 ETF_TYPE_CONSTRAINTS

feature -- type queries 

	is_button(etf_v: INTEGER_64): BOOLEAN 
		require
			comment("etf_v: BUTTON = 1 .. 9")
		do
			 Result := 
				(1 <= etf_v) and then (etf_v <= 9)
		ensure
			 Result = 
				(1 <= etf_v) and then (etf_v <= 9)
		end
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
			new_game_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			play_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			play_again_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			undo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			redo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
		do
			create Result.make (10)
			Result.compare_objects
			create new_game_param_types.make (10)
			new_game_param_types.compare_objects
			new_game_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}), "player1")
			new_game_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}), "player2")
			Result.extend (new_game_param_types, "new_game")
			create play_param_types.make (10)
			play_param_types.compare_objects
			play_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}), "player")
			play_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("BUTTON", create {ETF_INTERVAL_PARAM}.make(1, 9)), "press")
			Result.extend (play_param_types, "play")
			create play_again_param_types.make (10)
			play_again_param_types.compare_objects
			Result.extend (play_again_param_types, "play_again")
			create undo_param_types.make (10)
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make (10)
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
		end
feature -- query on declarations of event parameters
	evt_param_types_list : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
		local
			new_game_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			play_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			play_again_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			undo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			redo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
		do
			create Result.make (10)
			Result.compare_objects
			create new_game_param_types.make
			new_game_param_types.compare_objects
			new_game_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}))
			new_game_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}))
			Result.extend (new_game_param_types, "new_game")
			create play_param_types.make
			play_param_types.compare_objects
			play_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}))
			play_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("BUTTON", create {ETF_INTERVAL_PARAM}.make(1, 9)))
			Result.extend (play_param_types, "play")
			create play_again_param_types.make
			play_again_param_types.compare_objects
			Result.extend (play_again_param_types, "play_again")
			create undo_param_types.make
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
		end
feature -- comments for contracts
	comment(etf_s: STRING): BOOLEAN
		do
			Result := TRUE
		end
end