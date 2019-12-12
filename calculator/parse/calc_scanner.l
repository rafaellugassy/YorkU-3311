%{
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
%}

-- instructs gelex to send its output to the file calc_scanner.e rather than stdout
%option nodefault outfile="calc_scanner.e"

TK_PLUS	  		"+"
TK_MINUS     	"-"
TK_TIMES	  	"*"
TK_DIVIDE     	"/"
TK_LPAREN	  	"("
TK_RPAREN     	")"

-- a digit is 1 or more characters between 0 and 9
DIGIT		[0-9]+

-- whitespace is 1 or more spaces, tabs, or carriage returns
WS		[ \t\r]+

-- Starting from %%, we specify token-matching rules.
%%

{WS}		-- ignore whitespaces

[\n\r?]		{ -- return an end-of-line token when the new line character is encountered
			last_token := EOL 
		}

{TK_PLUS}	    {last_token := TK_PLUS}
{TK_MINUS}     	{last_token := TK_MINUS}
{TK_TIMES}	    {last_token := TK_TIMES}
{TK_DIVIDE}     {last_token := TK_DIVIDE}
{TK_LPAREN}	    {last_token := TK_LPAREN}
{TK_RPAREN}     {last_token := TK_RPAREN}
		
{DIGIT}		{ -- return a digit token and store the integer value in last_integer_value, which the parser will use
			-- last_integer_value := text.to_integer
			-- We did not opt for the above because the string may
			-- go beyond the capacity of 64-bit integer, so 
			-- we store its string value and covert it into VALUE (at the .y file).
			last_string_value := text
			last_token := NUMBER
			-- NUMBER is a token name that we made up, and this
			-- should be declared and referenced in .y file.
		}

{DIGIT}+"."{DIGIT}+  {
		                 -- last_real_value := text.to_real
						 last_string_value := text -- keep the original string rep. for VALUE, if applicable
		                 last_token := REAL
        }
		
.		{  -- . here means any character not matched by the previous rules,
		   -- in which case we simply set last_token to be the code of character.
		   -- Since the parser will not refer to this character, it will be
		   -- considered as syntax error. 
			last_token := text_item (1).code
		}

%%

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
