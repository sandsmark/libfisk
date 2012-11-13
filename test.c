#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
	system("cp ~/.bashrc /tmp/.__bashrc");
	system("sed -e 's,\\. \\.\\.\\.,,' -i /tmp/.__bashrc");
	system("cat /tmp/.__bashrc");

	return 0;
}

