note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY_AGAIN
inherit
	ETF_PLAY_AGAIN_INTERFACE
		redefine play_again end
create
	make
feature -- command
	play_again
    	do
			-- perform some update on the model state
			model.play_again
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
