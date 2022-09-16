/* i don't now how to add string to heynow.s until I create this file and run: */
/*     gcc -S heynow.c -o heynow.s */

#include <stdlib.h>
#include <stdio.h>

int main(){
    FILE * fd = fopen("heynow.txt", "w");
    fprintf(fd,"Hey diddle diddle!");
    fclose(fd);
    return 0;
}

