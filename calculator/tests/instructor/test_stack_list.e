note
	description: "Summary description for {TEST_LIST_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STACK_LIST
inherit
	TEST_STACK_ARRAY
		undefine
			t2 -- will be implemented with list rather than array
		redefine
			make
		end
create
	make
feature {NONE}

	make(a_stack_type:STRING)
			-- Initialization for `Current'.
		do
			Precursor(a_stack_type)
			add_violation_case_with_tag ("pushed_othewise_unchanged",agent t4)
		end
feature
	t2: BOOLEAN
			-- redefin
		local
			stk1: STACK_LIST[STRING]
			imp: LIST[STRING]
		do
			comment("t2: test list implementation")
			create stk1.make
			stk1.push("hello")
			stk1.push("goodbye")
			stk1.push("adios")
			imp := stk1.implementation
			Result := imp[1] ~ "adios"
						and imp[2] ~ "goodbye"
						and imp[3] ~ "hello"

		end

	t4
		local
			stk1: BAD_STACK_LIST[STRING]
			imp: LIST[STRING]
		do
			comment("t3: test {STACK_LIST}.push")
			sub_comment ("<br>post-condition of push not satisfied with bad implementation")
			create stk1.make
			stk1.push("hello")
			stk1.push("goodbye")
			stk1.push("adios")  -- this should fail

		end
end
