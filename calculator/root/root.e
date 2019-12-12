note
	description : "gelex-calculator application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ROOT

inherit
	ES_SUITE

create
	make

feature {NONE} -- Initialization
	is_print: BOOLEAN = False
		-- when submitting leave this as false

	make
		local
			line: STRING
			eval: EVALUATOR
		do
			if not is_print then -- unit testing
				add_test (create {STUDENT_TEST}.make("array"))
				add_test (create {TEST_STACK_ARRAY}.make("array"))
				add_test (create {TEST_STACK_LIST}.make("list"))
				add_test (create {TEST_STACK_ARRAY_EVAL}.make("array"))
				add_test (create {TEST_STACK_LIST_EVAL}.make("list"))
				show_browser
				run_espec
			else -- evaluate from terminal
				create eval.make("array")
				print("Enter expression:%N")
				io.read_line
				line := io.last_string.twin -- STRING is reference
				if eval.is_valid (line) then
					eval.evaluate (line)
					print(eval.value.out)
					io.new_line
				else
					print("Expression not valid%N")
				end
			end
		end

end
