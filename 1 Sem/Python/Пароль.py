s = input()
d = s.lower()
k = list(s)
z = 0
l = 0
u = 0
a = 0
n = 0
for i in k:
    z += i.isdigit()
    l += i.islower()
    u += i.isupper()
for j in list(d):
    a += (j == 'a')
    n += (j == 'n')
if (a >= 2 and n >= 2) or len(d) < 8 or len(set(d)) < 4:
    print('weak')
elif z != 0 and l != 0 and u != 0:
    print('strong')
else:
    print('weak')
