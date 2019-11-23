note
	description: "Summary description for {PUT_NUMBER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PUT_NUMBER

inherit
	COMMAND

create
	make

feature {NONE} -- Initialization

	make (number : INTEGER; rows : INTEGER; column : INTEGER)
			-- Initialization for `Current'.
		local
			model_access : ETF_MODEL_ACCESS
		do
			num := number
			row := rows
			col := column
			m := model_access.m
		end

	m : ETF_MODEL
	num : INTEGER
	row : INTEGER
	col : INTEGER

feature

	redo
		do
			m.board.put (num, row, col)
		end

	undo
		do
			m.board.put (0, row, col)
		end


end
