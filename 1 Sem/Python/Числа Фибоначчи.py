def Fibon(n):
    if n <= 0:
        return 0
    a = 0
    b = 1
    c = 0
    for i in range(n-1):
        c = a + b
        a, b = b, c
    return c

n = int(input())
print(Fibon(n))
