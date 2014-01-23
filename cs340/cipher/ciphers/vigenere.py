from cipher import Cipher
from affine import Affine
from text import Text
from english import ENGLISH_LETTERS
import itertools

class Vigenere(Cipher):
    def __init__(self, text, key):
        super(Vigenere, self).__init__(text)
        self.key = Text.only_letters(key)
        self.table = { ENGLISH_LETTERS[i]: Affine.create_alphabet( 1, i ) for i in range(26) }
        self.reverse_table = self.create_reverse_table()

    def encipher(self, reverse=False):
        # reverse is for enciphering with the reverse_table (to decipher)
        if reverse:
            return "".join( [ self.reverse_table[key][code] for key, code in zip( itertools.cycle(self.key), self.text)] )
        else:
            return "".join([ self.table[key][ch] for key, ch in zip( itertools.cycle(self.key), self.text) ])

    def decipher(self):
        best_result = Text(self.text)

        cur_cipher = Text( self.encipher(True) )

        if cur_cipher.english_words > best_result.english_words:
            best_result = cur_cipher

        return str(best_result)

    def create_reverse_table(self):
        reverse_table = {}
        for key, alphabet in self.table.iteritems():
            for ch, code in alphabet.iteritems():
                if key in reverse_table:
                    reverse_table[key][code] = ch
                else:
                    reverse_table[key] = { code: ch }

        return reverse_table

"""
    def encipher(self, positions):
        return "".join([ self.alphabets[i][ch] for i, ch in zip( itertools.cycle(positions), self.text) ])

    def decipher(self):
        best_result = Text(self.text)
        for permutation in itertools.permutations( range(26), len(self.key) ):
            cur_cipher = Text( self.encipher(permutation) )

            if cur_cipher.english_words > best_result.english_words:
                best_result = cur_cipher

        return str(best_result)

"""

