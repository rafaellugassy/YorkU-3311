note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_PLAY_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent play(? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as player and then attached {INTEGER_64} etf_cmd_args[2] as press
			then
				out := "play(" + etf_event_argument_out("play", "player", player) + "," + etf_event_argument_out("play", "press", press) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	play_precond(player: STRING ; press: INTEGER_64): BOOLEAN
		do  
			Result := 
				         comment ("NAME = STRING")
				and then 
				is_button(press)
					-- (1 <= press) and then (press <= 9)
		ensure then  
			Result = 
				         comment ("NAME = STRING")
				and then 
				is_button(press)
					-- (1 <= press) and then (press <= 9)
		end 
feature -- command 
	play(player: STRING ; press: INTEGER_64)
		require 
			play_precond(player, press)
    	deferred
    	end
end
