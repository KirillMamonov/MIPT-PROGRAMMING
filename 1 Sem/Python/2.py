a=0
s=input()
for i in range(len(s)):
    m=list(s)
    m.insert(0, m[len(m)-1])
    del m[len(m)-1]
    s=''.join(m)
    j=s
    for p in range(len(s)//2):
        if '()' in s:
            s=s.replace('()','')
        elif '[]' in s:
            s=s.replace('[]','')
        elif '{}' in s:
            s=s.replace('{}','')
    if s=='':
        a=a+1
    s=j
print(a)
