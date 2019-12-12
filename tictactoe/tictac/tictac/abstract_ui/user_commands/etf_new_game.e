note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
		redefine new_game end
create
	make
feature -- command
	new_game(player1: STRING ; player2: STRING)
		require else
			new_game_precond(player1, player2)
    	do
			-- perform some update on the model state
			model.make_game (player1, player2)
			model.default_update
			etf_cmd_container.on_change.notify ([Current])

    	end

end
