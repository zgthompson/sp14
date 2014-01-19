from string import ascii_lowercase

class Text(object):
    def __init__(self, text):
        self.text = text.replace(" ", "").lower()
        self.frequency = self.calculate_frequency()

    def is_english(self):
        """This will be fun"""

    def calculate_frequency(self):
        # a dictionary of all characters equal to 0
        ch_count = { ch: 0.0 for ch in ascii_lowercase }

        # increment the value of each character by one for each occurence
        for ch in self.text:
            ch_count[ch] += 1

        # total number of characters
        total = len(self.text)

        # frequency of each character
        return { ch: (count / total) for ch, count in ch_count.iteritems() }

    def __str__(self):
        return self.text

