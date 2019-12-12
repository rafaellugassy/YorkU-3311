note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_NEW_GAME_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent new_game(? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as player1 and then attached {STRING} etf_cmd_args[2] as player2
			then
				out := "new_game(" + etf_event_argument_out("new_game", "player1", player1) + "," + etf_event_argument_out("new_game", "player2", player2) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	new_game_precond(player1: STRING ; player2: STRING): BOOLEAN
		do  
			Result := 
				comment ("NAME = STRING")
		ensure then  
			Result = 
				comment ("NAME = STRING")
		end 
feature -- command 
	new_game(player1: STRING ; player2: STRING)
		require 
			new_game_precond(player1, player2)
    	deferred
    	end
end
