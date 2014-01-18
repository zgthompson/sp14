from crypto import Crypto

class Affine(Crypto):
    def __init__(self, text):
        super(Affine, self).__init__(text)

    def encrypt(self, a, b):
        # create new alphabet based on parameter a, b
        alphabet = self.create_alphabet(a, b)

        # convert each character in text to cipher character
        # ord('a') = 97
        cipher = [ alphabet[ord(ch) - 97] for ch in self.text ]

        return "".join(cipher)

    def create_alphabet(self, a, b):
        # chr(97) = 'a'
        return [ chr( 97 + (a * x + b) % 26) for x in range(26) ]

