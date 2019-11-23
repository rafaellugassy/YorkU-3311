note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			i := 0
			create board.make_filled (0, 4, 4)
			start := False
			create message.make_from_string ("Setting up a new grid")
			create prev.make
			create next.make
		end

feature {NONE}
	board_state : STRING
	do
		create Result.make_empty
		across 1 |..| board.height as row
		loop
			across 1 |..| board.width as col
			loop
				Result.append("  ")
				if col.item /= 1 then
					Result.append(" ")
				end
				Result.append_integer (board.item (row.item, col.item))
			end
			if row.item /= 4 then
				Result.append("%N")
			end
		end
	end

feature -- model attributes
	s : STRING
	i : INTEGER
	prev : LINKED_STACK [COMMAND]
	next : LINKED_STACK [COMMAND]
	board : ARRAY2 [INTEGER]
	start : BOOLEAN
	message : STRING

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	undo
	do
		prev.item.undo
		next.put (prev.item)
		prev.remove
	end

	redo
	do
		next.item.redo
		prev.put (next.item)
		next.remove
	end

	set_val_start(value : BOOLEAN)
	do
		start := value
	end

	set_start
	local
		new : START_GAME
	do
		start := True
		create new.make
		prev.put (new)
	end

	game_over : BOOLEAN
	do
		Result := across board as cur
		all
			cur.item /= 0
		end
	end

	num_exist_row (num : INTEGER; row : INTEGER) : BOOLEAN
	do
		Result := not across 1 |..| board.width as cur all board.item (row, cur.item) /~ num end
	end

	num_exist_col (num : INTEGER; col : INTEGER) : BOOLEAN
	do
		Result := not across 1 |..| board.height as cur all board.item (cur.item, col) /~ num end
	end

	num_exist_box (num : INTEGER; row : INTEGER; col : INTEGER) : BOOLEAN
	do
		Result := not across 1 |..| (board.height |>> 1) as r
		all
			across 1 |..| (board.width |>> 1) as c
			all
				board.item (((row - 1) |>> 1) * 2 + r.item, ((col - 1) |>> 1) * 2 + c.item) /~ num
			end
		end
	end

	set_board(num : INTEGER; row : INTEGER; col : INTEGER)
	local
		new : PUT_NUMBER
	do
		create new.make (num, row, col)
		new.redo
		prev.put (new)
		create next.make
	end

	restart
	do
		do_restart
		create message.make_from_string ("Setting up a new grid")
		create next.make
		create prev.make
	end

	do_restart
	do
		create board.make_filled (0, 4, 4)
		start := False
	end

	undo_restart(b : ARRAY2[INTEGER] ; st : BOOLEAN)
	do
		board.copy (b)
		start := st
	end

	set_message_state
	do
		if start then
			create message.make_from_string ("Current game is over: ")
			if game_over then
				message.append ("Yes")
			else
				message.append ("No")
			end
		else
			create message.make_from_string ("Setting up a new grid")
		end
	end

	set_message_error (error : STRING)
	do
		create message.make_from_string ("Error: ")
		message.append (error)
	end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append (message)
			Result.append ("%N")
			Result.append (board_state)
		end

end







