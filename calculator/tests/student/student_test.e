note
	description: "Summary description for {STUDENT_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TEST
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	stack_type: STRING

	make(a_stack_type:STRING)
			-- Initialization for `Current'.
		do
			stack_type := a_stack_type
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)


		end

feature -- tests
	t1: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("task1: Evaluate (16.2) and also error condition")
			l_exp := "(16.2)"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value ~ 16.2 and not e.error
			check Result end

			--bad syntax
			l_exp := "(16.2"
			create e.make(stack_type)
			if e.is_valid (l_exp) then
				e.evaluate(l_exp)
			end
			Result := e.error
		end


		t2: BOOLEAN
			local
				l_exp: STRING
				e: EVALUATOR
			do
				comment("task2: Evaluate ( 2 - 3 ) and ( ( 2 - 3 ) * ( 2.1 + 8 ) )")
				l_exp := "( 2 - 3 )"
				create e.make(stack_type)
				e.evaluate(l_exp)
				Result := e.value = -1
				check Result end
				--
				l_exp := "( ( 2 - 3 ) * ( 2.1 + 8 ) )"
				e.evaluate(l_exp)
				assert_equal ("error", "-10.1",e.value.out)
			end



        	t3: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("task3: Evaluate ( 2 - 3 ) and ( ( 2 - 3 ) * ( 2.1 + 8 ) )")
			l_exp := "( 2 - 3 )"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value = -1
			check Result end
			--
			l_exp := "( ( 2 - 3 ) * ( 2.1 + 8 ) )"
			e.evaluate(l_exp)
			assert_equal ("error", "-10.1",e.value.out)
		end


		t4: BOOLEAN
			local
				ar : STACK_ARRAY[INTEGER]
				list : STACK_LIST[INTEGER]
			do
				comment ("task4: test size of lists, and model equivalence")
				create ar.make
				create list.make
				ar.push (1)
				ar.push (23)
				ar.push (32)
				list.push (1)
				list.push (23)
				list.push (32)
				Result := ar.count = list.count and ar.count = 3 and ar.model ~ list.model
			end

		t5: BOOLEAN
			local
				l_exp: STRING
				e: EVALUATOR
			do
				comment("task5: Evaluate ( 2 * 3 ) - ( 4 / 2 )")
				create e.make(stack_type)
				check Result end
				l_exp := "( ( 2 * 3 ) - ( 4 / 2 ) )"
				e.evaluate(l_exp)
				Result := e.value = 4
			end

		t6: BOOLEAN
			local
				ar : STACK_ARRAY[INTEGER]
				list : STACK_LIST[INTEGER]
			do
				comment ("task6: test pop")
				create ar.make
				create list.make
				ar.push (1)
				ar.push (23)
				ar.push (32)
				list.push (1)
				list.push (23)
				list.push (32)
				ar.pop
				ar.pop
				list.pop
				list.pop
				Result := ar.count = list.count and ar.count = 1 and ar.model ~ list.model and ar.model[1] = 1
			end


end
