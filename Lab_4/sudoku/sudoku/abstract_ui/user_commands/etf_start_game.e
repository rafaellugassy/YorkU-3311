note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
		redefine start_game end
create
	make
feature -- command
	start_game
    	do
			-- perform some update on the model state
			if model.start then
				model.set_message_error("Game already started")
			else
				model.set_start
				model.set_message_state
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
