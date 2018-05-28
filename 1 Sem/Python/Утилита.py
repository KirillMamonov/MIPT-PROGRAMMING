import sys

data = sys.stdin.readlines()
k = data[0]
data = data[1:]
l_ = len(data)
w = sum(map(lambda x: len(x.split()), data))
m = sum(map(len, data))
L = max(map(len, data)) - 1
if 'l' in k:
    print(l_, end=' ')
if 'w' in k:
    print(w, end=' ')
if 'm' in k:
    print(m, end=' ')
if 'L' in k:
    print(L, end='')
