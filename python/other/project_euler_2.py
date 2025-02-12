a = 1
b = 2
s = 2
while b <= 4000000:
    b += a
    a = b - a
    if b % 2 == 0:
        s += b
print(s)
