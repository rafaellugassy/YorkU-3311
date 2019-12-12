note
	description: "[
		Facade for accessing PARSER
		(1) Checks for a valid expression
		(2) Obtains tokens as a linear ARRAY
		from the abstract syntac tree in CLAC_PARSER
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOKENIZER

create
	make

feature {NONE} -- Implementation
	parser: CALC_PARSER

	make
		do
			create parser.make
		end

feature -- Queries

	is_arithmetic_expression (s: STRING): BOOLEAN
			-- Is 's' a valid arithmetic expression?
		do
			parser.make
			parser.parse_string (s)
			Result := parser.last_error.is_empty
		end

	error_string (s: STRING): STRING
			-- Is 's' a valid arithmetic expression?
		do
			parser.make
			parser.parse_string (s)
			Result := parser.last_error
		end

	get_tokens (s: STRING): ARRAY[STRING]
		require
			valid_expression: is_arithmetic_expression (s)
		do
			create Result.make_empty
			parser.parse_string (s)
			across
				parser.expression as token_cursor
			loop
				Result.force (token_cursor.item, Result.count + 1)
			end
		ensure
			-- TREE(parser.expression).in_order_traversal ~ Result
		end

end
