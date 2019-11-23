class
 	 ETF_TYPE_CONSTRAINTS
feature -- list of enumeratd constants
	enum_items : HASH_TABLE[INTEGER, STRING]
		do
			create Result.make (10)
		end

	enum_items_inverse : HASH_TABLE[STRING, INTEGER_64]
		do
			create Result.make (10)
		end
feature -- query on declarations of event parameters
	evt_param_types_table : HASH_TABLE[HASH_TABLE[ETF_PARAM_TYPE, STRING], STRING]
		local
			analyze_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			simplify_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			restart_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			bool_value_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			int_value_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			addition_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			subtraction_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			multiplication_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			quotient_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			modulo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			conjunction_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			disjunction_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			implication_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			exclusive_or_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			equals_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			greater_than_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			less_than_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			union_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			intersection_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			difference_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			numerical_negation_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			logical_negation_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			sigma_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			product_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			counting_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			forall_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			exists_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			start_of_set_enumeration_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			end_of_set_enumeration_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
		do
			create Result.make (10)
			Result.compare_objects
			create analyze_param_types.make (10)
			analyze_param_types.compare_objects
			Result.extend (analyze_param_types, "analyze")
			create simplify_param_types.make (10)
			simplify_param_types.compare_objects
			Result.extend (simplify_param_types, "simplify")
			create restart_param_types.make (10)
			restart_param_types.compare_objects
			Result.extend (restart_param_types, "restart")
			create bool_value_param_types.make (10)
			bool_value_param_types.compare_objects
			bool_value_param_types.extend (create {ETF_BOOL_PARAM}, "c")
			Result.extend (bool_value_param_types, "bool_value")
			create int_value_param_types.make (10)
			int_value_param_types.compare_objects
			int_value_param_types.extend (create {ETF_INT_PARAM}, "c")
			Result.extend (int_value_param_types, "int_value")
			create addition_param_types.make (10)
			addition_param_types.compare_objects
			Result.extend (addition_param_types, "addition")
			create subtraction_param_types.make (10)
			subtraction_param_types.compare_objects
			Result.extend (subtraction_param_types, "subtraction")
			create multiplication_param_types.make (10)
			multiplication_param_types.compare_objects
			Result.extend (multiplication_param_types, "multiplication")
			create quotient_param_types.make (10)
			quotient_param_types.compare_objects
			Result.extend (quotient_param_types, "quotient")
			create modulo_param_types.make (10)
			modulo_param_types.compare_objects
			Result.extend (modulo_param_types, "modulo")
			create conjunction_param_types.make (10)
			conjunction_param_types.compare_objects
			Result.extend (conjunction_param_types, "conjunction")
			create disjunction_param_types.make (10)
			disjunction_param_types.compare_objects
			Result.extend (disjunction_param_types, "disjunction")
			create implication_param_types.make (10)
			implication_param_types.compare_objects
			Result.extend (implication_param_types, "implication")
			create exclusive_or_param_types.make (10)
			exclusive_or_param_types.compare_objects
			Result.extend (exclusive_or_param_types, "exclusive_or")
			create equals_param_types.make (10)
			equals_param_types.compare_objects
			Result.extend (equals_param_types, "equals")
			create greater_than_param_types.make (10)
			greater_than_param_types.compare_objects
			Result.extend (greater_than_param_types, "greater_than")
			create less_than_param_types.make (10)
			less_than_param_types.compare_objects
			Result.extend (less_than_param_types, "less_than")
			create union_param_types.make (10)
			union_param_types.compare_objects
			Result.extend (union_param_types, "union")
			create intersection_param_types.make (10)
			intersection_param_types.compare_objects
			Result.extend (intersection_param_types, "intersection")
			create difference_param_types.make (10)
			difference_param_types.compare_objects
			Result.extend (difference_param_types, "difference")
			create numerical_negation_param_types.make (10)
			numerical_negation_param_types.compare_objects
			Result.extend (numerical_negation_param_types, "numerical_negation")
			create logical_negation_param_types.make (10)
			logical_negation_param_types.compare_objects
			Result.extend (logical_negation_param_types, "logical_negation")
			create sigma_param_types.make (10)
			sigma_param_types.compare_objects
			Result.extend (sigma_param_types, "sigma")
			create product_param_types.make (10)
			product_param_types.compare_objects
			Result.extend (product_param_types, "product")
			create counting_param_types.make (10)
			counting_param_types.compare_objects
			Result.extend (counting_param_types, "counting")
			create forall_param_types.make (10)
			forall_param_types.compare_objects
			Result.extend (forall_param_types, "forall")
			create exists_param_types.make (10)
			exists_param_types.compare_objects
			Result.extend (exists_param_types, "exists")
			create start_of_set_enumeration_param_types.make (10)
			start_of_set_enumeration_param_types.compare_objects
			Result.extend (start_of_set_enumeration_param_types, "start_of_set_enumeration")
			create end_of_set_enumeration_param_types.make (10)
			end_of_set_enumeration_param_types.compare_objects
			Result.extend (end_of_set_enumeration_param_types, "end_of_set_enumeration")
		end
feature -- query on declarations of event parameters
	evt_param_types_list : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
		local
			analyze_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			simplify_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			restart_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			bool_value_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			int_value_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			addition_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			subtraction_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			multiplication_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			quotient_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			modulo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			conjunction_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			disjunction_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			implication_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			exclusive_or_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			equals_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			greater_than_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			less_than_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			union_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			intersection_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			difference_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			numerical_negation_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			logical_negation_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			sigma_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			product_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			counting_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			forall_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			exists_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			start_of_set_enumeration_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			end_of_set_enumeration_param_types: LINKED_LIST[ETF_PARAM_TYPE]
		do
			create Result.make (10)
			Result.compare_objects
			create analyze_param_types.make
			analyze_param_types.compare_objects
			Result.extend (analyze_param_types, "analyze")
			create simplify_param_types.make
			simplify_param_types.compare_objects
			Result.extend (simplify_param_types, "simplify")
			create restart_param_types.make
			restart_param_types.compare_objects
			Result.extend (restart_param_types, "restart")
			create bool_value_param_types.make
			bool_value_param_types.compare_objects
			bool_value_param_types.extend (create {ETF_BOOL_PARAM})
			Result.extend (bool_value_param_types, "bool_value")
			create int_value_param_types.make
			int_value_param_types.compare_objects
			int_value_param_types.extend (create {ETF_INT_PARAM})
			Result.extend (int_value_param_types, "int_value")
			create addition_param_types.make
			addition_param_types.compare_objects
			Result.extend (addition_param_types, "addition")
			create subtraction_param_types.make
			subtraction_param_types.compare_objects
			Result.extend (subtraction_param_types, "subtraction")
			create multiplication_param_types.make
			multiplication_param_types.compare_objects
			Result.extend (multiplication_param_types, "multiplication")
			create quotient_param_types.make
			quotient_param_types.compare_objects
			Result.extend (quotient_param_types, "quotient")
			create modulo_param_types.make
			modulo_param_types.compare_objects
			Result.extend (modulo_param_types, "modulo")
			create conjunction_param_types.make
			conjunction_param_types.compare_objects
			Result.extend (conjunction_param_types, "conjunction")
			create disjunction_param_types.make
			disjunction_param_types.compare_objects
			Result.extend (disjunction_param_types, "disjunction")
			create implication_param_types.make
			implication_param_types.compare_objects
			Result.extend (implication_param_types, "implication")
			create exclusive_or_param_types.make
			exclusive_or_param_types.compare_objects
			Result.extend (exclusive_or_param_types, "exclusive_or")
			create equals_param_types.make
			equals_param_types.compare_objects
			Result.extend (equals_param_types, "equals")
			create greater_than_param_types.make
			greater_than_param_types.compare_objects
			Result.extend (greater_than_param_types, "greater_than")
			create less_than_param_types.make
			less_than_param_types.compare_objects
			Result.extend (less_than_param_types, "less_than")
			create union_param_types.make
			union_param_types.compare_objects
			Result.extend (union_param_types, "union")
			create intersection_param_types.make
			intersection_param_types.compare_objects
			Result.extend (intersection_param_types, "intersection")
			create difference_param_types.make
			difference_param_types.compare_objects
			Result.extend (difference_param_types, "difference")
			create numerical_negation_param_types.make
			numerical_negation_param_types.compare_objects
			Result.extend (numerical_negation_param_types, "numerical_negation")
			create logical_negation_param_types.make
			logical_negation_param_types.compare_objects
			Result.extend (logical_negation_param_types, "logical_negation")
			create sigma_param_types.make
			sigma_param_types.compare_objects
			Result.extend (sigma_param_types, "sigma")
			create product_param_types.make
			product_param_types.compare_objects
			Result.extend (product_param_types, "product")
			create counting_param_types.make
			counting_param_types.compare_objects
			Result.extend (counting_param_types, "counting")
			create forall_param_types.make
			forall_param_types.compare_objects
			Result.extend (forall_param_types, "forall")
			create exists_param_types.make
			exists_param_types.compare_objects
			Result.extend (exists_param_types, "exists")
			create start_of_set_enumeration_param_types.make
			start_of_set_enumeration_param_types.compare_objects
			Result.extend (start_of_set_enumeration_param_types, "start_of_set_enumeration")
			create end_of_set_enumeration_param_types.make
			end_of_set_enumeration_param_types.compare_objects
			Result.extend (end_of_set_enumeration_param_types, "end_of_set_enumeration")
		end
feature -- comments for contracts
	comment(etf_s: STRING): BOOLEAN
		do
			Result := TRUE
		end
end