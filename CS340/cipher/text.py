from english import ENGLISH_LETTERS, ENGLISH_FREQUENCY
from math import sqrt

class Text(object):


    def __init__(self, text):
        self.text = self.only_letters(text)
        self.frequency = self.calculate_frequency()
        self.english_score = 1 / self.english_deviation()

    def english_deviation(self):
        deviation = 0
        for ch in ENGLISH_LETTERS:
            deviation += (self.frequency[ch] - ENGLISH_FREQUENCY[ch])**2

        return sqrt( deviation / 26 )


    def only_letters(self, text):
        # create dict for constant time lookup
        lookup = { ch: True for ch in ENGLISH_LETTERS }

        return "".join( [ ch for ch in text.lower() if ch in lookup ] )

    def calculate_frequency(self):
        # a dictionary of all characters equal to 0
        ch_count = { ch: 0.0 for ch in ENGLISH_LETTERS }

        # increment the value of each character by one for each occurence
        for ch in self.text:
            ch_count[ch] += 1

        # total number of characters
        total = len(self.text)

        # frequency of each character
        return { ch: (count / total) for ch, count in ch_count.iteritems() }

    def __str__(self):
        return self.text

