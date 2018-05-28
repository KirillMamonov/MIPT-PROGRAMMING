N = int(input())
if N >= 1:
    print(1, end='')
for i in range(2, N+1):
    if i % 3 != 0 and i % 5 != 0 and i % 15 != 0:
        print(', ', i, end='')
    elif i % 15 == 0:
        print(", Fizz Buzz", end='')
    elif i % 3 == 0:
        print(", Fizz", end='')
    elif i % 5 == 0:
        print(", Buzz", end='')
