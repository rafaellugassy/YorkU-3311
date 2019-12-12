note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create message.make_from_string("ok")
			create s.make_empty
			i := 0
		end

feature -- model attributes
	s : STRING
	i : INTEGER
	message : STRING
	game : detachable GAME

feature -- model operations

	make_game (player1 : STRING ; player2 : STRING)
	do
		if player1.at (1).is_alpha and player2.at (1).is_alpha and player1 /~ player2 then
			create game.make (player1, player2, 0, 0)
			message := "ok"
		elseif player1 ~ player2 then
			message := "names of players must be different"
		else
			message := "name must start with A-Z or a-z"
		end
	end

	place (player : STRING ; location : INTEGER)
	do
		if attached game as g then
			if g.game_over then
				message := "game is finished"
			else
				message := g.place (player, location)
			end
		else
			message := "no such player"
		end
	end

	play_again
	local
		player1, player2 : STRING
		score1, score2 : INTEGER
	do
		create player1.make_empty
		create player2.make_empty
		if attached game as g then
			if g.game_over then
				create player1.make_from_string (g.player1)
				create player2.make_from_string (g.player2)
				score1 := g.score1
				score2 := g.score2
				create game.make (player1, player2, score1, score2)
				message := "ok"
			else
				message := "finish this game first"
			end
		end
	end

	redo
	do
		if attached game as g then
			if g.game_over then
					message := "game is finished"
			else
				g.redo
				message := "ok"
			end
		end
	end

	undo
	do
		if attached game as g then
			if g.game_over then
				message := "game is finished"
			else
				g.undo
				message := "ok"
			end
		else
			message := "ok"
		end
	end

	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  " + message)
			if attached game as g then
				if not g.game_over then
					Result.append ( ": => " + g.turn_player + " plays next%N")
				else
					Result.append (": => play again or start new game%N")
				end
				Result.append (g.board_out + "%N  " + g.score1.out + ": score for %"" + g.player1 + "%" (as X)%N  ")
				Result.append (g.score2.out + ": score for %"" + g.player2 + "%" (as O)")
			else
				Result.append (":  => start new game%N  ___%N  ___%N  ___%N  0: score for %"%" (as X)%N  0: score for %"%" (as O)")
			end
		end

end




