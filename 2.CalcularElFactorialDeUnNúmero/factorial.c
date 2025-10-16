#include <stdio.h>

int main() {
    int numero, i;
    unsigned long long factorial = 1;
    
    printf("Ingrese un numero (0-20): ");
    scanf("%d", &numero);
    
    if (numero < 0) {
        printf("Error: El factorial no está definido para números negativos.\n");
    } else {
        for (i = 1; i <= numero; i++) {
            factorial *= i;
        }
        printf("El factorial de %d es: %llu\n", numero, factorial);
    }
    
    return 0;
}
