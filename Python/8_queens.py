def out():
    print('')
    for i in range(9):
        s = ''
        for j in range(9):
            s += m[i][j] + " "
        print(s)

def draw():
    while 1:        
        c = str(input())
        x = ord(c[0]) - 96
        y = 8 - int(c[1])
        if(m[y][x] != '#'):
            print('Incorrect input')
        else:
            break

    for i in range(8):
        m[i][x] = "'"
        m[y][i + 1] = "'"
    
    c = 0
    while 1:
        c += 1
        a = 0
        if(y - c > -1 and x - c > 0):
            m[y - c][x - c] = "'"
            a = 1        
        if(y + c < 8 and x + c < 9):
            m[y + c][x + c] = "'" 
            a = 1
        if(y + c < 8 and x - c > 0):
            m[y + c][x - c] = "'"
            a = 1
        if(y - c > -1 and x + c < 9):
            m[y - c][x + c] = "'" 
            a = 1

        if(a == 0):
            break

    m[y][x] = '!'

def check():
    l = 0
    for i in range(8):
        l += m[i].count('#')
    return l
                   
m = []
g = 0

while g == 0:
    for i in range(8):
        m.append([])
        m[i].append(str(8 - i))
        for j in range(8):
            m[i].append('#')
    m.append([' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'])
    out()
    print('Queens:', 8)

    for i in range(8):
        draw()
        out()
        print('Queens:', 7 - i)
        if(7 - i > check()):
            print('Lose')
            break
        if(7 - i == 0):
            print('Win')
            g = 1