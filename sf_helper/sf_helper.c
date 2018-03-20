#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <cutils/log.h>
#include <cutils/properties.h>

int main()
{
    char value[PROPERTY_VALUE_MAX];
    char *default_value = "0";
    char *args[6];
    int pid;
    int rc = 0;

    property_get("sys.sf.lcd_density.recommend", value, default_value);
    if (strcmp(value, default_value) == 0)
    {
        return 0;
    }

    property_set("persist.sf.lcd_density", value);

    setenv("CLASSPATH", "/system/framework/wm.jar", 0);

    args[0] = "/system/bin/app_process";
    args[1] = "/system/bin";
    args[2] = "com.android.commands.wm.Wm";
    args[3] = "density";
    args[4] = value;
    args[5] = (char*)0;

    pid = fork();
    if (pid < 0) {
       return pid;
    }
    if (!pid) {
        execv("/system/bin/app_process", args);
        exit(1);
    }
    for(;;) {
        pid_t p = waitpid(pid, &rc, 0);
        if (p != pid) {
            rc = -1;
            return rc;
        }
        if (WIFEXITED(rc)) {
            rc = WEXITSTATUS(rc);
            if (rc) {
                rc = -1;
            }
            return rc;
        }
    }

    return 0;
}
