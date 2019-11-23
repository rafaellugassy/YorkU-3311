note
	description: "Summary description for {RECORD}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	RECORD [V1, V2, K]
inherit
	ANY
	redefine
		is_equal
	end

create
	make

feature -- Attributes (Do not modify this section)
	value_1: V1
	value_2: V2
	key: K

feature -- Commands (Do not modify this section)
	make (v1: V1; v2: V2; k: K)
		do
			value_1 := v1
			value_2 := v2
			key := k
		end

feature -- Equality
	is_equal (other: like Current): BOOLEAN
		do
			-- Your Task
			Result := Current.value_1 ~ other.value_1 AND Current.value_2 ~ other.value_2 AND Current.key ~ other.key
		ensure then
			-- No postcondition needed.
		end

end
