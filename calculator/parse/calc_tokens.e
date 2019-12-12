note

	description: "Parser token codes"
	generator: "geyacc version 4.1"

deferred class CALC_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_detachable_any_value: detachable ANY
	last_string_value: STRING

feature -- Access

	token_name (a_token: INTEGER): STRING
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when NUMBER then
				Result := "NUMBER"
			when REAL then
				Result := "REAL"
			when EOL then
				Result := "EOL"
			when TK_PLUS then
				Result := "TK_PLUS"
			when TK_MINUS then
				Result := "TK_MINUS"
			when TK_TIMES then
				Result := "TK_TIMES"
			when TK_DIVIDE then
				Result := "TK_DIVIDE"
			when TK_LPAREN then
				Result := "TK_LPAREN"
			when TK_RPAREN then
				Result := "TK_RPAREN"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	NUMBER: INTEGER = 258
	REAL: INTEGER = 259
	EOL: INTEGER = 260
	TK_PLUS: INTEGER = 261
	TK_MINUS: INTEGER = 262
	TK_TIMES: INTEGER = 263
	TK_DIVIDE: INTEGER = 264
	TK_LPAREN: INTEGER = 265
	TK_RPAREN: INTEGER = 266

end
