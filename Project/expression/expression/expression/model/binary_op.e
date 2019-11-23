note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_OP

inherit
	EXPRESSION
	redefine
		out, accept
	end

create
	make_binary_op

feature {NONE} -- Initialization

	make_binary_op (p : detachable EXPRESSION; sym : STRING)
	local
		model_access : ETF_MODEL_ACCESS
	do
		m := model_access.m
		parent := p
		create children.make
		create type.make_from_string("binary op")
		cur := False
		done := False
		create symbol.make_from_string (sym)
		children.force (create {EXPRESSION}.make (Current))
		children.force (create {EXPRESSION}.make (Current))
		children.at (1).set_cur (True)
	end


feature

	symbol : STRING

	accept(v : VISITOR)
	do
		if symbol ~ "+" then
			v.visit_addition (Current)
		elseif symbol ~ "-" then
			v.visit_subtraction(Current)
		elseif symbol ~ "*" then
			v.visit_multiplication(Current)
		elseif symbol ~ "/" then
			v.visit_division(Current)
		elseif symbol ~ "mod" then
			v.visit_modulus(Current)
		elseif symbol ~ "&&" then
			v.visit_and(Current)
		elseif symbol ~ "||" then
			v.visit_or(Current)
		elseif symbol ~ "xor" then
			v.visit_xor(Current)
		elseif symbol ~ "=>" then
			v.visit_implies(Current)
		elseif symbol ~ "=" then
			v.visit_equals(Current)
		elseif symbol ~ ">" then
			v.visit_greater_than(Current)
		elseif symbol ~ "<" then
			v.visit_less_than(Current)
		elseif symbol ~ "\/" then
			v.visit_union(Current)
		elseif symbol ~ "/\" then
			v.visit_intersect(Current)
		elseif symbol ~ "\" then
			v.visit_difference(Current)
		end
	end

	out : STRING
		do
			create Result.make_from_string ("(")
			Result.append (children.at (1).out)
			Result.append (" ")
			if attached symbol as sym then
				Result.append (sym)
			end
			Result.append (" ")
			Result.append (children.at (2).out)
			Result.append (")")
		end

	addition (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : INTEGER_CONSTANT
	do
		create Result.make_integer(parent, (exp1.value + exp2.value))
	end

	subtraction (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : INTEGER_CONSTANT
	do
		create Result.make_integer(parent, (exp1.value - exp2.value))
	end

	multiplication (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : INTEGER_CONSTANT
	do
		create Result.make_integer(parent, (exp1.value * exp2.value))
	end

	division (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : INTEGER_CONSTANT
	do
		create Result.make_integer(parent, (exp1.value // exp2.value))
	end

	modulus (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : INTEGER_CONSTANT
	do
		create Result.make_integer(parent, (exp1.value \\ exp2.value))
	end

	and_op (exp1 : BOOLEAN_CONSTANT; exp2 : BOOLEAN_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value AND exp2.value))
	end

	or_op (exp1 : BOOLEAN_CONSTANT; exp2 : BOOLEAN_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value OR exp2.value))
	end

	xor_op (exp1 : BOOLEAN_CONSTANT; exp2 : BOOLEAN_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value XOR exp2.value))
	end

	implies_op (exp1 : BOOLEAN_CONSTANT; exp2 : BOOLEAN_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value IMPLIES exp2.value))
	end

	equals_boolean (exp1 : BOOLEAN_CONSTANT; exp2 : BOOLEAN_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value ~ exp2.value))
	end

	equals_integer (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value = exp2.value))
	end

	equals_set (exp1 : SET_ENUMERATION; exp2 : SET_ENUMERATION) : BOOLEAN_CONSTANT
	local
		empty_set : SET_ENUMERATION
	do
		create empty_set.make_set (VOID)
		create Result.make_boolean (parent, union(exp1,empty_set).check_equal(union(exp2, empty_set)))
	end

	greater_than (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value > exp2.value))
	end

	less_than (exp1 : INTEGER_CONSTANT; exp2 :INTEGER_CONSTANT) : BOOLEAN_CONSTANT
	do
		create Result.make_boolean (parent, (exp1.value < exp2.value))
	end

	union (exp1 : SET_ENUMERATION; exp2 : SET_ENUMERATION) : SET_ENUMERATION
	do
		create Result.make_set (parent)
		across exp1.children as cursor
		loop
			if not across Result.children as cursor_1 some cursor.item.check_equal (cursor_1.item) end then
				Result.children.force(cursor.item)
			end
		end

		across exp2.children as cursor
		loop
			if not across Result.children as cursor_1 some cursor.item.check_equal (cursor_1.item) end then
				Result.children.force(cursor.item)
			end
		end
	end

	intersect (exp1 : SET_ENUMERATION; exp2 : SET_ENUMERATION) : SET_ENUMERATION
	local
		empty_set : SET_ENUMERATION
	do
		create empty_set.make_set (VOID)
		create Result.make_set (parent)
		across exp1.children as cursor_1
		loop
			if across exp2.children as cursor_2 some cursor_1.item.check_equal (cursor_2.item) end then
				Result.children.force (cursor_1.item)
			end
		end

		Result := union (Result, empty_set)

	end

	difference (exp1 : SET_ENUMERATION; exp2 : SET_ENUMERATION) : SET_ENUMERATION
	local
		empty_set : SET_ENUMERATION
	do
		create empty_set.make_set (VOID)
		create Result.make_set (parent)
		across exp1.children as cursor_1
		loop
			if across exp2.children as cursor_2 all not cursor_1.item.check_equal (cursor_2.item) end then
				Result.children.force (cursor_1.item)
			end
		end

		Result := union(Result, empty_set)
	end


end
