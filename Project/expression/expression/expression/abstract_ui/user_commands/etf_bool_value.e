note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_BOOL_VALUE
inherit
	ETF_BOOL_VALUE_INTERFACE
		redefine bool_value end
create
	make
feature -- command
	bool_value(c: BOOLEAN)
    	local
			b : BOOLEAN_CONSTANT
    	do
			-- perform some update on the model state
			if model.done then
				model.set_error ("Expression is already fully specified")
			end
			create b.make_boolean (model.cur.parent, c)
			model.set (b)
			b.set_next_cur
			model.set_success

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
