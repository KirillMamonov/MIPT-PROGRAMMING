s = list(map(int, input().split()))
p = set(map(int, input().split()))
m = set(map(int, input().split()))
res = 0
for i in s:
    if i in p:
        res += 1
    if i in m:
        res -= 1
print(res)
