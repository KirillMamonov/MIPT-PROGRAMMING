s= input()
for i in range(len(s)):
    s=s.replace('WUB',' ')
l=s.split()
s=' '.join(l)
print(s)
