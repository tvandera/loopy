realign(InitR, UpdateR, 1)
realign(UpdateR, UpdateA, 1)
affine(InitR, {[i, j, k] -> [i, k, j]})
affine(UpdateR, {[i, j, k] -> [i, k, j]})
affine(UpdateA, {[i, j, k] -> [i, k, j]})
//L = lift(Left, 3)
//affine(L, { [i, j, k] -> [i1, j1, k1, i2, j2, k2]: i1 = [i/128] and i2 = i%128 and j1 = [j/128] and j2 = j%128 and k1 = [k/128] and k2 = k%128} )