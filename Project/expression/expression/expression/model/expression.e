note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPRESSION

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (p : detachable EXPRESSION)
			-- Initialization for `Current'.
		local
			model_access : ETF_MODEL_ACCESS
		do
			m := model_access.m
			parent := p
			create children.make
			create type.make_from_string ("expression")
			cur := False
			done := False
		end

	m : ETF_MODEL

feature

	cur : BOOLEAN
	done : BOOLEAN
	parent : detachable EXPRESSION
	children : LINKED_LIST[EXPRESSION]
	type : STRING

	set_done
	do
		done := true
	end

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
		if not finished AND then attached parent as p then
			done := True
			p.set_next_cur
		elseif not finished AND then parent = VOID then
			m.set_done
		end
	end

	accept (v : VISITOR)
	do
		v.visit_expression (Current)
	end

	set_cur (val : BOOLEAN)
	do
		cur := val
	end

	set_child(pos : INTEGER; ex : EXPRESSION)
	do
		children.move (pos)
		children.put_left (ex)
	end

	out : STRING
	do
		create Result.make_empty
		if cur then
			Result.append ("?")
		else
			Result.append ("nil")
		end
	end

	simplify : EXPRESSION
	do
		Result := Current
	end

	check_equal(other : EXPRESSION) : BOOLEAN
	do
		Result := False
	end

	analyze : BOOLEAN
	do
		Result := false
	end

end
