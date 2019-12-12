note
	description: "[
		Infinite stack API,
		fully contracted using Mathmodels SEQ[G]
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_STACK [G -> attached ANY]

inherit
	ANY
		redefine
			is_equal
		end

feature -- model
	model: SEQ [G]
			-- abstraction function
		deferred
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := model ~ other.model
		end

feature -- Queries
	count: INTEGER
			-- number of items in stack
		do
			Result := model.count
		ensure
			Result = model.count
		end

	top: G
			-- top of stack
		require
			not model.is_empty
		deferred
		ensure
			Result ~ model.first
			comment("model[1]")
		end

feature -- Commands
	push (x: G)
			-- push `x' on to the stack
		deferred
		ensure
			pushed_othewise_unchanged:
				model ~ ((old model.deep_twin) |<- x)
			comment("pre-pended")
		end

	pop
			-- pop top of stack
		require
			not model.is_empty
		deferred
		ensure
			model ~ old model.deep_twin.tail
		end
feature -- comment
	comment(s:STRING): BOOLEAN
		do	Result := True end
end
