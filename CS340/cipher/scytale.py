from cipher import Cipher
from text import Text

class Scytale(Cipher):
    def __init__(self, text):
        super(Scytale, self).__init__(text)

    def encipher(self, a):
        # break up text into x a-sized chunks
        break_up = [ list( self.text[x*a:x*a+a] ) for x in range( len(self.text) / a ) ]
        transpose = [ list(x) for x in zip(*break_up) ]
        cipher = [ "".join(x) for x in transpose ]
        return "".join(cipher)

    def decipher(self):
        best_result = Text(self.text)

        for num in self.factors():
            cur_cipher = Text( self.encipher(num) )

            if cur_cipher.english_words > best_result.english_words:
                best_result = cur_cipher

        return str(best_result)

    def factors(self):
        n = len(self.text)
        return set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))

