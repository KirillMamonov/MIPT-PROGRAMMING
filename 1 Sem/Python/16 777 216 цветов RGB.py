temp = input().replace(' ', '').replace('\t', '').replace('\n', '').split('(')
data = list(temp[0])
if len(temp) > 1:
    data += list(temp[1].split(')')[0].split(','))
res = {}
if data[0] == '#':
    try:
        res['r'] = int(data[1]+data[2], 16)
        res['g'] = int(data[3]+data[4], 16)
        res['b'] = int(data[5]+data[6], 16)
    except:
        print('ERROR')
        exit()
    print(res['r'], res['g'], res['b'])
    exit()
elif data[0] == 'r' or data[0] == 'g' or data[0] == 'b':
    if '%' in data[3] or '%' in data[4] or '%' in data[5]:
        if '%' in data[3] and '%' in data[4] and '%' in data[5]:
            data[3] = data[3].replace('%', '')
            data[4] = data[4].replace('%', '')
            data[5] = data[5].replace('%', '')
            if int(data[3]) < 256 and int(data[3]) > -1 and\
                    int(data[4]) < 256 and int(data[4]) > -1 and\
                    int(data[5]) < 256 and int(data[5]) > -1:
                res[data[0]] = (int(data[3])*255)//100
                res[data[1]] = (int(data[4])*255)//100
                res[data[2]] = (int(data[5])*255)//100
                print(res['r'], res['g'], res['b'])
                exit()
            else:
                print('ERROR')
                exit()
        else:
            print('ERROR')
            exit()
    elif int(data[3]) < 256 and int(data[3]) > -1 and int(data[4]) < 256 and\
            int(data[4]) > -1 and int(data[5]) < 256 and int(data[5]) > -1:
        res[data[0]] = data[3]
        res[data[1]] = data[4]
        res[data[2]] = data[5]
        print(res['r'], res['g'], res['b'])
        exit()
    else:
        print('ERROR')
        exit()
data = temp[0].split(',')
if data[0].isdigit() and data[1].isdigit() and data[2].isdigit() and\
    int(data[0]) < 256 and int(data[0]) > -1 and int(data[1]) < 256 and\
        int(data[1]) > -1 and int(data[2]) < 256 and int(data[2]) > -1:
    res['r'] = data[0]
    res['g'] = data[1]
    res['b'] = data[2]
    print(res['r'], res['g'], res['b'])
    exit()
else:
    print('ERROR')
