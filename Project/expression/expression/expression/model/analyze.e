note
	description: "Summary description for {ANALYZE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ANALYZE

inherit
	VISITOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			model_access : ETF_MODEL_ACCESS
		do
			create value.make (VOID)
			m := model_access.m
		end

feature

	error : BOOLEAN
	m : ETF_MODEL
	value : EXPRESSION

	visit_binary_op (b : BINARY_OP)
	do
		-- give error (for not being done)
		error := True
	end

	visit_unary_op (u : UNARY_OP)
	do
		-- give error (for not being done)
		error := True
	end

	visit_boolean_constant (b : BOOLEAN_CONSTANT)
	do
		value := b
	end

	visit_integer_constant (i : INTEGER_CONSTANT)
	do
		value := i
	end

	visit_set_enumeration (s : SET_ENUMERATION)
	local
		simplified_set : LINKED_LIST[ANALYZE]
	do
		create simplified_set.make
		across s.children as cursor
		loop
			simplified_set.force (create {ANALYZE}.make)
			cursor.item.accept (simplified_set.last)
		end

		if across simplified_set as cursor some cursor.item.error end then
			error := true
		elseif across simplified_set as cursor all cursor.item.value.type ~ simplified_set.at(1).value.type end then
			value := create {SET_ENUMERATION}.make_set (VOID)
			across simplified_set as cursor
			loop
				value.children.force (cursor.item.value)
			end
		else
			-- type error
			error := true
		end
	end

	visit_expression (e : EXPRESSION)
	do
		-- give error (for not being done)
		error := true
	end

	visit_negative(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} child.value as val then
			if child.error then
				error := true
			else
				value := u.negative (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_negation(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "boolean constant" AND then attached {BOOLEAN_CONSTANT} child.value as val then
			if child.error then
				error := true
			else
				value := u.negation (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_sigma(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} child.value as val then
			if child.error then
				error := true
			else
				value := u.sigma (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_product(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} child.value as val then
			if child.error then
				error := true
			else
				value := u.product (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_counting(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} child.value as val then
			if child.error then
				error := true
			else
				value := u.counting (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_forall(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} child.value as val then
			if child.error then
				error := true
			else
				value := u.forall (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_exists(u : UNARY_OP)
	local
		child : ANALYZE
	do
		create child.make
		u.children.at (1).accept (child)
		if child.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} child.value as val then
			if child.error then
				error := true
			else
				value := u.exists (val)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_addition(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.addition (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_subtraction(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.subtraction (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_multiplication(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.multiplication (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_division(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			elseif r.value = 0 then
				-- give divide by 0 error
				value := create {INTEGER_CONSTANT}.make_integer (VOID, 1)
			else
				value := b.division (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_modulus(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			elseif r.value = 0 then
				-- give divide by 0 error
				value := create {INTEGER_CONSTANT}.make_integer (VOID, 1)
			else
				value := b.modulus (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_and(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "boolean constant" AND then right.value.type ~ "boolean constant" AND then attached {BOOLEAN_CONSTANT} left.value as l AND then attached {BOOLEAN_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.and_op (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_or(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "boolean constant" AND then right.value.type ~ "boolean constant" AND then attached {BOOLEAN_CONSTANT} left.value as l AND then attached {BOOLEAN_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.or_op (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_xor(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "boolean constant" AND then right.value.type ~ "boolean constant" AND then attached {BOOLEAN_CONSTANT} left.value as l AND then attached {BOOLEAN_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.xor_op (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_implies(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "boolean constant" AND then right.value.type ~ "boolean constant" AND then attached {BOOLEAN_CONSTANT} left.value as l AND then attached {BOOLEAN_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.implies_op (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_equals(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "boolean constant" AND then right.value.type ~ "boolean constant" AND then attached {BOOLEAN_CONSTANT} left.value as l AND then attached {BOOLEAN_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.equals_boolean (l, r)
			end
		elseif left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.equals_integer (l, r)
			end
		elseif left.value.type ~ "set enumeration" AND then right.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} left.value as l AND then attached {SET_ENUMERATION} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.equals_set (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_greater_than(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.greater_than (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_less_than(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "integer constant" AND then right.value.type ~ "integer constant" AND then attached {INTEGER_CONSTANT} left.value as l AND then attached {INTEGER_CONSTANT} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.less_than (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_union(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "set enumeration" AND then right.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} left.value as l AND then attached {SET_ENUMERATION} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.union (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_intersect(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "set enumeration" AND then right.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} left.value as l AND then attached {SET_ENUMERATION} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.intersect (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end

	visit_difference(b : BINARY_OP)
	local
		left : ANALYZE
		right : ANALYZE
	do
		create left.make
		create right.make
		b.children.at (1).accept (left)
		b.children.at (2).accept(right)
		if left.value.type ~ "set enumeration" AND then right.value.type ~ "set enumeration" AND then attached {SET_ENUMERATION} left.value as l AND then attached {SET_ENUMERATION} right.value as r then
			if left.error or right.error then
				error := true
			else
				value := b.difference (l, r)
			end
		else
			m.set_analyze_error
			error := true
		end
	end


end
