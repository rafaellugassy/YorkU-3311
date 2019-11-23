note
	description: "Summary description for {START_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	START_GAME

inherit
	COMMAND

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			model_access : ETF_MODEL_ACCESS
		do
			model := model_access.m
		end

	model : ETF_MODEL

feature
	redo
		do
			model.set_val_start (True)
		end

	undo
		do
			model.set_val_start (False)
		end

end
