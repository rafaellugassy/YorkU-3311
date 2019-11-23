note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DISJUNCTION
inherit
	ETF_DISJUNCTION_INTERFACE
		redefine disjunction end
create
	make
feature -- command
	disjunction
    	local
			b : BINARY_OP
    	do
			-- perform some update on the model state
			if model.done then
				model.set_error ("Expression is already fully specified")
			end
			create b.make_binary_op (model.cur.parent, "||")
			model.set (b)
			model.set_cur (b.children.at (1))
			model.set_success

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
