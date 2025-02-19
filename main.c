#include <stdio.h>
#include <stdlib.h>

extern void printBlocks(
    int, int, int, int, int, int, int, int, int, int, 
    int, int, int, int, int, int, int, int, int, int, 
    int, int
);

int main(int argc, char *argv[]) {
    if (argc < 4 || argc > 10) {
        fprintf(stderr, "Usage: %s arg1 arg2 arg3 [arg4 ... arg9]\n", argv[0]);
        return 1;
    }

    int blksize = atoi(argv[1]);
    int blkone = atoi(argv[3]);
    int blktwo = atoi(argv[5]);
    int blktree = atoi(argv[7]);
    int blkfour = atoi(argv[9]);

    printf("the args are %d, %d, %d, %d, %d", blksize, blkone, blktwo, blktree, blkfour);

    printBlocks( //store 0+arg1, 0+arg3, 0+arg2, 0+arg3, 0+arg5, 0+arg4, 0+arg5, 0+arg7, 0+arg6, 0+arg7, 0+arg9, 0+arg8, 0+arg9
        argc > 1 ? atoi(argv[1]) : 0, //size
        argc > 1 ? atoi(argv[1]) : 0, //size
        argc > 3 ? atoi(argv[2]) : 0, //startaddress
        argc > 2 ? atoi(argv[3]) : 0, //blocksize
        argc > 2 ? atoi(argv[3]) : 0, //remaining
        0,//usedsize
        argc > 3 ? atoi(argv[2]) : 0, //endaddress
        argc > 5 ? atoi(argv[4]) : 0, //startaddress
        argc > 4 ? atoi(argv[5]) : 0, //blocksize
        argc > 4 ? atoi(argv[5]) : 0, //remaining
        0, //usedsize
        argc > 5 ? atoi(argv[4]) : 0, //endaddress
        argc > 7 ? atoi(argv[6]) : 0, //startaddress
        argc > 6 ? atoi(argv[7]) : 0, //blocksize
        argc > 6 ? atoi(argv[7]) : 0, //remaining
        0, //usedsize
        argc > 7 ? atoi(argv[6]) : 0, //endaddress
        argc > 9 ? atoi(argv[8]) : 0, //staraddress
        argc > 8 ? atoi(argv[9]) : 0, //blocksize
        argc > 8 ? atoi(argv[9]) : 0, //remaining
        0, //usedsize
        argc > 9 ? atoi(argv[8]) : 0 //endaddress
    );

    
    
    return 0;
}
