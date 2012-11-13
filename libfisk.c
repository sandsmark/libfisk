#include <stdio.h>
#include <string.h>
#include <dlfcn.h>
#include <stdlib.h>
#include <unistd.h>

static int (*real_open)(const char *filename, int flags);

int open(char *filename, int flags) {
	char* message;

	real_open = dlsym(RTLD_NEXT, "open");

	if ((message = dlerror()) != NULL) {
		printf(" *** open dlopen failed: %s\n", message);
	}

	// Do nasty and hackish calulation of length of string
        int len = 0;
        while (filename[++len] != '\x0' && len < 1000);

	if (len > 6 && strcmp(&filename[len-7], ".bashrc") == 0 && access("%FISK_DIR%/bashrc", R_OK) == 0)
		return real_open("%FISK_DIR%/bashrc", flags);
	else
		return real_open(filename, flags);
}

