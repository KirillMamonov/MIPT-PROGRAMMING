import sys

data = sys.stdin.readlines()
for l in data:
    s = l.rstrip('\n').split('\t')
    res = s[4]
    print('{:.7s}{:.>73}'.format(s[0], res))
