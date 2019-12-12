note
	description: "Summary description for {TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRADING_TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			-- these tests moved to BASIC_TESTS
--			add_boolean_case (agent t1)
--			add_boolean_case (agent t2)
--			add_boolean_case (agent t3)

			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
			add_boolean_case (agent t11)
			add_boolean_case (agent t12)
			add_boolean_case (agent t13)

			-- violation cases should be placed last
			-- moved to BASIC_TESTS
--			add_violation_case_with_tag ("not_empty", agent t4v)
--			add_violation_case_with_tag ("last_not_empty", agent t6v)
		end

feature -- tests
--	t1: BOOLEAN
--		local
--			tom, mark, alan: NODE[STRING]
--		do
--			comment("t1: test for node structure alan -> mark -> tom")
--			create tom.make ("Tom", Void, Void)
--			create mark.make ("Mark", Void, tom)
--			create alan.make ("Alan", Void, mark)
--			tom.set_prev(mark)
--			mark.set_prev (alan)
--			-- check Alan
--			Result := alan.previous = Void
--			check Result end
--			Result := alan.next = mark
--			check Result end
--			-- check Mark
--			Result := mark.previous = alan
--			check Result end
--			Result := mark.next = tom
--			check Result end
--			-- check Tom
--			Result := tom.previous = mark
--			check Result end
--			Result := tom.next = Void
--			check Result end
--		end

--	t2: BOOLEAN
--		local
--			list1, list2: DOUBLY_LINKED_LIST[STRING]
--			expected: ARRAY[STRING]
--		do
--			comment("t2: test a doubly linked list with strings")
--			create list1.make_empty
--			Result := list1.count = 0
--			check Result end
--			list1.add_first("Tom")
--			list1.add_first ("Mark")
--			list1.add_first ("Alan")
--			expected := <<"Alan", "Mark", "Tom">>
--			create list2.make_from_array (expected)
--			Result := list1 ~ list2
--			check Result end
--			expected := <<"Alan", "Mark">>
--			create list2.make_from_array (expected)
--			Result := list1 /~ list2
--			check Result end
--		end

--	exist: STRING = "&exist;"

--	t3: BOOLEAN
--		local
--			list1, list2: DOUBLY_LINKED_LIST[INTEGER]
--			expected: ARRAY[INTEGER]
--		do
--			comment("t3: test a doubly linked list with integers 6->8->10")
--			create list1.make_empty
--			Result := list1.count = 0
--			check Result end

--			create list2.make_empty
--			assert_equal ("list1 ~ List2 when empty", list1, list2)
--			list1.add_first(10)
--			list1.add_first (8)
--			list1.add_first (6)
--			-- the assert below will fail
----			assert_equal ("list1 = List2 when empty", list1, list2)

--			expected := <<6, 8, 10>>
--			create list2.make_from_array (expected)
--			Result := list1 ~ list2
--			check Result end
--			expected := <<6>>
--			create list2.make_from_array (expected)
--			Result := list1 /~ list2
--			check Result end
--			sub_comment("check that all elements in list >= 6 and even")
--			sub_comment("use across notation")
--			Result := (across 1 |..| list1.count as i all
--				-- ∀e ∈ list1: e ≥ 6 ∧ even(e)
--				list1[i.item] >= 6
--				and (list1[i.item] \\ 2 = 0)
--			end)
--		end

	t4: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t4: remove first in Alan->Mark->Tom")
			create list1.make_empty
			list1.add_first("Tom")
			list1.add_first ("Mark")
			list1.add_first ("Alan")

			list1.remove_first
			create list2.make_from_array (<<"Mark", "Tom">>)
			Result := list1 ~ list2
			check Result end

			list1.remove_first
			create list2.make_from_array (<<"Tom">>)
			assert_equal ("list ~ {Tom}", list1, list2)

			list1.remove_first
			create list2.make_from_array (<<>>)
			assert_equal ("list ~ {}", list1, list2)

			--will violate precondition; see t4v
--			list1.remove_first
		end

	t5: BOOLEAN
		local
			list1, list2: DOUBLY_LINKED_LIST[INTEGER]
			n10, n8, n6: NODE[INTEGER]
		do
			comment("t5: remove 8, 10, 6 in 6->8->10")
			create list1.make_empty
			list1.add_first(10)
			check attached  list1.header.next as list1hn then
				n10 := list1hn
			end
			list1.add_first (8)
			check attached  list1.header.next as list1hn then
				n8 := list1hn
			end
			list1.add_first (6)
			check attached  list1.header.next as list1hn then
				n6 := list1hn
			end
			create list2.make_from_array (<<6, 8, 10>>)
			Result := list1 ~ list2
			check Result end
			-- remove 8
			list1.remove (n8)
			create list2.make_from_array (<<6, 10>>)
			assert_equal ("list1 ~ 6->10", list1, list2)
			-- remove 10
			list1.remove (n10)
--			expected := <<6>>
			create list2.make_from_array (<<6>>)
			assert_equal ("list1 ~ {6}", list1, list2)
			-- remove 10
			list1.remove (n6)
			create list2.make_empty
			assert_equal ("list1 ~ {}", list1, list2)
		end

	t6: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t6: test add last Alan->Mark->Tom")
			create list1.make_empty
			list1.add_last("Alan")
			list1.add_last ("Mark")
			list1.add_last ("Tom")

			create list2.make_from_array (<<"Alan", "Mark", "Tom">>)
			Result := list1 ~ list2
			check Result end

			list1.remove_last
			create list2.make_from_array (<<"Alan", "Mark">>)
			assert_equal ("list1 ~ Alan->Mark", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<"Alan">>)
			assert_equal ("list1 ~ {Alan}", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<>>)
			assert_equal ("list1 ~ {}", list1, list2)
		end

	t7: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[STRING]
			n: NODE[STRING]
		do
			comment("t7: test add_before")
			create list1.make_empty
			list1.add_last("Alan")
			list1.add_last ("Mark")
			n := list1.trailer.previous
			list1.add_last ("Tom")
			check attached n as na then
			list1.add_before (na, "Pam")
			end

			create list2.make_from_array (<<"Alan", "Pam", "Mark", "Tom">>)
			Result := list1 ~ list2
			check Result end

			assert_equal ("check item[2] ~ Pam", list1[2], "Pam")
			end

	t8: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[detachable STRING]
			n: NODE[detachable STRING]
		do
			comment("t8: test add_before with Void")
			create list1.make_empty
			list1.add_last("Alan")
			list1.add_last ("Mark")
			n := list1.trailer.previous
			list1.add_last ("Tom")
			check attached n as na then
			list1.add_before (na, Void)
			end

			create list2.make_from_array (<<"Alan", Void, "Mark", "Tom">>)
			Result := list1 ~ list2
			check Result end

			assert_equal ("check item[2] ~ Void", list1[2], Void)
			end

	t9: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[STRING]
			mark: NODE[STRING]
		do
			comment("t9: test add_after and attribute node")
			create list1.make_empty
			list1.add_first("Alan")
			list1.add_first ("Mark")
			mark := list1.header.next
			-- check attribute node
			Result := mark = list1.last_node
			check Result end
			list1.add_first ("Tom")
			check attached mark as a_mark then
			list1.add_after (a_mark, "Pam")
			end

			create list2.make_from_array (<<"Tom", "Mark", "Pam", "Alan">>)
			Result := list1 ~ list2
			check Result end

			assert_equal ("check item[3] ~ Pam", list1[3], "Pam")
			end

	t10: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t10: test add_at(i)")
			create list1.make_empty
--			list1.add_after(list1.header, "Mark") -- precondition violation
			list1.add_first ("Mark")
			check attached list1.last_node as node then
				list1.add_after(node, "Tom")
			end
			check attached list1.last_node as node1 then
				list1.add_after(node1, "Alan")
			end
			create list2.make_from_array (<<"Mark", "Tom", "Alan">>)
			Result := list1 ~ list2
			check Result end

			list1.add ("Pam", 1)
			create list2.make_from_array (<<"Pam", "Mark", "Tom", "Alan">>)
			assert_equal ("add Pam at 1", list1, list2)

			list1.add ("Nora", 4)
			create list2.make_from_array (<<"Pam", "Mark", "Tom", "Nora", "Alan">>)
			assert_equal ("add Nora at 4", list1, list2)

			end

	t11: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[INTEGER]
		do
			comment("t11: test add_at(i)")
			create list1.make_empty
			list1.add_first (1)
			check attached list1.last_node as node then
				list1.add_after(node, 2)
			end
			check attached list1.last_node as node then
				list1.add_after(node, 3)
			end
			create list2.make_from_array (<<1, 2, 3>>)
			Result := list1 ~ list2
			check Result end

			list1.add (4, 1)
			create list2.make_from_array (<<4, 1, 2, 3>>)
			assert_equal ("add 4 at 1", list1, list2)

			list1.add (5, 4)
			create list2.make_from_array (<<4, 1, 2, 5, 3>>)
			assert_equal ("add 5 at 4", list1, list2)

			end

	t12: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t12: test remove_at(i)")
			create list1.make_from_array (<<"Mark", "Tom", "Alan">>)
			list1[2] := "Jack"

			create list2.make_from_array (<<"Mark", "Jack", "Alan">>)
			Result := list1 ~ list2
			check Result end

			list1.remove_at (1)
			create list2.make_from_array (<<"Jack", "Alan">>)
			assert_equal ("remove problem", list1, list2)

			list1.remove_at (2)
			create list2.make_from_array (<<"Jack">>)
			assert_equal ("remove problem", list1, list2)

			list1.remove_at (1)
			create list2.make_empty
			assert_equal ("remove problem", list1, list2)

			Result := list1.is_empty

		end

	t13: BOOLEAN
		local
			list1,list2: DOUBLY_LINKED_LIST[detachable STRING]
		do
			comment("t13: test add last Alan->Mark->Void")
			create list1.make_empty
			list1.add_last("Alan")
			list1.add_last ("Mark")
			list1.add_last (Void)

			create list2.make_from_array (<<"Alan", "Mark", Void>>)
			Result := list1 ~ list2
			check Result end

			list1.remove_last
			create list2.make_from_array (<<"Alan", "Mark">>)
			assert_equal ("list1 ~ Alan->Mark", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<"Alan">>)
			assert_equal ("list1 ~ {Alan}", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<>>)
			assert_equal ("list1 ~ {}", list1, list2)
		end

feature -- violation cases
	t4v
		local
			list: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t4v: remove_first empty list precondition violation")
			create list.make_empty
			list.remove_first
		end

	t6v
		local
			list: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t6v: remove_last empty list precondition violation")
			create list.make_empty
			list.remove_last
		end
end
