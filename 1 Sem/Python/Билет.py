n = int(input())
i = 0
while 0 == 0:
    l = list(str(n+i))
    if int(l[0])+int(l[1])+int(l[2])-int(l[3])-int(l[4])-int(l[5]) == 0:
        n += i
        break
    l = list(str(n-i))
    if int(l[0])+int(l[1])+int(l[2])-int(l[3])-int(l[4])-int(l[5]) == 0:
        n -= i
        break
    i += 1
print(n)
