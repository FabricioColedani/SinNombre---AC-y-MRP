#include <stdio.h>
#include <ctype.h>

int main(void) {
char buf[128];
if (!fgets(buf, sizeof(buf), stdin)) return 1;
int sum = 0;
for (int i = 0; buf[i]; ++i) {
if (isdigit((unsigned char)buf[i]))
sum += buf[i] - '0';
}
printf("%d\n", sum);
return 0;
}