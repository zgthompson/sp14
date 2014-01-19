from cipher import Cipher
from string import ascii_lowercase

class Affine(Cipher):
    def __init__(self, text):
        super(Affine, self).__init__(text)

    def decipher(self):
        """This will be fun"""

    def encipher(self, a, b):
        # create new alphabet based on parameter a, b
        alphabet = self.create_alphabet(a, b)

        # convert each character in text to cipher character
        # ord('a') = 97
        cipher = [ alphabet[ch] for ch in str(self.text) ]

        return "".join(cipher)

    def create_alphabet(self, a, b):
        # chr(97) = 'a'
        return { ch: chr( 97 + (a * x + b) % 26) for x, ch in enumerate(ascii_lowercase) }

