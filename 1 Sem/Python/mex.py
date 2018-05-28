n=int(input())
s=input()
l=s.split(' ')
for i in range(n):
    l[i]=int(l[i])
l.sort()
k=l
l = dict(zip(l, l)).values()
l=list(l)
if k==l:
    if len(l)>=max(l):
        print(max(l)+1)
    else:
        print(len(l)+1)
else:
    for i in range(len(k)):
        try:
            if k[i] != i+1:
                if i+1<=k[i]:
                    k[i]=i+1
                else:
                    print(k,i)
                    for f in range(i+1, len(k)):
                        if k[f]==k[i]:
                            del k[f]
            else:
                 for h in range(round(len(k))):
                     for f in range(i+1, len(k)):
                        if k[f]==k[i]:
                            del k[f]
                            break
        except IndexError:
            break
    if len(k)>=max(k):
        print(max(k)+1)
    else:
        print(len(k)+1)
