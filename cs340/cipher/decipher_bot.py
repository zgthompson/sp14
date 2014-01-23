from ciphers.affine import Affine
from ciphers.scytale import Scytale
from ciphers.playfair import Playfair
from ciphers.vigenere import Vigenere
from ciphers.text import Text
import sys

def main():

    # wrong number of args
    if len(sys.argv) not in (2, 3):
        print "Use: python decipher_bot.py ciphertext [key]"
        return

    cipher_text = sys.argv[1]

    # no key, only ciphertext
    if len(sys.argv) is 2:
        best_affine = Text( Affine(cipher_text).decipher() )
        best_scytale = Text( Scytale(cipher_text).decipher() )

        if best_affine.english_words > best_scytale.english_words:
            print str(best_affine)
        else:
            print str(best_scytale)

    #key provided
    elif len(sys.argv) is 3:
        key = sys.argv[2]

        best_playfair = Text( "" )

        if len(key) is 25:
            best_playfair = Text( Playfair(cipher_text, key).decipher() )

        best_vigenere = Text( Vigenere(cipher_text, key).decipher() )

        if best_vigenere.english_words > best_playfair.english_words:
            print str(best_vigenere)
        else:
            print str(best_playfair)

    return

# run main function
main()
