from cipher import Cipher
from text import Text

class Playfair(Cipher):
    def __init__(self, text, key):
        super(Playfair, self).__init__(text)
        self.key = self.create_key( Text.only_letters(key) )

    def decipher(self):
        best_result = Text(self.text)
        # all possible combos
        for combo in ( (1,1,1), (1,1,-1), (1, -1, 1), (-1, 1, 1),
                (1,-1,-1), (-1, 1, -1), (-1, -1, 1), (-1, -1, -1) ):
            cur_cipher = Text( self.encipher( *combo ) )

            if cur_cipher.english_words > best_result.english_words:
                best_result = cur_cipher

        return str(best_result)

    # default: same_row goes right, same_col goes down, corners swap cols
    def encipher(self, same_row=1, same_col=1, corners=1):

        cipher = ""
        for (ch1, ch2) in zip( self.text[0::2], self.text[1::2] ):
            ch1_row = self.key[ch1]["row"]
            ch2_row = self.key[ch2]["row"]
            ch1_col = self.key[ch1]["col"]
            ch2_col = self.key[ch2]["col"]

            # same row
            if ch1_row is ch2_row:
                cipher += self.key[ch1_row][(ch1_col + same_row) % 5]
                cipher += self.key[ch2_row][(ch2_col + same_row) % 5]
            # same col
            elif ch1_col is ch2_col:
                cipher += self.key[(ch1_row + same_col) % 5][ch1_col]
                cipher += self.key[(ch2_row + same_col) % 5][ch2_col]
            # diagonals
            else:
                if corners > 0:
                    cipher += self.key[ch1_row][ch2_col] + self.key[ch2_row][ch1_col]
                else:
                    cipher += self.key[ch2_row][ch1_col] + self.key[ch1_row][ch2_col]
        return cipher



    def create_key(self, key):
        result = {}
        for i, ch in enumerate(key):
            cur_row = i / 5
            cur_col = i % 5
            # lookup by char
            result[ch] = { "row": cur_row, "col": cur_col }

            # lookup by row/col
            if cur_row in result:
                result[cur_row][cur_col] = ch
            else:
                result[cur_row] = { cur_col: ch }

        return result

