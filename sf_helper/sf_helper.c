#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <cutils/log.h>
#include <cutils/properties.h>

int get_pid_by_cmdline(const char *cl)
{
    DIR *d;
    struct dirent *de;
    char cmdline[1024];
    int fd, r;

    d = opendir("/proc");
    if(d == 0) return -1;

    while((de = readdir(d)) != 0) {
        if(isdigit(de->d_name[0])) {
            int pid = atoi(de->d_name);
            sprintf(cmdline, "/proc/%d/cmdline", pid);
            fd = open(cmdline, O_RDONLY);
        if(fd == 0) {
            r = 0;
        } else {
            r = read(fd, cmdline, 1023);
            close(fd);
            if(r < 0) r = 0;
        }
        cmdline[r] = 0;
        // printf("%d | %s\n", pid, cmdline);
        if (strcmp(cmdline, cl) == 0)
        {
            return pid;
        }
        }
    }
    closedir(d);

    return 0;
}

int main()
{
    int sf_pid;
    char value[PROPERTY_VALUE_MAX];
    char *default_value = "0";

    property_get("sys.sf.lcd_density.recommend", value, default_value);
    if (strcmp(value, default_value) == 0)
    {
        return 0;
    }

    property_set("persist.sf.lcd_density", value);

    sf_pid = get_pid_by_cmdline("/system/bin/surfaceflinger");
    kill(sf_pid, SIGTERM);

    return 0;
}
