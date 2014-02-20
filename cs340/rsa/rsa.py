import math
import itertools
import fractions
import pickle
import operator

def top_x_pairs(x):
    sorted_pairs = pickle.load( open('sorted_pairs.p', 'rb') )

    print "%5s%17s" % ('e,d', 'appearances')
    print '-'*22
    for pair, amount in sorted_pairs[:x]:
        print "  %-9s    %-4d" % (pair, amount)

def store_sorted_pairs():
    key_pairs = pickle.load( open('key_pairs_no_dupes.p', 'rb') )
    key_dict = dict()
    for key1, key2 in key_pairs:
        str1 = str(key1) + ',' + str(key2)
        if str1 in key_dict: key_dict[str1] += 1
        else: key_dict[str1] = 1

    sorted_pairs = sorted(key_dict.iteritems(), key=operator.itemgetter(1))
    sorted_pairs.reverse()

    pickle.dump(sorted_pairs, open('sorted_pairs.p', 'wb'))

        
def calculate_all_pairs():
    key_pairs = []
    for prime_pair in two_digit_prime_pairs():
        rsa = RSA(*prime_pair)
        key_pairs += rsa.all_possible_keys()

    pickle.dump(key_pairs, open('key_pairs.p', 'wb'))

def remove_duplicates():
    key_pairs = pickle.load( open('key_pairs.p', 'rb') )

    no_dupes = [(key1, key2) for key1, key2 in key_pairs if key1 <= key2]

    pickle.dump(no_dupes, open('key_pairs_no_dupes.p', 'wb'))

def two_digit_prime_pairs():
    return itertools.combinations_with_replacement(two_digit_primes(), 2)

def two_digit_primes():
    primes = []
    for num in range(11, 99, 2):
        is_prime = True
        for i in range(3, int( math.sqrt(num) ) + 1):
            if (num % i is 0):
                is_prime = False
                break
        if is_prime: primes.append(num)
    return primes

class RSA(object):

    def __init__(self, p, q):
        self.p = p
        self.q = q
        self.phi = (p-1)*(q-1)

    def all_possible_keys(self):
        keys = []
        for i in range(1, self.phi):
            if fractions.gcd(i, self.phi) is 1:
                keys.append( (i, self._key_pair_of(i)) )
        return keys

    def _key_pair_of(self, key):
        for i in range(1, self.phi):
            if key * i % self.phi is 1:
                return i
        return None

top_x_pairs(40)
