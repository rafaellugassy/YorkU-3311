note
	description: "Summary description for {BOOLEAN_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_CONSTANT

inherit
	EXPRESSION
	redefine
		simplify, analyze, out, check_equal, accept
	end
create
	make_boolean, make

feature {NONE} -- Initialization

	make_boolean(p : detachable EXPRESSION; v : BOOLEAN)
		local
			model_access : ETF_MODEL_ACCESS
			-- Initialization for `Current'.
		do
			m := model_access.m
			cur := False
			done := True
			value := v
			parent := p
			create type.make_from_string ("boolean constant")
			create children.make
		end

feature

	accept (v : VISITOR)
	do
		v.visit_boolean_constant (Current)
	end

	value : BOOLEAN

	check_equal(other : EXPRESSION) : BOOLEAN
	do
		Result := other.type ~ type AND then attached {BOOLEAN_CONSTANT} other as o AND then o.value = value
	end

	out : STRING
	do
		Result := value.out
	end

	simplify : BOOLEAN_CONSTANT
	do
		Result := Current
	end

	analyze : BOOLEAN
	do
		Result := True
	end

end
