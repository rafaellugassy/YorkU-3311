note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ANALYZE
inherit
	ETF_ANALYZE_INTERFACE
		redefine analyze end
create
	make
feature -- command
	analyze
		local
			analyzer : ANALYZE
    	do
    		if not model.done then
				model.set_error ("Expression is not yet fully specified")
			else
				create analyzer.make
				model.head.accept (analyzer)
				model.set_analyze_correct
    		end

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
