from vigenere import Vigenere
import cProfile

a = Vigenere('Once the length of the key is known, the ciphertext can be rewritten into that many columns, with each column corresponding to a single letter of the key. Each column consists of plaintext that has been encrypted by a single Caesar cipher; the Caesar key (shift) is just the letter of the Vigenere key that was used for that column. Using methods similar to those used to break the Caesar cipher, the letters in the ciphertext can be discovered.', 'cipher')

print Vigenere(a.encipher(), 'cipher').decipher()
#cProfile.run('a.decipher()')
