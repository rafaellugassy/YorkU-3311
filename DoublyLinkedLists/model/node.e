note
	description: "[
		A node for a doubly-linked list stores:
			-- a reference to an element of a sequence; might be Void
			-- a reference to the next node; might be Void
			-- a reference to the previous node; might be Voids
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NODE[G -> detachable ANY]
create
	make

feature
	element : detachable G
	previous:  detachable NODE[G]
	next: detachable NODE[G]

feature {NONE} -- Constructor
	make(e: detachable G; p: detachable NODE[G]; n: detachable NODE[G])
			-- make a node with previous node `p' and next node `n'
		do
			element := e
			previous := p
			next := n
		ensure
			items_set: element = e and previous = p and next = n
		end

feature {DOUBLY_LINKED_LIST, ES_TEST}
	set_element(e: detachable G)
		do
			element := e
		ensure
			comment("Only 'element' changes; see also invariant")
			element_changed:
				element = e
			previous_unchanged1:
				attached (old previous) as old_previous implies
				attached previous as new_previous
				and then old_previous.element = new_previous.element
			previous_unchanged2:
				not attached (old previous)implies previous = Void
			next_unchanged1:
				attached (old next) as old_next implies
				attached next as new_next
				and then old_next.element = new_next.element
			next_unchanged2:
				not attached (old next)implies next = Void
		end

	set_prev(p: NODE[G])
		require
			ok_p: p /= Void implies p /= next
		do
			previous := p
		ensure
			previous_set: previous = p
		end

	set_next(n: NODE[G])
		require
			ok_n: n /= Void implies n /= previous
		do
			next := n
		ensure
			next_set: n = next
		end

	comment(s:STRING): BOOLEAN
		do Result := True end
invariant
	if_empty: previous = next implies previous = Void and next = Void
end


