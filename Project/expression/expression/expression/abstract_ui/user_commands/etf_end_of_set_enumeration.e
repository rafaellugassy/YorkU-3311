note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_END_OF_SET_ENUMERATION
inherit
	ETF_END_OF_SET_ENUMERATION_INTERFACE
		redefine end_of_set_enumeration end
create
	make
feature -- command
	end_of_set_enumeration
    	do
    		if model.done then
				model.set_error ("Expression is already fully specified")
    		elseif attached model.cur.parent as p then
				if p.type /~ "set enumeration" then
					model.set_error ("Set enumeration is not being specified")
				elseif p.children.count < 2 then
					model.set_error ("Set enumeration must be non-empty")
				elseif attached {SET_ENUMERATION} p as set then
					set.finish
					model.set_success
				end

			else
				model.set_error ("Set enumeration is not being specified")
    		end

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
