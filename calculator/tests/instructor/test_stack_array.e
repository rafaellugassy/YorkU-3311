note
	description: "Summary description for {TEST_STACK_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STACK_ARRAY
inherit
	ES_TEST
create
	make
feature
	stack_type: STRING

	make(a_stack_type:STRING)
			-- Initialization for `Current'.
		do
			stack_type := a_stack_type
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
		end

	make_stack: ABSTRACT_STACK[STRING]
			-- a basic creation pattern
		do
			if stack_type ~ "array" then
				create {STACK_ARRAY[STRING]}Result.make
			else
				check stack_type ~ "list" end
				create {STACK_LIST[STRING]}Result.make
			end
		end

feature -- tests
	t0: BOOLEAN
		local
			stk1, stk2: ABSTRACT_STACK[STRING]
		do
			comment("t0: create empty stack")
			stk1 := make_stack
			Result := stk1.count = 0 -- empty
			check Result end
		end

	t1: BOOLEAN
		local
			stk1, stk2: ABSTRACT_STACK[STRING]
		do
			comment("t1: create stack, pop and push")
			stk1 := make_stack
			Result := stk1.count = 0 -- empty
			check Result end
			---
			stk1.push("hello")
			Result := stk1.count = 1 and stk1.top ~ "hello"
			check Result end
			stk1.push("goodbye")
			Result := stk1.count = 2 and stk1.top ~ "goodbye"
			check Result end
			stk2 := stk1.deep_twin

			-- push, then pop produces original stack
			stk1.push("adios")
			Result := stk1.count = 3 and stk1.top ~ "adios"
			check Result end
			stk1.pop
			Result := stk1.is_equal (stk2)
			check Result end
			--
			stk1.pop
			Result := stk1.count = 1 and stk1.top ~ "hello"
		end

	t2: BOOLEAN
		local
			stk1: STACK_ARRAY[STRING]
			imp: ARRAY[STRING]
		do
			comment("t2: test array implementation")
			create stk1.make
			stk1.push("hello")
			stk1.push("goodbye")
			stk1.push("adios")
			imp := stk1.implementation
			Result := imp[1] ~ "hello"
						and imp[2] ~ "goodbye"
						and imp[3] ~ "adios"

		end
end
