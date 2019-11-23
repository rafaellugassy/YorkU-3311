note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create report.make_from_string ("Expression is initialized.")
			create head.make (VOID)
			done := false
			cur := head
			cur.set_cur (True)
		end

feature -- model operations

	temp2 : detachable SIMPLIFY
	temp : detachable BINARY_OP
	done : BOOLEAN
	cur : EXPRESSION
	head : EXPRESSION
	report : STRING

	prettify(ugly : EXPRESSION) : EXPRESSION
	do
		if ugly.type ~ "set enumeration" then
			Result := create {SET_ENUMERATION}.make_set (VOID)
			across ugly.children as duckling
			loop
				if not across Result.children as swan some duckling.item.check_equal(swan.item) end then
					Result.children.force (duckling.item)
				end
			end
		else
			Result := ugly
		end
	end

	set (ex : EXPRESSION) -- sets the value for the current expression
	do
		if not done then
			if cur = head then
				head := ex
			end
			if attached cur.parent as p then
				p.children.search (cur)
				p.children.replace (ex)
			end
			cur := ex
		else
			-- print error for done
		end
	end

	set_analyze_error
	local
		rep : STRING
		printer : PRETTY_PRINT
	do
		create printer.make
		head.accept (printer)
		create rep.make_empty
		rep.append (printer.value)
		rep.append (" is not type-correct.")
		set_report (rep)
	end

	set_analyze_correct
	local
		rep : STRING
		printer : PRETTY_PRINT
	do
		create printer.make
		head.accept (printer)
		create rep.make_empty
		rep.append (printer.value)
		rep.append (" is type-correct.")
		set_report (rep)
	end


	set_done
	do
		done := true
	end

	set_cur(ex : EXPRESSION)
	do
		cur := ex
	end

	set_error (error : STRING)
	local
		err : STRING
	do
		create err.make_from_string ("Error (")
		if report.count = 0 then
			err.append (error)
			err.append (").")
			set_report (err)
		end
	end

	set_report(str : STRING)
	do
		if report.count = 0 then
			report := str
		end
	end

	set_success
	do
		if report.count = 0 then
			set_report("OK.")
		end
	end

	default_update
			-- Perform update to the model state.
		do

		end

	reset
			-- Reset model state.
		do
			if head.type /~ "expression" then
				create report.make_from_string ("OK.")
				create head.make (VOID)
				done := false
				cur := head
				cur.set_cur (True)
			else
				create report.make_from_string ("Error (Initial expression cannot be reset).")
			end
		end


feature -- queries
	out : STRING
		local
			printer : PRETTY_PRINT
		do
			create Result.make_from_string ("  Expression currently specified: ")
			create printer.make
			head.accept (printer)
			Result.append (printer.value)
			Result.append ("%N  Report: ")


			-- dumb error in tester
			if report ~ "Error (Set enumeration must be non-empty)." then
				report := "Error: (Set enumeration must be non-empty)."
			end

			Result.append (report)
			report := ""
		end

end





