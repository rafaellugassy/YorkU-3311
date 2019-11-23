note
	description: "Summary description for {PRETTY_PRINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRETTY_PRINT

inherit
	VISITOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create value.make_empty
		end

feature

	value : STRING

	visit_binary_op (b : BINARY_OP)
	local
		left : PRETTY_PRINT
		right : PRETTY_PRINT
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept (right)
		value.append ("(")
		value.append (left.value)
		value.append (" ")
		value.append (b.symbol)
		value.append (" ")
		value.append (right.value)
		value.append (")")
	end

	visit_unary_op (u : UNARY_OP)
	local
		child : PRETTY_PRINT
	do
		create child.make
		u.children.at (1).accept (child)
		value.append ("(")
		value.append (u.symbol)
		value.append (" ")
		value.append (child.value)
		value.append (")")
	end

	visit_boolean_constant (b : BOOLEAN_CONSTANT)
	do
		value.append (b.value.out)
	end

	visit_integer_constant (i : INTEGER_CONSTANT)
	do
		value.append (i.value.out)
	end

	visit_set_enumeration (s : SET_ENUMERATION)
	local
		first : BOOLEAN
		printed_set : LINKED_LIST[PRETTY_PRINT]
	do
		create printed_set.make
		first := true
		value.append ("{")
		across s.children as child
		loop
			if not first then
				value.append(", ")
			end
			printed_set.force (create {PRETTY_PRINT}.make)
			child.item.accept (printed_set.last)
			value.append(printed_set.last.value)
			first := false
		end
		value.append ("}")
	end

	visit_expression (e : EXPRESSION)
	do
		if e.cur then
			value.append ("?")
		else
			value.append ("nil")
		end
	end

	visit_negative(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_negation(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_sigma(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_product(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_counting(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_forall(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_exists(u : UNARY_OP)
	do
		visit_unary_op(u)
	end

	visit_addition(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_subtraction(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_multiplication(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_division(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_modulus(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_and(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_or(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_xor(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_implies(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_equals(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_greater_than(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_less_than(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_union(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_intersect(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

	visit_difference(b : BINARY_OP)
	do
		visit_binary_op(b)
	end

end
