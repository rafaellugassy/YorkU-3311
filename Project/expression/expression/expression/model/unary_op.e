note
	description: "Summary description for {UNARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_OP

inherit
	EXPRESSION
	redefine
		out, accept
	end

create
	make_unary_op

feature {NONE} -- Initialization

	make_unary_op (p : detachable EXPRESSION; sym : STRING)
			-- Initialization for `Current'.
		local
		model_access : ETF_MODEL_ACCESS
	do
		m := model_access.m
		parent := p
		create children.make
		create type.make_from_string("unary op")
		cur := False
		done := False
		create symbol.make_from_string (sym)
		children.force (create {EXPRESSION}.make (Current))
		children.at (1).set_cur (True)
	end

feature

	accept (v : VISITOR)
	do
		if symbol ~ "-" then
			v.visit_negative(Current)
		elseif symbol ~ "!" then
			v.visit_negation(Current)
		elseif symbol ~ "+" then
			v.visit_sigma(Current)
		elseif symbol ~ "*" then
			v.visit_product(Current)
		elseif symbol ~ "#" then
			v.visit_counting(Current)
		elseif symbol ~ "&&" then
			v.visit_forall(Current)
		elseif symbol ~ "||" then
			v.visit_exists(Current)
		end
	end

	symbol : STRING

	out : STRING
	do
		create Result.make_from_string("(")
		Result.append(symbol)
		Result.append(" ")
		Result.append(children.at(1).out)
		Result.append(")")
	end

	negative (exp : INTEGER_CONSTANT) : INTEGER_CONSTANT
	do
		create Result.make_integer (parent, (exp.value * (-1)))
	end

	negation (exp : BOOLEAN_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (not exp.value))
	end

	sigma (exp : SET_ENUMERATION) : INTEGER_CONSTANT
	local
		sum : INTEGER
	do
		sum := 0
		across exp.children as cursor
		loop
			if attached {INTEGER_CONSTANT} cursor.item as c then
				sum := sum + c.value
			end
		end
		create Result.make_integer (parent, sum)
	end

	product (exp : SET_ENUMERATION) : INTEGER_CONSTANT
	local
		sum : INTEGER
	do
		sum := 1
		across exp.children as cursor
		loop
			if attached {INTEGER_CONSTANT} cursor.item as c then
				sum := sum * c.value
			end
		end
		create Result.make_integer (parent, sum)
	end

	counting (exp : SET_ENUMERATION) : INTEGER_CONSTANT
	local
		sum : INTEGER
	do
		sum := 0
		across exp.children as cursor
		loop
			if attached {BOOLEAN_CONSTANT} cursor.item as c AND then c.value then
				sum := sum + 1
			end
		end
		create Result.make_integer (parent, sum)
	end

	forall (exp : SET_ENUMERATION) : BOOLEAN_CONSTANT
	local
		val : BOOLEAN
	do
		val := across exp.children as cursor
		all
			attached {BOOLEAN_CONSTANT} cursor.item as c AND then c.value
		end
		create Result.make_boolean (parent, val)
	end

	exists (exp : SET_ENUMERATION) : BOOLEAN_CONSTANT
	local
		val : BOOLEAN
	do
		val := across exp.children as cursor
		some
			attached {BOOLEAN_CONSTANT} cursor.item as c AND then c.value
		end
		create Result.make_boolean (parent, val)
	end

end
