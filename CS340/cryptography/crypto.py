class Crypto(object):
    def __init__(self, text):
        self.text = text.replace(" ", "").lower()

    def encrypt(self, **params):
        raise NotImplementedError

    def decrypt(self):
        raise NotImplementedError
