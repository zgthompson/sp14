import sys
import string
import operator

def kasisky(ciphertext):
    found = {}
    for repeat_size in (2, 3, 4, 5):
        for repeat_start in range(len(ciphertext) - repeat_size + 1):
            repeat = ciphertext[repeat_start: repeat_start + repeat_size]
            loc = string.find(ciphertext, repeat, repeat_start + repeat_size)
            if loc is not -1:
                if repeat in found:
                    found[repeat].append(loc - repeat_start)
                else:
                    found[repeat] = [ loc - repeat_start ]

    return found



def factors(n):
    all_factors = set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))
    all_factors.discard(1)
    return all_factors


repeats = kasisky(sys.argv[1])

repeat_factors = {}

for repeat in repeats.itervalues():
    for num in repeat:
        for factor in factors(num):
            if factor in repeat_factors:
                repeat_factors[factor] += 1
            else:
                repeat_factors[factor] = 1

sorted_factors = sorted(repeat_factors.iteritems(), key=operator.itemgetter(1), reverse=True)

for key, value in sorted_factors:
    print str(key) + ": " + str(value)
