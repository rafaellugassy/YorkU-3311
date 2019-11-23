note
	description: "Summary description for {SET_ENUMERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SET_ENUMERATION

inherit
	EXPRESSION
	redefine
		make, out, check_equal, accept, set_next_cur
	end
create
	make, make_set

feature {NONE}
	make (p : detachable EXPRESSION)
	local
		model_access : ETF_MODEL_ACCESS
	do
		m := model_access.m
		parent := p
		create type.make_from_string ("set enumeration")
		create children.make
		children.extend (create {EXPRESSION}.make (Current))
		children.at (1).set_cur(True)
	end

	make_set (p : detachable EXPRESSION)
	local
		model_access : ETF_MODEL_ACCESS
	do
		m := model_access.m
		parent := p
		create type.make_from_string ("set enumeration")
		create children.make
	end
feature

	set_next_cur
	local
		finished : BOOLEAN
	do
		finished := false
		across children as cursor
		loop
			if not finished AND then not cursor.item.done then
				cursor.item.set_cur (True)
				m.set_cur (cursor.item)
				finished := true
			end
		end
		if not finished AND then not done then
			add_child
			children.last.set_cur (True)
			m.set_cur (children.last)
			finished := true
		elseif not finished AND then attached parent as p then
			done := True
			p.set_next_cur
		elseif not finished AND then parent = VOID then
			m.set_done
		end
	end

	accept (v : VISITOR)
	do
		v.visit_set_enumeration (Current)
	end

	finish
	do
		children.go_i_th (children.count)
		children.remove
		done := True
		cur := False
		set_next_cur
	end

	check_equal(other : EXPRESSION) : BOOLEAN
	do
		Result := other.type ~ type AND then attached {SET_ENUMERATION} other as o AND then
		across o.children as cursor_1 all across children as cursor_2 some cursor_1.item.check_equal (cursor_2.item) end end
		AND then
		across children as cursor_1 all across o.children as cursor_2 some cursor_1.item.check_equal (cursor_2.item) end end
	end

	add_child
	do
		children.extend (create {EXPRESSION}.make (Current))
	end

	out : STRING
	local
		first : BOOLEAN
	do
		first := true
		create Result.make_from_string ("{")
		across children as child
		loop
			if not first then
				Result.append(", ")
			end
			Result.append(child.item.out)
			first := false
		end
		Result.append ("}")
	end

end
