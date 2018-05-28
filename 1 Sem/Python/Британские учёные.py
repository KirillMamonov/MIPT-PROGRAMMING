from random import shuffle

text = input().split(' ')
for i in text:
    temp = list(i)
    shuffle(temp[1:-1])
print(text, sep=' ')