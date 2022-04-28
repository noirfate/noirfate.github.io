#define _GNU_SOURCE
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <getopt.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdarg.h>
#include <errno.h>
#include <unistd.h>
#include <sys/syscall.h>

#ifndef RENAME_NOREPLACE
#define RENAME_NOREPLACE (1 << 0) /* Don't overwrite target */ // from include/uapi/linux/fs.h
#endif

#ifndef RENAME_EXCHANGE
#define RENAME_EXCHANGE (1 << 1) /* Exchange source and dest */ // from include/uapi/linux/fs.h
#endif

#ifndef SYS_renameat2
#if defined(__x86_64__)
#define SYS_renameat2 314 // from arch/x86/syscalls/syscall_64.tbl
#elif defined(__i386__)
#define SYS_renameat2 353 // from arch/x86/syscalls/syscall_32.tbl
#else
#error Architecture unsupported
#endif
#endif // ifndef SYS_renameat2

static void fatal_fprintf(FILE *out, const char * restrict fmt, ...) {
    va_list ap;

    va_start(ap, fmt);
    int ret = vfprintf(out, fmt, ap);
    int saved_errno = errno;
    va_end(ap);

    if (ret < 0) {
        errno = saved_errno;
        perror("vfprintf");
        exit(EXIT_FAILURE);
    }
}

static void print_usage(FILE *out, char *progname) {
    fatal_fprintf(out, "Usage: %s [options] SOURCE DEST\n", progname);
    fatal_fprintf(out, "Call the renameat2(2) system call.\n");
    fatal_fprintf(out, "\n");
    fatal_fprintf(out, " -h, --help      This help message\n");
    fatal_fprintf(out, " -e, --exchange  Atomically exchange SOURCE and DEST\n");
    fatal_fprintf(out, " -n, --noreplace Don't overwrite DEST if it already exists\n");
}

int main(int argc, char *argv[]) {
    int flags = 0;

    while (true) {
        static const struct option long_options[] = {
            {"exchange", no_argument, NULL, 'e'},
            {"noreplace", no_argument, NULL, 'n'},
            {"help", no_argument, NULL, 'h'},
            {NULL, 0, NULL, 0}
        };

        int c = getopt_long(argc, argv, "enh", long_options, NULL);
        if (c == -1) {
            break;
        }

        switch (c) {
            case 'n':
                flags |= RENAME_NOREPLACE;
                break;
            case 'e':
                flags |= RENAME_EXCHANGE;
                break;
            case 'h':
                print_usage(stdout, argv[0]);
                exit(EXIT_SUCCESS);
            case '?':
                print_usage(stderr, argv[0]);
                exit(EXIT_FAILURE);
            default:
                fprintf(stderr, "?? getopt returned character code 0%o ??\n", c);
                exit(EXIT_FAILURE);
        }
    }

    if (argc - optind != 2) {
        print_usage(stderr, argv[0]);
        exit(EXIT_FAILURE);
    }
    char *source = argv[optind], *dest = argv[optind + 1];

    if (syscall(SYS_renameat2, AT_FDCWD, source, AT_FDCWD, dest, flags) != 0) {
        perror("renameat2");
        exit(EXIT_FAILURE);
    }
}
