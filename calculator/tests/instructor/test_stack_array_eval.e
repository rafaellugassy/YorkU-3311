note
	description: "Summary description for {TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STACK_ARRAY_EVAL
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

			--violation cases
			add_violation_case_with_tag ("valid_expression", agent t10)
			add_violation_case_with_tag ("valid_expression", agent t11)
		end

feature -- tests
	t1: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t1: Evaluate (16.2) and also error condition")
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
			i64: STRING
		do
			comment("t2: Evaluate (-922337267) and error condition")
			i64 := "-922337267" -- on less than min value
			l_exp := "(" + i64 + ")"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value = -9.22337e+08 and not e.error
			check Result end
		end

	t3: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t3: Evaluate (2+ 3 ) and ( ( 3.1 + 2.9 ) + ( 2 + 8 ) )")
			l_exp := "(2+ 3 )"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value = 5
			check Result end
			--
			l_exp := "( ( 3.1 + 2.9 ) + ( 2 + 8 ) )"
			e.evaluate(l_exp)
			assert_equal ("error", "16", e.value.out)
			-- assert_equal uses string comparison, hence e.item.out
		end

	t4: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t4: Evaluate ( 2 - 3 ) and ( ( 2 - 3 ) * ( 2.1 + 8 ) )")
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

	t5: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t5: Evaluate ( -2 - 3 ) and ( ( -2 - 3 ) * ( -2.1 + 8 ) )")
			l_exp := "( -2 - 3 )"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value = -5
			check Result end
			--
			l_exp := "( ( -2 - 3 ) * ( -2.1 + 8 ) )"
			e.evaluate(l_exp)
			assert_equal ("error", "-29.5", e.value.out)
			-- e.item means we are comparing a value with a string

			-- test a more complicated expression
			l_exp := "(2.34*6.1 - 110.1/42.3)+3.5"
			-- precondition check:
			--first check that the expression can be parsed
			check e.is_valid (l_exp) end
			-- now call for evaluation
			e.evaluate(l_exp)
			Result := (e.value - 15.1712).abs <= .0001
			check Result end

			-- now some bad syntax, unbalanced parenthesis
			l_exp := "(2.34*6.1 - 110.1/42.3))+3.5"
			Result :=  not e.is_valid (l_exp)
			-- so do not call e.evaluate
		end


	t6: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t6: (2.34*6.1 - 110.1/42.3))+3.5 unbalanced parenthesis")
			sub_comment ("<br>better error reporting needed ...")
			create e.make(stack_type)
			-- now some bad syntax, unbalanced parenthesis
			l_exp := "(2.34*6.1 - 110.1/42.3))+3.5"
			Result :=  not e.is_valid (l_exp)
			-- so do not call e.evaluate
			check Result end
			Result := e.error_string (l_exp) ~ "parse error (Line 1, Column 1)"
			check Result end
		end
feature -- failures

	t10
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t10: bad syntax (99.8843 ++ 7.823) - (44.882/23.85668)")
			sub_comment("Precondition of `evaluate' violated due to `++'")
			l_exp := "(99.8843 ++ 7.823) - (44.882/23.85668)"
			create e.make("array")
			e.evaluate (l_exp)  -- precondition not satisfied
		end

	t11
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t11: (.1 + .1 + .1) syntax not allowed, need 0.1")
			l_exp := "(.1 + .1 + .1)" -- syntax not allowed; why not
--			l_exp := "(0.1 + 0.1 + 0.1)" -- this is ok
			create e.make("array")
			e.evaluate(l_exp)

		end


end
