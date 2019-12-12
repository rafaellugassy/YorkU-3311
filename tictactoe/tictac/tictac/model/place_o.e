note
	description: "Summary description for {PLACE_O}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLACE_O

inherit
	MOVE

create
	make

feature {PLACE_O, NONE}

	loc : INTEGER

	game : GAME

feature {GAME, NONE} -- commands

	execute -- place a peice at the location
	do
		game.place_o (loc)
	end

	redo -- remove piece from location
	do
		game.remove_piece (loc)
	end

feature {GAME, NONE} -- Initialization

	make (location : INTEGER; current_game : GAME)
			-- Initialization for `Current'.
		do
			game := current_game
			loc := location
		end

end
