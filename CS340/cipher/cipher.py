from text import Text
class Cipher(object):
    def __init__(self, text):
        self.text = Text(text)

    def decipher(self):
        raise NotImplementedError
