note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

inherit
	ANY

create
	make

feature {GAME, ETF_MODEL, NONE}

	past_moves, next_moves : ARRAYED_STACK[MOVE]
	board : STRING
	turn : INTEGER
	player1, player2 : STRING
	score1, score2 : INTEGER
	game_over : BOOLEAN

feature {GAME, NONE}

	change_turn
	do
		if turn = 1 then
			turn := 2
		else
			turn := 1
		end
	end

	play_x(location : INTEGER)
	local
		action : PLACE_X
	do

		create action.make (location, Current)
		action.execute
		past_moves.put (action)
	end

	play_o(location : INTEGER)
	local
		action : PLACE_O
	do

		create action.make (location, Current)
		action.execute
		past_moves.put (action)
	end

	clear_next_moves
	do
		create next_moves.make (0)
	end

	do_undo : BOOLEAN
	local
		action : MOVE
	do
		-- if past actions are empty, do nothing
		if past_moves.count /= 0 then
			action := past_moves.item
			past_moves.remove
			action.redo
			next_moves.put (action)
			Result := true
		else
			Result := false
		end
	end

feature {MOVE, NONE} -- commands for the move class

	remove_piece (location : INTEGER)
	do
		board.put ('_', location)
	end

	place_x (location : INTEGER)
	do
		-- place a X at the location
		board.put ('X', location)
	end

	place_o (location : INTEGER)
	do
		-- place a O at the location
		board.put ('O', location)
	end

feature {ETF_MODEL, GAME, NONE} -- querries

	no_moves : BOOLEAN
	do
		Result := not board.has ('_')
	end

	board_out : STRING
	do
		create Result.make_from_string (board)
		Result.insert_character ('%N', 4)
		Result.insert_character ('%N', 8)
		Result.insert_string ("  ", 9)
		Result.insert_string ("  ", 5)
		Result.insert_string ("  ", 1)
	end



	can_place (location : INTEGER) : BOOLEAN
	do
		if board.at (location) = '_' then
			Result := true
		else
			Result := false
		end
	end

	win(c : CHARACTER) : BOOLEAN -- checks for a win, and if there is a win, then it will set game_over to true
	require
		valid_char_choice: c = 'X' or c = 'O'
	local
		i : INTEGER
	do
		Result := false
		from
			i := 1
		until
			i > 3
		loop
			if board.at (i) = c and board.at (i + 3) = c and board.at (i + 6) = c then
				Result := true
			elseif board.at (1 + (3 * (i - 1))) = c and board.at (2 + (3 * (i - 1))) = c and board.at (3 + (3 * (i - 1))) = c then
				Result := true
			end
			i := i + 1
		end
		if board.at (1) = c and board.at (5) = c and board.at (9) = c then
			Result := true
		elseif board.at (3) = c and board.at (5) = c and board.at (7) = c then
			Result := true
		end

		if Result = true then
			game_over := true
		end
	end

	turn_player : STRING -- returns the turn player
	do
		if turn = 1 then
			Result := player1
		else
			Result := player2
		end
	end

feature {ETF_MODEL, NONE} -- Commands

	undo
	do
		if do_undo then
			change_turn
		end
	end

	redo
	local
		action : MOVE
	do
		-- if next actions are empty, do nothing
		if next_moves.count /= 0 then
			action := next_moves.item
			next_moves.remove
			action.execute
			past_moves.put (action)
			change_turn
		end
	end

	place (name : STRING ; location : INTEGER) : STRING
	do
		create Result.make_from_string ("ok")
		if player1 ~ name and turn = 2 then
			create Result.make_from_string("not this player's turn")
		elseif player2 ~ name and turn = 1 then
			create Result.make_from_string("not this player's turn")
		elseif player1 /~ name and player2 /~ name then
			create Result.make_from_string("no such player")
		elseif not can_place(location) then
			create Result.make_from_string ("button already taken")
		elseif turn = 1 then
			play_x(location)
			clear_next_moves
			change_turn
			if win('X') then
				create Result.make_from_string ("there is a winner")
				score1 := score1 + 1
			elseif no_moves then
				game_over := true
				create Result.make_from_string ("game ended in a tie")
			end
		else
			play_o(location)
			clear_next_moves
			change_turn
			if win('O') then
				create Result.make_from_string ("there is a winner")
				score2 := score2 + 1
			elseif no_moves then
				game_over := true
				create Result.make_from_string ("game ended in a tie")
			end
		end
	end

feature {ETF_MODEL, NONE} -- Initialization

	make (name1 : STRING ; name2 : STRING ; sc1 : INTEGER ; sc2 : INTEGER)
			-- Initialization for `Current'.
		do
			game_over := false
			create past_moves.make (0)
			create next_moves.make (0)
			create board.make_from_string ("_________")
			turn := ((sc1 + sc2) \\ 2) + 1
			create player1.make_from_string(name1)
			create player2.make_from_string(name2)
			score1 := sc1
			score2 := sc2
		end

end
