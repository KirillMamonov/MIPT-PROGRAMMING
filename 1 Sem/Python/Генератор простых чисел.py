n = int(input())
l = n * 10
a = [True] * l
for i in range(2, l):
    for j in range(i * 2, l, i):
        a[j] = False
b = [i for i in range(2, l) if a[i]]
print(b[n-1])
