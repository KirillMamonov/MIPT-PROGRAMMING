sum = 0
t = [0]
m = [0]
s = input()
for i in range(len(s)):
    if i + 1 < len(s) and s[i] == s[i + 1]:
        for j in range(min(i + 1, len(s) - (i + 1))):
            if s[i + j + 1] == s[i - j]:
                sum += 1
            else:
                sum = 0
                break
        if sum != 0:
            t += [sum]
            sum = 0
    else:
        sum = 0
        if len(s) > i + 1 and i > 0 and s[i + 1] == s[i - 1]:
            for j in range(min(i, len(s) - (i + 1))):
                if s[i - (j + 1)] == s[i + (j + 1)]:
                    sum += 1
                else:
                    sum = 0
                    break
            if sum != 0:
                m += [sum + 1]
                sum = 0
if max(max(m) * 2 - 1, max(t) * 2) != 0:
    print(len(s) - max(max(m) * 2 - 1, max(t) * 2))
else:
    print(len(s) - 1)
