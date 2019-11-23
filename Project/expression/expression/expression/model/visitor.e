note
	description: "Summary description for {VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR

feature

	visit_binary_op (b : BINARY_OP)
	deferred
	end

	visit_unary_op (u : UNARY_OP)
	deferred
	end

	visit_boolean_constant (b : BOOLEAN_CONSTANT)
	deferred
	end

	visit_integer_constant (i : INTEGER_CONSTANT)
	deferred
	end

	visit_set_enumeration (s : SET_ENUMERATION)
	deferred
	end

	visit_expression (e : EXPRESSION)
	deferred
	end

	visit_negative(u : UNARY_OP)
	deferred
	end

	visit_negation(u : UNARY_OP)
	deferred
	end

	visit_sigma(u : UNARY_OP)
	deferred
	end

	visit_product(u : UNARY_OP)
	deferred
	end

	visit_counting(u : UNARY_OP)
	deferred
	end

	visit_forall(u : UNARY_OP)
	deferred
	end

	visit_exists(u : UNARY_OP)
	deferred
	end

	visit_addition(b : BINARY_OP)
	deferred
	end

	visit_subtraction(b : BINARY_OP)
	deferred
	end

	visit_multiplication(b : BINARY_OP)
	deferred
	end

	visit_division(b : BINARY_OP)
	deferred
	end

	visit_modulus(b : BINARY_OP)
	deferred
	end

	visit_and(b : BINARY_OP)
	deferred
	end

	visit_or(b : BINARY_OP)
	deferred
	end

	visit_xor(b : BINARY_OP)
	deferred
	end

	visit_implies(b : BINARY_OP)
	deferred
	end

	visit_equals(b : BINARY_OP)
	deferred
	end

	visit_greater_than(b : BINARY_OP)
	deferred
	end

	visit_less_than(b : BINARY_OP)
	deferred
	end

	visit_union(b : BINARY_OP)
	deferred
	end

	visit_intersect(b : BINARY_OP)
	deferred
	end

	visit_difference(b : BINARY_OP)
	deferred
	end

end
