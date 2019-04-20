// tags: recursivo, fatorial, iniciante.
#include <stdio.h>

int fat(int n);

int main() {
    int n;

    n = 1;

    while (scanf("%d", &n) >= 0 && n <= 12) {
        printf("%d\n", fat(n));
        break;
    }

    return 0;
}

int fat(int n) {
    if (n == 0) {
        return n + 1;

    } else {
        return n * fat(n-1);
    }
}
