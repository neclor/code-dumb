using static System.Console;

int sum(int a)
{
    int s;
    if (a % 2 == 0) {
        s = (1 + a) * a / 2;
    }
    else {
        s = a * (a - 1) / 2 + a;
    }

    return s;
}

int sqrtsum(int a)
{
    return a * (a + 1) * (2 * a + 1) / 6;
}

Write("Введите число: ");
var a = int.Parse(ReadLine());

WriteLine(sum(a) * sum(a) - sqrtsum(a));
