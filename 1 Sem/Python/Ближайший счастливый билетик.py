l = list(input())
r = int(l[0])+int(l[1])+int(l[2])-int(l[3])-int(l[4])-int(l[5])
n = int(l[0]+l[1]+l[2]+l[3]+l[4]+l[5])
t1 = n + int(l[0]+l[1]+l[2]) - int(l[3]+l[4]+l[5])
i = 5
while r != 0 and i > 2:
    l[i] = int(l[i])
    a = l[i] + r
    if r < 0:
        if a < 0:
            r += int(l[i])
            l[i] = 0
        else:
            l[i] += r
            r = 0
    if r > 0:
        if a > 9:
            r -= 9-l[i]
            l[i] = 9
        else:
            l[i] += r
            r = 0
    l[i] = str(l[i])
    i -= 1
t2 = int(l[0]+l[1]+l[2]+l[3]+l[4]+l[5])
if abs(n-t1) > abs(n-t2):
    print(l[0]+l[1]+l[2]+l[3]+l[4]+l[5])
else:
    print(t1)
