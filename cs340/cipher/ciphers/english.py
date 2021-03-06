from string import ascii_lowercase

ENGLISH_LETTERS = ascii_lowercase

english_percent = [ 
            8.167, 1.492, 2.782, 4.253, 12.702, 2.228, 2.015, 6.094, 6.966, 
            0.153, 0.772, 4.025, 2.406, 6.749, 7.507, 1.929, 0.095, 5.987,
            6.327, 9.056, 2.758, 0.978, 2.360, 0.150, 1.974, 0.074 ]

ENGLISH_FREQUENCY = { ch: english_percent[x] / 100 for x, ch in enumerate(ENGLISH_LETTERS) }

ENGLISH_DICTIONARY = { word[:-2]: True for word in open("ciphers/words_with_friends.txt", "r") }
