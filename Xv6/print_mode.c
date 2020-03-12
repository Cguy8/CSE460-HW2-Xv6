

int
print_mode(struct stat st)
{
	if (st.type == 1)
		printf(1, "d");
	if (st.type == 2)
		printf(1, "-");
	if (st.type == 3)
		printf(1, "c");

	if (st.mode.flags.u_r == 1)
		printf(1, "r");
	else
		printf(1, "-");
	if (st.mode.flags.u_w == 1)
		printf(1, "w");
	else
		printf(1, "-");
	if (st.mode.flags.u_x == 1)
		printf(1, "x");
	else
		printf(1, "-");

	if (st.mode.flags.g_r == 1)
		printf(1, "r");
	else
		printf(1, "-");
	if (st.mode.flags.g_w == 1)
		printf(1, "w");
	else
		printf(1, "-");
	if (st.mode.flags.g_x == 1)
		printf(1, "x");
	else
		printf(1, "-");

	if (st.mode.flags.o_r == 1)
		printf(1, "r");
	else
		printf(1, "-");
	if (st.mode.flags.o_w == 1)
		printf(1, "w");
	else
		printf(1, "-");
	if (st.mode.flags.o_x == 1)
		printf(1, "x");
	else
		printf(1, "-");


	return 0;
}
