px4_add_module(
	MODULE examples__my_example_app_
	MAIN my_example_app
	STACK_MAIN 2000
	SRCS
		my_example_app.cpp
	DEPENDS
	)
