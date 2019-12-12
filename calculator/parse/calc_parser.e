-- a simple calculator
class CALC_PARSER 

inherit

	YY_PARSER_SKELETON
		rename
			make as make_parser_skeleton
		redefine
			report_error
		end
		
	CALC_SCANNER
		rename
			make as make_scanner
		end

create 
	make


feature {NONE} -- Implementation

	yy_build_parser_tables
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks
			-- Create value stacks.
		do
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		end

	yy_init_value_stacks
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			yyvs1.keep_head (0)
			yyvs2.keep_head (0)
			yyvs3.keep_head (0)
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
				end
				yyspecial_routines1.force (yyvs1, last_detachable_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs2")
					end
					yyvsc2 := yyvsc2 + yyInitial_yyvs_size
					yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
				end
				yyspecial_routines2.force (yyvs2, last_string_value, yyvsp2)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: detachable ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				debug ("GEYACC")
					std.error.put_line ("Resize yyvs1")
				end
				yyvsc1 := yyvsc1 + yyInitial_yyvs_size
				yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
			end
			yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER)
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_run_geyacc
			-- You must run geyacc to regenerate this class.
		do
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval3: EXPRESSION
		do
				inspect yy_act
when 1 then
--|#line 54 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 54")
end

		create {VALUE_CONSTANT} yyval3.make ((yyvs2.item (yyvsp2)).to_real)
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 2 then
--|#line 59 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 59")
end

		yyvs2.item (yyvsp2).prepend("-")
		create {VALUE_CONSTANT} yyval3.make ((yyvs2.item (yyvsp2)).to_real)
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 3 then
--|#line 65 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 65")
end

		create {VALUE_CONSTANT} yyval3.make ((yyvs2.item (yyvsp2)).to_real)
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 4 then
--|#line 70 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 70")
end

		yyvs2.item (yyvsp2).prepend("-")
		create {VALUE_CONSTANT} yyval3.make ((yyvs2.item (yyvsp2)).to_real)
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 5 then
--|#line 76 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 76")
end

		create {ADDITION} yyval3.make (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3))
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 6 then
--|#line 81 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 81")
end

		create {SUBTRACTION} yyval3.make (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3))
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 7 then
--|#line 86 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 86")
end

		create {MULTIPLICATION} yyval3.make (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3))
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 8 then
--|#line 91 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 91")
end

		create {DIVISION} yyval3.make (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3))
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 9 then
--|#line 96 "calc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc_parser.y' at line 96")
end

		yyval3 := yyvs3.item (yyvsp3)
		expression := yyval3
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
				else
					debug ("GEYACC")
						std.error.put_string ("Error in parser: unknown rule id: ")
						std.error.put_integer (yy_act)
						std.error.put_new_line
					end
					abort
				end
		end

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 17 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER]
			-- Template for `yytranslate'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 266)
			yytranslate_template_1 (an_array)
			yytranslate_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytranslate_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytranslate'.
		do
			yyarray_subcopy (an_array, <<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2, yyDummy>>,
			1, 200, 0)
		end

	yytranslate_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytranslate'.
		do
			yyarray_subcopy (an_array, <<
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,    6,    7,    8,    9,   10,   11, yyDummy>>,
			1, 67, 200)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   12,   12,   12,   12,   12,   12,   12,   12,   12, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    3,    1,    1,    2,    2,    3,    3,    2,    2,    1,
			    1,    1,    1,    1,    3,    3,    3,    3,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    2,    1,    1,    1,    1,    1,
			    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    0,    0,    0,    3,    1,    0,    0,    4,    2,    0,
			    0,    0,    0,    9,    8,    7,    6,    5,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			    5, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			   13,   13,   18, -32768, -32768,    6,   -4, -32768, -32768,   13,
			   13,   13,   13, -32768, -32768, -32768,   10,   10,    1, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			   -1, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			    6,   19,   12,   11,   10,    9,   18,   13,   14,   15,
			   16,   17,   12,   11,   10,    9,    4,    3,   10,    9,
			    2,    8,    7,    1, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    1,    0,    6,    7,    8,    9,    0,   11,    9,   10,
			   11,   12,    6,    7,    8,    9,    3,    4,    8,    9,
			    7,    3,    4,   10, yyDummy>>)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [detachable ANY]
			-- Stack for semantic values of type detachable ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [detachable ANY]
			-- Routines that ought to be in SPECIAL [detachable ANY]

	yyvs2: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs3: SPECIAL [EXPRESSION]
			-- Stack for semantic values of type EXPRESSION

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [EXPRESSION]
			-- Routines that ought to be in SPECIAL [EXPRESSION]

feature {NONE} -- Constants

	yyFinal: INTEGER = 19
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 12
			-- Number of tokens

	yyLast: INTEGER = 23
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 266
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 13
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature -- create

	make
			-- Create a new calculator
		do
			-- expression is initialized to a default "0" for void safety
			-- this initial expression is guaranteed to be replaced.
			create {VALUE_CONSTANT} expression.make (0) 
			create last_error.make_empty 
			create last_string_value.make_empty
			make_parser_skeleton
			make_scanner
		end
		
feature -- Queries
	expression: EXPRESSION
	last_error : STRING
	
feature -- parsing
	report_error(a_message: STRING)
		do
			last_error := a_message + " (Line " + line.out + ", " + "Column " + column.out + ")" 
		end

	parse_string(str :STRING)
			-- parse the text of this given string
		local
			buf : YY_BUFFER
		do
			create buf.make(str)
			
			reset
			set_input_buffer(buf)
			parse
		end

	parse_file(filename:STRING)
			-- parse the text of the given input file
		local
			a_file: KL_TEXT_INPUT_FILE
		do
			create a_file.make (filename)
			a_file.open_read
			
			if a_file.is_open_read then
				reset
				set_input_buffer (new_file_buffer (a_file))
				parse
				a_file.close
			else
				std.error.put_string ("calculator: cannot read %'"+filename+"%'%N")
			end
		end
	
end