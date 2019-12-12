note
	description: "Summary description for {CHECK_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_TESTS
inherit
	ES_TEST
		redefine setup end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)

			-- violation cases should be placed last
			add_violation_case_with_tag ("not_empty", agent t4v)
			add_violation_case_with_tag ("last_not_empty", agent t6v)
		end


feature -- setup
new_line: STRING = "<br>"

	list: DOUBLY_LINKED_LIST[STRING]
		attribute
			create Result.make_empty
		end

	setup
			-- always runs first
			-- creates Alan -> Mark -> Tom
		do
			create list.make_empty
			list.add_first("Tom")
			list.add_first ("Mark")
			list.add_first ("Alan")
		end

feature -- test add_first, item


	t0: BOOLEAN
			-- this test use `list' from `setup'
		local
			list2: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t0: test a doubly linked list with strings")
			sub_comment(new_line + "test make_empty, add_first, item, node and replace ")
			create list.make_empty
			Result := list.count = 0
				and list.header.previous = Void
				and list.trailer.next = Void
			check Result end
			list.add_first("Tom")
			list.add_first ("Mark")
			list.add_first ("Alan")
			create list2.make_from_array (<<"Alan", "Mark", "Tom">>)
			assert_equal ("test DLL", list, list2)
			Result := list[1] ~ "Alan" and list[2] ~ "Mark" and list[3] ~ "Tom"
			check Result end
			assert_equal ("count correct", list.count, 3)
			check attached list.last_node as last_node then
				assert_equal ("last node correct", last_node.element, "Alan")
			end
		end

feature -- test NODE, make_from_array
-- these tests do not use `list' from setup
-- but in principal, they could

	t1: BOOLEAN
		local
			tom, mark, alan: NODE[STRING]
		do
			comment("t1: test for node structure alan -> mark -> tom")
			create tom.make ("Tom", Void, Void)
			create mark.make ("Mark", Void, tom)
			create alan.make ("Alan", Void, mark)
			tom.set_prev(mark)
			mark.set_prev (alan)
			-- check Alan
			Result := alan.previous = Void
			check Result end
			Result := alan.next = mark
			check Result end
			-- check Mark
			Result := mark.previous = alan
			check Result end
			Result := mark.next = tom
			check Result end
			-- check Tom
			Result := tom.previous = mark
			check Result end
			Result := tom.next = Void
			check Result end
		end

	t2: BOOLEAN
		local
			list1, list2: DOUBLY_LINKED_LIST[STRING]
			expected: ARRAY[STRING]
		do
			comment("t2: test a doubly linked list with strings")
			create list1.make_empty
			Result := list1.count = 0
			check Result end
			list1.add_first("Tom")
			list1.add_first ("Mark")
			list1.add_first ("Alan")
			expected := <<"Alan", "Mark", "Tom">>
			create list2.make_from_array (expected)
			Result := list1 ~ list2
			check Result end
			expected := <<"Alan", "Mark">>
			create list2.make_from_array (expected)
			Result := list1 /~ list2
			check Result end
		end


	t3: BOOLEAN
		local
			list1, list2: DOUBLY_LINKED_LIST[INTEGER]
			expected: ARRAY[INTEGER]
		do
			comment("t3: test a doubly linked list with integers 6->8->10")
			create list1.make_empty
			Result := list1.count = 0
			check Result end

			create list2.make_empty
			assert_equal ("list1 ~ List2 when empty", list1, list2)
			list1.add_first(10)
			list1.add_first (8)
			list1.add_first (6)
			-- the assert below will fail
--			assert_equal ("list1 = List2 when empty", list1, list2)

			expected := <<6, 8, 10>>
			create list2.make_from_array (expected)
			Result := list1 ~ list2
			check Result end
			expected := <<6>>
			create list2.make_from_array (expected)
			Result := list1 /~ list2
			check Result end
			sub_comment("check that all elements in list >= 6 and even")
			sub_comment("use across notation")
			Result := (across 1 |..| list1.count as i all
				-- ∀e ∈ list1: e ≥ 6 ∧ even(e)
				list1[i.item] >= 6
				and (list1[i.item] \\ 2 = 0)
			end)
		end

feature -- test `replace'
	t4: BOOLEAN
			-- use list from setup
		do
			comment("t4: test replace at index 3 with Dan.")
			sub_comment ("list <Alan, Mark, Tom> ==> <Alan, Mark, Dan>.")
			sub_comment ("replace is also used by item.")
			Result := list[3] ~ "Tom"
			check Result end
			list.replace("Dan", 3)
			assert_equal ("replace failed", list[3], "Dan")
		end

feature -- test add_between
	t5: BOOLEAN
			-- use list from setup
		local
			list2: like list
		do
			comment("t5: test add_between two nodes with Alan and Mark.")
			sub_comment (new_line + "list <Alan, Mark, Tom> ==> <Alan, Jan, Mark, Dan>")
			list.add_between ("Jan", list.node (1), list.node(2))
			create list2.make_from_array (<<"Alan", "Jan", "Mark", "Tom">>)
			Result := list ~ list2
			check Result end

		end

feature -- violation cases
	t4v
		local
			list1: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t4v: remove_first empty list precondition violation")
			create list1.make_empty
			list1.remove_first
		end

	t6v
		local
			list1: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t6v: remove_last empty list precondition violation")
			create list1.make_empty
			list1.remove_last
		end
end
