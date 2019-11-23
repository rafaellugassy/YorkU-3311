note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_EXISTS
inherit
	ETF_EXISTS_INTERFACE
		redefine exists end
create
	make
feature -- command
	exists
    	local
			u : UNARY_OP
    	do
			-- perform some update on the model state
			if model.done then
				model.set_error ("Expression is already fully specified")
			end
			create u.make_unary_op (model.cur.parent, "||")
			model.set (u)
			model.set_cur (u.children.at (1))
			model.set_success

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
