note
	description: "Calendar application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT

inherit
	ARGUMENTS
	ES_SUITE

create
	make

feature {NONE} -- Initialization

	make
			-- Run tests
		do
			add_test (create {BASIC_TESTS}.make)
			add_test (create {STUDENT_TESTS}.make)
			add_test (create {GRADING_TESTS}.make)

			show_browser
			run_espec
		end

end
