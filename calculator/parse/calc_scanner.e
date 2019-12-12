deferred class CALC_SCANNER

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		-- This class declares: last_token, last_integer, last_string_value
		-- text (the current string being matched by a rule)
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		end
		
	CALC_TOKENS

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (sc = INITIAL)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 36 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 36")
end
-- ignore whitespaces
when 2 then
--|#line 38 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 38")
end
 -- return an end-of-line token when the new line character is encountered
			last_token := EOL 
		
when 3 then
--|#line 42 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 42")
end
last_token := TK_PLUS
when 4 then
--|#line 43 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 43")
end
last_token := TK_MINUS
when 5 then
--|#line 44 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 44")
end
last_token := TK_TIMES
when 6 then
--|#line 45 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 45")
end
last_token := TK_DIVIDE
when 7 then
--|#line 46 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 46")
end
last_token := TK_LPAREN
when 8 then
--|#line 47 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 47")
end
last_token := TK_RPAREN
when 9 then
--|#line 49 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 49")
end
 -- return a digit token and store the integer value in last_integer_value, which the parser will use
			-- last_integer_value := text.to_integer
			-- We did not opt for the above because the string may
			-- go beyond the capacity of 64-bit integer, so 
			-- we store its string value and covert it into VALUE (at the .y file).
			last_string_value := text
			last_token := NUMBER
			-- NUMBER is a token name that we made up, and this
			-- should be declared and referenced in .y file.
		
when 10 then
--|#line 60 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 60")
end

		                 -- last_real_value := text.to_real
						 last_string_value := text -- keep the original string rep. for VALUE, if applicable
		                 last_token := REAL
        
when 11 then
--|#line 66 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 66")
end
  -- . here means any character not matched by the previous rules,
		   -- in which case we simply set last_token to be the code of character.
		   -- Since the parser will not refer to this character, it will be
		   -- considered as syntax error. 
			last_token := text_item (1).code
		
when 12 then
--|#line 0 "calc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'calc_scanner.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		once
			Result := yy_fixed_array (<<
			    0,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			    4,   13,   14,   15,   17,   16,   18,   19,   19,   20,
			    3,   20,   20,   20,   20,   20,   20,   20,   20,   20,
			   20,   20,   20,   20, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,   14,   21,   14,   19,   17,    3,
			   20,   20,   20,   20,   20,   20,   20,   20,   20,   20,
			   20,   20,   20,   20, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   19,   20,    0,   20,    0,   20,   20,
			   20,   20,   20,   20,    4,   20,    0,    6,    0,    5,
			   20,   13, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		once
			Result := yy_fixed_array (<<
			    0,   20,    1,   20,   20,   21,   20,   21,   20,   20,
			   20,   20,   20,   20,   20,   20,   21,   20,   14,   20,
			    0,   20, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 256)
			yy_ec_template_1 (an_array)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    1,    1,    1,    1,    1,    1,
			    5,    6,    7,    8,    1,    9,   10,   11,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,    1,    1,
			    1,    1,    1,   13,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    1,    2,    1,    1,    1,    1,    1,
			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   13,   11,    1,    2,    1,    7,    8,
			    5,    3,    4,    6,    9,    2,    1,    0,    9,   10,
			    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 20
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 20
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 21
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 12
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 13
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Initialization

	make 
		do
			make_compressed_scanner_skeleton
		end

feature -- reset

	reset 
		do
			reset_compressed_scanner_skeleton
		end

end
