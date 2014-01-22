from cipher import Cipher
from affine import Affine
from text import Text
import itertools

class Vigenere(Cipher):
    def __init__(self, text, key):
        super(Vigenere, self).__init__(text)
        self.key = key
        self.alphabets = { i: Affine.create_alphabet( 1, i ) for i in range(26) }

    def encipher(self, positions):
        return "".join([ self.alphabets[i][ch] for i, ch in zip( itertools.cycle(positions), self.text) ])

    def decipher(self):
        best_result = Text(self.text)
        for permutation in itertools.permutations( range(26), len(self.key) ):
            cur_cipher = Text( self.encipher(permutation) )

            if cur_cipher.english_words > best_result.english_words:
                best_result = cur_cipher

        return str(best_result)
