note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PUT_NUMBER
inherit
	ETF_PUT_NUMBER_INTERFACE
		redefine put_number end
create
	make
feature -- command
	put_number(num: INTEGER_64 ; row: INTEGER_64 ; col: INTEGER_64)
    	do
			-- perform some update on the model state
			if not model.start then
				model.set_message_error ("Game not yet started")
			elseif row < 1 OR row > 4 then
				model.set_message_error ("Invalid row number")
			elseif col < 1 OR col > 4 then
				model.set_message_error ("Invalid column number")
			elseif model.board.item (row.as_integer_32, col.as_integer_32) /~ 0 then
				model.set_message_error ("Cell already filled")
			elseif num < 1 OR num > 4 then
				model.set_message_error ("Invalid value to put in cell")
			elseif model.num_exist_row (num.as_integer_32, row.as_integer_32) then
				model.set_message_error ("Number already exists in row")
			elseif model.num_exist_col (num.as_integer_32, col.as_integer_32) then
				model.set_message_error ("Number already exists in column")
			elseif model.num_exist_box (num.as_integer_32, row.as_integer_32, col.as_integer_32) then
				model.set_message_error ("Number already exists in subgrid")
			else
				model.set_board (num.as_integer_32, row.as_integer_32, col.as_integer_32)
				model.set_message_state
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
