from cipher import Cipher
from text import Text
from english import ENGLISH_LETTERS

class Affine(Cipher):
    def __init__(self, text):
        super(Affine, self).__init__(text)

    def decipher(self):
        best_result = Text(self.text)
        # go through all possible affine alphabets
        for a in ( 1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25 ):
            for b in range(26):
                cur_cipher = Text( self.encipher(a, b, inverse=True) )

                # if cur_cipher looks more like english than best_result, it becomes the best_result
                if cur_cipher.english_words > best_result.english_words:
                    best_result = cur_cipher

        return str(best_result)

    # Returns a string of ciphertext
    def encipher(self, a, b, **kwargs):
        # create new alphabet based on parameter a, b
        if kwargs and kwargs['inverse']:
            alphabet = self.inverse_alphabet(a, b)
        else:
            alphabet = self.create_alphabet(a, b)

        # convert each character in text to cipher character
        # ord('a') = 97
        cipher = [ alphabet[ch] for ch in self.text ]

        return "".join(cipher)

    def create_alphabet(self, a, b):
        # chr(97) = 'a'
        return { ch: chr( 97 + (a * x + b) % 26) for x, ch in enumerate(ENGLISH_LETTERS) }

    def inverse_alphabet(self, a, b):
        return { ch: chr( 97 + a * (x - b) % 26 ) for x, ch in enumerate(ENGLISH_LETTERS) }

