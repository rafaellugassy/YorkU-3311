note
	description: "Summary description for {RESTART_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESTART_GAME

inherit
	COMMAND

create
	make

feature {NONE} -- Initialization

	make (b : ARRAY2[INTEGER] ; s : BOOLEAN)
			-- Initialization for `Current'.
		local
			model_access : ETF_MODEL_ACCESS
		do
			model := model_access.m
			board := b.deep_twin
			start := s.deep_twin
		end

	model : ETF_MODEL
	board : ARRAY2[INTEGER]
	start : BOOLEAN

feature
	redo
	do
		model.do_restart
	end

	undo
	do
		model.undo_restart (board, start)
	end

end
