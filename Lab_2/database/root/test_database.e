note
	description: "Test the DATABASE ADT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DATABASE

inherit
	ES_SUITE

create
	make

feature -- Add test classes
	make
		do
			add_test (create {EXAMPLE_DATABASE_TESTS}.make)
			 show_browser
			run_espec
		end
end
