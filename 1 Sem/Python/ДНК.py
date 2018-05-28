d = {'A': 'T', 'G': 'C', 'C': 'G', 'T': 'A'}
s = list(input())
r = ''
for i in s:
    r = d[i] + r
print(r)
