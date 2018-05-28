n = int(input())
c = 0
for i in range(n // 10 + 1):
    for j in range(n // 5 + 1):
        if n-10*i-5*j >= 0:
            c += 1
print(c)
