from collections import deque

def calcula_qualidade(co, cc, coo, coc, cgo, cgob, t):

    fila = deque( [(0, 0, 0, 0, 1, 0, 0, 0, t, 0)])
    visitado = set()
    melhor_valor=0

    while fila:
        o, c, ob, g, ro, rc, rob, rg, t, mask = fila.popleft()
        melhor_valor = max(melhor_valor, g)

        if t == 0:
            continue
        if ( o, c, ob, g, ro, rc, rob, rg, t ) in visitado:
            continue
        visitado.add( (o, c, ob, g, ro, rc, rob, rg, t) )
        #print(o, c, ob, g, ro, rc, rob, rg, t, "->", melhor_valor, "->", len(visitado), len(fila))
        cmo = max(co, coo, cc, cgo)
        if o >= cgo and ob >= cgob and (mask & 8) != 8:
            fila.append( (o+ro-cgo, c+rc, ob+rob-cgob, g+rg, ro, rc, rob, rg+1, t-1, 0) )
            mask = mask | 8
        if o >= coo and c >= coc and rob <= cgob and ( mask & 4 ) != 4 and (cgob * t) > (ob + rob * t):
            fila.append( (o+ro-coo, c+rc-coc, ob+rob, g+rg, ro, rc, rob+1, rg, t-1, 0) )
            mask = mask | 4
        if o >= cc and rc <= coc and ( mask & 2 ) != 2 and (coc*t) > (c + rc * t) :
            fila.append( (o+ro-cc, c+rc, ob+rob, g+rg, ro, rc+1, rob, rg, t-1, 0) )
            mask = mask | 2
        if o >= co and ro <= cmo and (mask & 1) != 1 and (cmo*t) > (o + ro*t):
            fila.append( (o+ro-co, c+rc, ob+rob, g+rg, ro+1, rc, rob, rg, t-1, 0) )
            mask = mask | 1
        fila.append( (o+ro, c+rc, ob+rob, g+rg, ro, rc, rob, rg, t-1, mask) )

    return melhor_valor
res2 = 1
res = 0
with open("data/day_19", "r") as fl:
    for linha in fl:
        itens = linha.split()
        id = int(itens[1][:-1])
        co = int(itens[6])
        cc = int(itens[12])
        coo = int(itens[18])
        coc = int(itens[21])
        cgo = int(itens[27])
        cgob = int(itens[30])
        print(id, co, cc, coo, coc, cgo, cgob)
        res += id * calcula_qualidade(co, cc, coo, coc, cgo, cgob, 24)
        if id <= 3:
            print('**')
            res2 *= calcula_qualidade(co, cc, coo, coc, cgo, cgob, 32)
            print('***')
print(res)
print(res2)
