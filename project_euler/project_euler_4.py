def pal(a):
    a = str(a)
    if a == a[::-1]:
        a = int(a)
        return a

m = 0
for i in range(100, 1000):
    for o in range(100, 1000):
        if pal(i * o) == i * o and m < i * o:
            m = i * o
print(m)
