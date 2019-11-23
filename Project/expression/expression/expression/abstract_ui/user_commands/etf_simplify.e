note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SIMPLIFY
inherit
	ETF_SIMPLIFY_INTERFACE
		redefine simplify end
create
	make
feature -- command
	simplify
		local
			simple : SIMPLIFY
			printer : PRETTY_PRINT
    	do
    		create simple.make
			create printer.make

    		if model.done then
    			model.head.accept (simple)
				if not simple.error then
					model.prettify (simple.value).accept (printer)
					model.set_report (printer.value)
				end
    		else
    			model.set_error ("Expression is not yet fully specified")
    		end


			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
