def evaluate_position() -> bool:
    for x_b in blizzards_y[y_p]:
        next_blizzard = ( x_b - 1 + blizzards[f'{x_b}, {y_p}'] * ( t + 1 )  ) % ( length_x - 2 ) + 1
        if next_blizzard <= 0:
            next_blizzard = length_x + next_blizzard - 2
        if next_blizzard == x_p:
            #print(f'y-> {next_blizzard}, ({x_p}, {y_p})->({x_b}) ')
            return False
    for y_b in blizzards_x[x_p]:
        next_blizzard = ( y_b - 1 + blizzards[f'{x_p}, {y_b}'] * ( t + 1 )  ) % ( length_y - 2 ) +  1
        if next_blizzard <= 0:
            next_blizzard = length_y + next_blizzard - 2
        if next_blizzard == y_p:
            #print(f'x-> {next_blizzard}, ({x_p}, {y_p})->({y_b}) ')
            return False
    #print(x_p, y_p, True)
    return True



from collections import deque


line = input.splitlines()

length_x=len(line[0])
length_y=len(line)

limit = {}
blizzards = {}
blizzards_x = {x: [] for x in range(len(line[0])) }
blizzards_y = {y: [] for y in range(len(line)) }
finish=False

#  parsing blizzards and limmits
for y in range(len(line)):
    for x in range(len(line[y])):
        if line[y][x] == "#":
            limit[f'{x}, {y}'] = 1
        elif line[y][x] == ">":
            blizzards[f'{x}, {y}'] = 1
            blizzards_y[y].append(x)
        elif line[y][x] == "<":
            blizzards[f'{x}, {y}'] = -1
            blizzards_y[y].append(x)
        elif line[y][x] == "v":
            blizzards[f'{x}, {y}'] = 1
            blizzards_x[x].append(y)
        elif line[y][x] == "^":
            blizzards[f'{x}, {y}'] = -1
            blizzards_x[x].append(y)


y_end = len(line) - 1
x_end = len(line[y_end]) - 2

start = ( 1, 0, 0 )
end = ( x_end, y_end)

start = ( x_end, y_end, 301)
end = ( 1, 0 )

start = ( 1, 0, 570)
end = ( x_end, y_end)

queue = deque([start])
visited= set()
print(queue)

print(visited)

while True:
    x, y, t = queue.popleft()

    #print(f'x: {x}, y:{y}, t:{t}')

    possibilities = [ [x, y], [x+1, y], [x-1, y], [x, y+1], [x, y-1] ]

    for x_p, y_p in possibilities:
        if (x, y) == end:
            finish=True
            break

        if ( f'{x_p}, {y_p}' in limit or
             y_p < 0 or
             x_p < 0 or
             y_p > y_end or
             (x_p, y_p , t+1) in visited
             ):
            continue

        if evaluate_position():
            queue.append( (x_p, y_p, t+1) )
            visited.add( (x_p, y_p, t+1) )
    #print(f"queue: {queue}")
    #print(f"visited: {visited}")
    if finish == True:
        print(f'part 1 -> {t}')
        break

