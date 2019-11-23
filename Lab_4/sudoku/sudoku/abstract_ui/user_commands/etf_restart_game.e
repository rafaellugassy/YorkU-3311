note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_RESTART_GAME
inherit
	ETF_RESTART_GAME_INTERFACE
		redefine restart_game end
create
	make
feature -- command
	restart_game
    	do
			-- perform some update on the model state
			model.restart
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
