/* fib_colab.c */
#include <stdio.h>
#include <stdint.h>

int main() {
    int n;
    if (printf("Ingrese n: ") && scanf("%d", &n) == 1) {
        if (n < 0) {
            printf("n debe ser >= 0\n");
            return 1;
        }
        if (n == 0) { printf("F(0) = 0\n"); return 0; }
        if (n == 1) { printf("F(1) = 1\n"); return 0; }

        uint64_t a = 0, b = 1, c;
        for (int i = 2; i <= n; ++i) {
            c = a + b;
            a = b;
            b = c;
        }
        printf("F(%d) = %llu\n", n, (unsigned long long)b);
    }
    return 0;
}
