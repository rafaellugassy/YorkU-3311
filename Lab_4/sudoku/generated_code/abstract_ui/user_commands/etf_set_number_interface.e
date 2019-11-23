note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_SET_NUMBER_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent set_number(? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as num and then attached {INTEGER_64} etf_cmd_args[2] as row and then attached {INTEGER_64} etf_cmd_args[3] as col
			then
				out := "set_number(" + etf_event_argument_out("set_number", "num", num) + "," + etf_event_argument_out("set_number", "row", row) + "," + etf_event_argument_out("set_number", "col", col) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command 
	set_number(num: INTEGER_64 ; row: INTEGER_64 ; col: INTEGER_64)
    	deferred
    	end
end
