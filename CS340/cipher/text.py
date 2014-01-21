from english import ENGLISH_LETTERS, ENGLISH_FREQUENCY, ENGLISH_DICTIONARY
from math import sqrt

class Text(object):

    def __init__(self, text):
        self.text = Text.only_letters(text)
        #self.frequency = self.calculate_frequency()
        #self.english_score = 1 / self.english_deviation()
        self.english_words = self.count_words()

    @staticmethod
    def split_words(text):
        max_word = 28
        if len(text) < 28:
            max_word = len(text)

        for word_size in reversed( range(1, max_word + 1) ):
            for begin in range( len(text) - word_size + 1):
                if text[begin: begin + word_size] in ENGLISH_DICTIONARY:
                    return Text.split_words( text[:begin] ) + " " + text[begin: begin + word_size] + " " + Text.split_words(text[begin + word_size:])
        return text
        
    def count_words(self):
        count = 0
        for word_size in (4, 5, 6):
            for begin in range( len(self.text) - word_size ):
                if self.text[begin:begin + word_size] in ENGLISH_DICTIONARY:
                    count += 1
        return count

    @staticmethod
    def only_letters(text):
        # create dict for constant time lookup
        lookup = { ch: True for ch in ENGLISH_LETTERS }

        return "".join( [ ch for ch in text.lower() if ch in lookup ] )

    def __str__(self):
        return Text.split_words(self.text).strip().replace("  ", " ")

    def __len__(self):
        return len(self.text)

    def english_deviation(self):
        deviation = 0
        for ch in ENGLISH_LETTERS:
            deviation += (self.frequency[ch] - ENGLISH_FREQUENCY[ch])**2

        return sqrt( deviation / 26 )

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
