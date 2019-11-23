note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_OF_SET_ENUMERATION
inherit
	ETF_START_OF_SET_ENUMERATION_INTERFACE
		redefine start_of_set_enumeration end
create
	make
feature -- command
	start_of_set_enumeration
    	local
			s : SET_ENUMERATION
    	do
			-- perform some update on the model state
			if model.done then
				model.set_error ("Expression is already fully specified")
			end
			create s.make (model.cur.parent)
			model.set (s)
			model.set_cur (s.children.at (1))
			model.set_success

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
