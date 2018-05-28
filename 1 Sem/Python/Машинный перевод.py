from collections import defaultdict
n = int(input())
d1 = {}
for i in range(n):
    k = list(input().split(' - '))
    k[1] = (k[1].split(', '))
    d1[k[0]] = k[1]
d2 = defaultdict(list)
for j in d1.items():
    for k in j[1]:
        d2[k] += [j[0]]
vord = list(d2.items())
print(len(vord))
vord.sort(key=lambda a: a[0])
for p in vord:
    p[1].sort()
    print(p[0] + ' - ' + ', '.join(p[1]))
