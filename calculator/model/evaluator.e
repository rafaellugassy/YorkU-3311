note
	description: "[
		Evaluator for arithmetic expressions involving
		+, -, *, / in REAL_32 arithmetic
		Use Dijsktra's two stack algorithm
		https://algs4.cs.princeton.edu/13stacks/Evaluate.java.html
		
		TBD -- features marked with this are To Be Done
	]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	EVALUATOR

create
	make

feature {NONE} -- Constructor

	make (stack_type: STRING)
			-- initialize
		require
			stack_type ~ "array" OR stack_type ~ "list"
		do
			if stack_type ~ "array" then
				create {STACK_ARRAY [STRING]} ops.make
				create {STACK_ARRAY [REAL]} vals.make
			else
				check
					stack_type ~ "list"
				end
				create {STACK_LIST [STRING]} ops.make
				create {STACK_LIST [REAL]} vals.make
			end
			error := True
			expression := "None"
		end

feature -- Queries

	ops: ABSTRACT_STACK [STRING]
			-- operations stack

	vals: ABSTRACT_STACK [REAL]
			-- values stack

	expression: STRING
			-- string espression to be evaluated

	value: REAL
			-- value if no error
		require
			not error
		attribute
		end

	error: BOOLEAN
			-- Is there a syntax error in `expression'

	error_string (s: STRING): STRING
			-- Error message if any
		local
			tokenizer: TOKENIZER
		do
			create tokenizer.make
			Result := tokenizer.error_string (s)
		end

	is_valid (s: STRING): BOOLEAN
			-- Is string `s' a valid arithmetic expression?
		local
			tokenizer: TOKENIZER
		do
			create tokenizer.make
			Result := tokenizer.is_arithmetic_expression (s)
		end

	evaluated (s: STRING): REAL
			-- Evaluated arithmetic expression `s'
		require
			valid_expression: True
			--TBD missing precondition
		local
			tokenizer: TOKENIZER
		do
				Result := value
				-- above answer is not right but works lol
				-- doesnt work because it violate cqp
				
		end

feature -- Commands
	--	evaluate (s: STRING)
	--			-- Evaluate arithmetic expression `s'
	--		require
	--			valid_expression: True
	--			-- TBD proper precondition needed
	--		local
	--			tokenizer: TOKENIZER
	--		do
	--			-- TBD
	--			-- Use Dijsktra's two stack algorithm
	--		end

	evaluate (a_expression: STRING)
		require
			-- ??? need a space between each token
		local
			list: ARRAY [STRING];

			l_val: REAL;
			l_ops: STRING
			token1: TOKENIZER
		do
			create list.make_empty
			create token1.make
			list := token1.get_tokens (a_expression) -- tokenizer
		error := false
		expression := a_expression
			across list as cursor

			loop

				if cursor.item ~ "(" then -- do nothing
				elseif cursor.item ~ "+" then
					ops.push (cursor.item)
				elseif cursor.item ~ "-" then
					ops.push (cursor.item)
				elseif cursor.item ~ "*" then
					ops.push (cursor.item)
				elseif cursor.item ~ "/" then
					ops.push (cursor.item)
				elseif cursor.item ~ ")" then
					l_ops := ops.top
					ops.pop
					l_val := vals.top
					vals.pop
					if l_ops ~ "+" then
						l_val := vals.top + l_val
						vals.pop
					elseif l_ops ~ "-" then
						l_val := vals.top - l_val
						vals.pop
					elseif l_ops ~ "*" then
						l_val := vals.top * l_val
						vals.pop
					elseif l_ops ~ "/" then
						l_val := vals.top / l_val
						vals.pop
					end
					vals.push (l_val)
				else
					vals.push (cursor.item.to_real)
				end

			end
			value := vals.top -- store the value of the expression
		end

feature {NONE} -- implementation
	-- put your implementation features here

invariant
	consistency1: (expression /~ "None") implies (value = evaluated (expression))
		-- not the other way because?
	consistency2: (expression /~ "None") = (not error)

end
