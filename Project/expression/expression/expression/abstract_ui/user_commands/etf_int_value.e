note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INT_VALUE
inherit
	ETF_INT_VALUE_INTERFACE
		redefine int_value end
create
	make
feature -- command
	int_value(c: INTEGER_64)
    		local
			i : INTEGER_CONSTANT
    	do
			-- perform some update on the model state
			if model.done then
				model.set_error ("Expression is already fully specified")
			end
			create i.make_integer (model.cur.parent, c.as_integer_32)
			model.set (i)
			i.set_next_cur
			model.set_success

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
