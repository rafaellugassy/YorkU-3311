note
	description: "Summary description for {INTEGER_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_CONSTANT

inherit
	EXPRESSION
	redefine
		out, simplify, analyze, check_equal, accept
	end
create
	make, make_integer

feature {NONE} -- Initialization

	make_integer (p : detachable EXPRESSION; v : INTEGER)
		local
			model_access : ETF_MODEL_ACCESS
			-- Initialization for `Current'.
		do
			m := model_access.m
			value := v
			parent := p
			cur := False
			done := True
			create type.make_from_string ("integer constant")
			create children.make
		end

feature
	value : INTEGER

	accept (v : VISITOR)
	do
		v.visit_integer_constant (Current)
	end

	check_equal(other : EXPRESSION) : BOOLEAN
	do
		Result := other.type ~ type AND then attached {INTEGER_CONSTANT} other as o AND then o.value = value
	end

	out : STRING
	do
		Result := value.out
	end

	simplify : INTEGER_CONSTANT
	do
		Result := Current
	end

	analyze : BOOLEAN
	do
		Result := True
	end

end
