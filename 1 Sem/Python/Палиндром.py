s = list(input())
l = {}
for i in s:
    if (i in l):
        l[i] += 1
    else:
        l[i] = 1
k = 0
for j in l:
    if l[j] % 2 != 0:
        k += 1
if (len(s) % 2 == 0 and k == 0) or (len(s) % 2 != 0 and k == 1):
    print('YES')
else:
    print('NO')
