--
--	grammar for simple calculator
--
%{
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

%}

-- the symbol calculate is the root of the parse tree
%start	expr_list

-- these are tokens that appear as part of the grammar in addition to single characters
%token				EOL -- an end-of-line character
%token<INTEGER> 	NUMBER -- a integer number
%token				TK_PLUS
%token				TK_MINUS
%token				TK_TIMES
%token				TK_DIVIDE
%token				TK_LPAREN
%token				TK_RPAREN

%left TK_PLUS TK_MINUS
%left TK_TIMES TK_DIVIDE

%type<EXPRESSION> 				expr
%type<ARRAY[EXPRESSION]>	 	expr_list

%%

expr_list :
		-- Empty list 
	{
		create {ARRAY[EXPRESSION]} $$.make_empty
	}
	|		
	expr_list expr EOL {
		$$ := $1
		$$.force ($2, $$.upper + 1)
		expression_list := $$
	}
	;

expr : 
	expr TK_PLUS expr {
		create {ADDITION} $$.make ($1, $3)
	}
	|	
	expr TK_MINUS expr {
		create {SUBTRACTION} $$.make ($1, $3)
	}
	|
	NUMBER {
		create {INTEGER_CONSTANT} $$.make ($1)
	}
	|
	TK_LPAREN expr TK_RPAREN {
		$$ := $2
	}
	|
	expr TK_TIMES expr {
		create {MULTIPLICATION} $$.make ($1, $3)
	}
	|	
	expr TK_DIVIDE expr {
		create {DIVISION} $$.make ($1, $3)
	}
	;

%%

feature -- create

	make
			-- Create a new calculator
		do
			create last_error.make_empty
			create expression_list.make_empty
			make_parser_skeleton
			make_scanner
		end
		
feature -- Queries
	expression_list: ARRAY[EXPRESSION]
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