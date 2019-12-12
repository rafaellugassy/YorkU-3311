note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
		end

feature
	t1: BOOLEAN
		local
			list1, list2 : DOUBLY_LINKED_LIST[STRING]
		do
			comment("t1: tests add World between Hello->!")
			create list1.make_empty
			list1.add_last ("Hello")
			list1.add_last ("!")
			list1.add_between ("World", list1.node(1), list1.node (2))
			create list2.make_from_array(<<"Hello", "World", "!">>)
			Result := list1 ~ list2
			check Result end
		end

	t2: BOOLEAN
		local
			list1, list2 : DOUBLY_LINKED_LIST[detachable STRING]
		do
			comment("t2: tests add first with Void Mark->John")
			create list1.make_empty
			list1.add_last ("Mark")
			list1.add_last ("John")
			list1.add_first (Void)
			create list2.make_from_array (<<Void, "Mark", "John">>)
			Result := list1 ~ list2
			check Result end
		end
	t3: BOOLEAN
		local
			list1, list2 : DOUBLY_LINKED_LIST[INTEGER]
		do
			comment ("t3: tests add after with 2 on the first node of 1->3")
			create list1.make_empty
			list1.add_last (1)
			list1.add_last (3)
			list1.add_after (list1.node(1), 2)
			create list2.make_from_array (<<1, 2, 3>>)
			Result := list1 ~ list2
			check Result end
		end
	t4: BOOLEAN
		local
			list1, list2 : DOUBLY_LINKED_LIST[detachable STRING]
		do
			comment ("t4: add before John Joe->Bob")
			create list1.make_empty
			list1.add_last ("Joe")
			list1.add_last ("Bob")
			list1.add_before (list1.node (2), "John")
			create list2.make_from_array(<<"Joe", "John", "Bob">>)
			Result := list1 ~ list2
			check Result end
		end
	t5: BOOLEAN
		local
			list1, list2 : DOUBLY_LINKED_LIST[DOUBLY_LINKED_LIST[INTEGER]]
			inner1, inner2, inner3 : DOUBLY_LINKED_LIST[INTEGER]
		do
			comment ("t5: testing add and remove on a doubly linked list containing doubly linked lists")
			create inner1.make_from_array (<<3,2,1>>)
			create inner2.make_from_array (<<22,11,123>>)
			create inner3.make_from_array (<<>>)
			create list1.make_empty
			list1.add_last (inner1)
			list1.add_last (inner2)
			list1.add_last (inner3)
			list1.remove_at (2)
			create list2.make_from_array (<<inner1, inner3>>)
			Result := list1 ~ list2
			check Result end
		end
end
