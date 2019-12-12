note
	description: "[
		A  doubly linked list (DLL) is a linked data structure 
		that consists of a set of sequentially linked nodes. 
		Each node contains two attributes that are references 
		to the `previous' and to the `next' node in the sequence of nodes. 
		A node also contains some element of a given type G,
		which may be Void. 
		The beginning and ending nodes' previous and next links, 
		respectively, point to a non-Void sentinel node.
		The elements of a linked list at index i (i ∈ 1..count)
		may be accessed as list[i]. This is an O(n) operation. 
		Command `add_between' is re-used for all commands that add nodes.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLY_LINKED_LIST[G -> detachable ANY ]
inherit
	ANY
		redefine is_equal,out end
	DEBUG_OUTPUT
		redefine is_equal, out end

create
	make_empty,
	make_from_array

feature -- attributess
	count : INTEGER
		-- number of nodes in the list
	header : NODE[G]
		-- sentinel node at the head of the list
	trailer : NODE[G]
		-- sentinel node at the tail of the list

	last_node: detachable NODE[G]
		-- Last node added

feature {NONE} -- creation
	make_empty
			-- create empty list
		local
			l_g: G  -- locals may be detachable; auto-infer
		do
			-- cannot do l_g := Void because it may be an integer, etc
			create header.make(l_g, Void, Void)
			create trailer.make(l_g, Void, Void)
			header.set_next (trailer)
			trailer.set_prev (header)
		ensure
			count = 0
			comment("see invariant")
		end

	make_from_array(a: ARRAY[G])
			-- make a list from an array
		local
			i: INTEGER
		do
			make_empty
			from
				i := a.count
			until
				i < 1
			loop
				add_first (a[i])
				i := i - 1
			end
		ensure
			same_count: count = a.count
		end

feature {NONE, ES_TEST} -- implementation
	-- Private, but can test implementation,
	-- but clients should not be able to access nodes,
	-- only elements at a node.
	-- For Information Hiding.
	-- Question: so how should a client remove a node,
	-- without violating Information Hiding?

	remove (a_node: NODE[G])
			-- remove `a_node' from the list
		require
			node_exists: node_exists (a_node)
		local
			l_succ, l_pred : NODE[G]
		do
			l_succ := a_node.next
			l_pred := a_node.previous
			check attached l_succ as ls
				and attached l_pred as lp
			then
				lp.set_next (ls)
				ls.set_prev (lp)
				count:= count - 1
			end
			-- To Be Done.  Done?

		ensure
			decrement_count: count = old count - 1
			node_removed: not node_exists (a_node)
		end

feature -- queries
	valid_index (i: INTEGER_64): BOOLEAN
			-- does index `i' point to a node 1..count?
		do
			Result := 1 <= i and i <= count
		ensure
			Result = (1 <= i and i <= count)
		end

	is_equal(other: like Current): BOOLEAN
			-- Is `other' value equal to current list?
		local
			i: INTEGER_64
			node1, node2: NODE[G]
			g1, g2: G
		do
			if count = other.count then
				if count = 0 then
					Result := True
				else -- count > 0
					from
						Result := True
						i := 1
						-- see invariant
						check attached header.next as hn then
							node1 := hn
						end
						check attached other.header.next as ohn then
							node2 := ohn
						end

					until
						Result = False or i > count
					loop
						g1 := node1.element
						g2 := node2.element
						Result := g1 ~ g2
						-- i <= count means there is a next node
						check attached node1.next as n1n then
							node1 := n1n
						end
						check attached node2.next as n2n then
							node2 := n2n
						end
						i := i + 1
					end
				end

			end
		end

	node (i:INTEGER_64): NODE[G]
			-- Return the node at index `'i
		require
			valid_index(i)
		local
			j: INTEGER_64
		do
			from
				j := 1
				-- why are we sure that header.next /= Void
				check attached header.next as hn then
					Result := hn
				end
			until
				j = i
			loop
				check attached Result.next as n1n then
					Result := n1n
				end
				j := j + 1
			end
		ensure
			node_exists (Result)
		end

	item alias "[]"(i:INTEGER_64): detachable G assign replace
			-- Return element at node i
			-- where i ∈ 1..count
		require
			valid_index(i)
		do
			Result := node(i).element
		ensure
			Result = node(i).element
		end

	is_empty: BOOLEAN
			-- Is list empty?
		do
			Result := count = 0
		ensure
			Result = (count = 0)
		end

	node_exists (a_node: NODE[G]): BOOLEAN
			-- Is `a_node' a node in the list?
		local
			n: NODE[G]
		do
			from
				n := header.next
			until
				Result or n = trailer
			loop
				if n = a_node  then
					Result := True
				end
				check attached n as na then
					n := na.next
				end
			end
		end

feature -- commands

	replace (e: detachable G; i: INTEGER_64)
			-- replace element at index `i' with `e'
		require
			valid_index (i)
		do
			node(i).set_element (e)
		ensure
			no_new_elements: count = old count
			element_replaced: item(i) = e

		end

	add_between(e: detachable G;  pred: NODE[G]; succ: NODE[G])
			-- add a new node with element `e' between
			-- a predecessor `pred' and succesor `succ',
			-- which may be sentinels
		require
			predecessor_exists: pred = header or else node_exists (pred)
			successor_exists: succ = trailer or else node_exists (succ)
			adjacent: pred.next = succ
		local
			l_new_node: NODE[G]  -- new node
		do
			create l_new_node.make (e, pred, succ)
			pred.set_next (l_new_node)
			succ.set_prev (l_new_node)
			count := count + 1
			last_node := l_new_node
		ensure
			add_new_node_ab: count = old count + 1
			in_between: pred.next /= succ
			attached_new_node: attached last_node as new_node
			correct_previous_ab: new_node.previous = pred
			correct_element_ab: new_node.element = e
			correct_next_ab: new_node.next = succ
		end

	add_first(e: detachable G)
			-- add new node with element `e' at the head of the list
		do
			check attached header.next as hn then
				add_between (e, header, hn)
			end
		ensure
			increment_count_af: count = old count + 1
			is_attached: attached header.next as first
			correct_element_added_af: first.element = e
		end



	remove_first
			-- remove first node at index 1
		require
			not_empty: not is_empty
		do
			remove_at(1)
			-- To Be Done. Done?
		ensure
			count_decremented_rf: count = old count - 1
			first_removed: not node_exists ((old node(1)))
		end


	add_last(e: detachable G)
			-- add node with element `e' at the end of the list
		do
			-- see invariant
			check attached trailer.previous as tp then
				add_between (e, tp, trailer)
			end
		ensure
			increment_count_af: count = old count + 1
			is_attached: attached trailer.previous as last
			correct_element_added_af: last.element = e
			-- To Be Done Done?
		end

	remove_last
			-- remove last node
		require
			last_not_empty: not is_empty
		do
			-- see invariant
			check attached trailer.previous as tp then
				remove(tp)
			end
		ensure
			count_decremented_rf: count = old count - 1
			last_removed: not node_exists ((old node(count)))
			-- To Be Done
		end

	add_before(n: NODE[G]; e: detachable G)
			-- add element `e' in a new node before node `n'
		require
			node_exists: node_exists (n)
		do
			check attached n.previous as l_prev
			then
			add_between(e, l_prev, n)
			end
			-- To Be Done. Done?
			-- use add_between
		ensure
			increment_count_ab: count = old count + 1
			is_attached: attached n.previous as n_prev
			element_added_ab: n_prev.element = e
		end

	add_after(n: NODE[G]; e: detachable G)
			-- add element `e' in a new node after node `n'
		require
			node_exists (n)
		--local
			--l_next: NODE[G]
		do
			-- l_next:= n.next
			check attached n.next as l_next
			then
				add_between(e, n, l_next)
			end
			-- To Be Done. Done?
			-- use add_between
		ensure
			increment_count_aa: count = old count + 1
			is_attached: attached n.next as n_next
			element_added_aa: n_next.element = e
		end

	add (e: detachable G; i: INTEGER_64)
			-- add element `e' in a new node at index `'i
		require
			valid_index (i)
		local
			l_pred: NODE[G]
			l_succ: NODE[G]
		do
			l_pred := node(i).previous
			l_succ := node(i)
			check attached l_succ as ls
				and attached l_pred as lp
			then
			add_between(e, lp, ls)
			end
			-- To Be Done. Done?
			-- use add_between
		ensure
			increment_count: count = old count + 1
			element_added_at_i: node(i).element = e
		end



	remove_at (i: INTEGER)
			-- remove node at index `i'
		require
			valid_index_ra: valid_index (i)
		local
			l_pred: NODE[G]
			l_succ: NODE[G]
		do
			l_pred := node(i).previous
			l_succ := node(i).next
			-- ok due to precondition
			check attached l_succ as ls
				and attached l_pred as lp
			then
				lp.set_next (ls)
				ls.set_prev(lp)
			end
			count := count - 1
		ensure
			count_decremented_rf: count = old count - 1
			first_removed: not node_exists ((old node(i)))
			-- To be Done
		end



feature -- out

	debug_output: STRING
			-- string representation for debug
		do
			Result := out
		end

	out: STRING
			-- string representation of this list
		do
			Result := "{"
			across 1  |..| count as i loop
				if  attached {G} node(i.item).element as e
				then
					Result := Result + e.out +","
				else
					Result := Result + "Void,"
				end
			end
			-- remove last comma
			if count >= 1 then
				Result.remove_tail (1)
			end
			Result := Result + "}"
		end

	comment(s: IMMUTABLE_STRING_32): BOOLEAN
		do Result := True end

invariant
	count_is_non_negative:
		count >= 0
	header_next_is_attached:
		attached header.next
	trailer_previous_is_attached:
		attached trailer.previous
	comment("in an empty list, the sentinels poin t to each other")
	consistent_empty_list:
		(count = 0) = (header.next = trailer and trailer.previous = header)

end
