from collections import deque

class DES(object):

    E = [
            32, 1, 2, 3, 4, 5,
            4, 5, 6, 7, 8, 9,
            8, 9, 10, 11, 12, 13,
            12, 13, 14, 15, 16, 17,
            16, 17, 18, 19, 20, 21,
            20, 21, 22, 23, 24, 25,
            24, 25, 26, 27, 28, 29,
            28, 29, 30, 31, 32, 1
            ]

    PC1 = [
            57, 49, 41, 33, 25, 17, 9,
            1, 58, 50, 42, 34, 26, 18,
            10, 2, 59, 51, 43, 35, 27,
            19, 11, 3, 60, 52, 44, 36,
            63, 55, 47, 39, 31, 23, 15,
            7, 62, 54, 46, 38, 30, 22,
            14, 6, 61, 53, 45, 37, 29,
            21, 13, 5, 28, 20, 12, 4
            ]

    PC2 = [
            14, 17, 11, 24, 1, 5,
            3, 28, 15, 6, 21, 10,
            23, 19, 12, 4, 26, 8,
            16, 7, 27, 20, 13, 2,
            41, 52, 31, 37, 47, 55,
            30, 40, 51, 45, 33, 48,
            44, 49, 39, 56, 34, 53,
            46, 42, 50, 36, 29, 32
            ]

    IP = [
            58, 50, 42, 34, 26, 18, 10, 2,
            60, 52, 44, 36, 28, 20, 12, 4,
            62, 54, 46, 38, 30, 22, 14, 6,
            64, 56, 48, 40, 32, 24, 16, 8,
            57, 49, 41, 33, 25, 17, 9, 1,
            59, 51, 43, 35, 27, 19, 11, 3,
            61, 53, 45, 37, 29, 21, 13, 5,
            63, 55, 47, 39, 31, 23, 15, 7
            ]

    IPF = [
            40, 8, 48, 16, 56, 24, 64, 32,
            39, 7, 47, 15, 55, 23, 63, 31,
            38, 6, 46, 14, 54, 22, 62, 30,
            37, 5, 45, 13, 53, 21, 61, 29,
            36, 4, 44, 12, 52, 20, 60, 28,
            35, 3, 43, 11, 51, 19, 59, 27,
            34, 2, 42, 10, 50, 18, 58, 26,
            33, 1, 41, 9, 49, 17, 57, 25
            ]

    S1 = [
            14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
            0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
            4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
            15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13
            ]

    S2 = [
            15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
            3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
            0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
            13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9
            ]

    S3 = [
            10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
            13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
            13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
            1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12
            ]

    S4 = [
            7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
            13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
            10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
            3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14,
            ]

    S5 = [
            2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
            14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
            4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
            11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3
            ]

    S6 = [
            12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
            10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
            9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
            4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13
            ]

    S7 = [
            4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
            13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
            1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
            6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12
            ]

    S8 = [
            13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
            1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
            7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
            2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11
            ]

    S_BOXES = [ S1, S2, S3, S4, S5, S6, S7, S8 ]

    P = [
            16, 7, 20, 21,
            29, 12, 28, 17,
            1, 15, 23, 26,
            5, 18, 31, 10,
            2, 8, 24, 14,
            32, 27, 3, 9,
            19, 13, 30, 6,
            22, 11, 4, 25
            ]

    def __init__(self, text, key, **kwargs):
        if 'key_format' in kwargs:
            if kwargs['key_format'] is 'binary':
                self.key = list(key)
            else:
               raise Exception("Unrecognized key format") 
        else:
            self.key = list(DES.hex_to_binary(key))

        if 'text_format' in kwargs: 
            if kwargs['text_format'] is 'hex':
                self.text = list(DES.hex_to_binary(text))
            if kwargs['text_format'] is 'binary':
                self.text = list(text)
            else:
                raise Exception("Unrecognized text format")
        else:
            self.text = list(DES.char_to_binary(text))

    @staticmethod
    def char_to_binary(key):
        return ''.join([bin(ord(ch))[2:].zfill(8) for ch in key])

    @staticmethod
    def hex_to_binary(key):
        # covert to base 16 int, then to binary, then pad up to 64 bits
        return bin( int(key, 16) )[2:].zfill(64)

    @staticmethod
    def list_xor(list1, list2):
        # xor the value of each index in list1 with the corresponding value in list2
        return [ str((int(list1[i]) + int(list2[i])) % 2) for i in range( len(list1) ) ]

    def encrypt(self):
        subkeys = self.generate_subkeys()
        initial = self.permute_initial()
        l = initial[:32]
        r = initial[32:]

        for i in range(16):
            expand_r = self.permute_expand(r)
            sub_r = self.s_box_substitution(DES.list_xor(expand_r, subkeys[i]))
            permute_r = self.permute_p(sub_r)
            new_r = DES.list_xor(permute_r, l)

            l = r
            r = new_r
        return ''.join(self.permute_final( r + l ))



    # return result of expansion permutation on text
    def permute_expand(self, text):
        return [ text[i-1] for i in DES.E ]

    def permute_final(self, final_text):
        return [ final_text[ i - 1] for i in DES.IPF ]

    def permute_initial(self):
        # IP 1:64 corresponds to index 0:63
        return [ self.text[i - 1] for i in DES.IP ]

    # return the 16 48-bit subkeys
    def generate_subkeys(self):
        subkeys = list()
        # PC1 1:64 corresponds to index 0:63
        post_pc1 = [ self.key[i - 1] for i in DES.PC1 ]
        #left side
        c = deque( post_pc1[:28] )
        #right side
        d = deque( post_pc1[28:] )

        # keys to left only once for
        single_shift = set( [0, 1, 8, 15] )

        for n in range(16):
            shift = -1 if n in single_shift else -2

            #left shift 1 or 2
            c.rotate(shift)
            d.rotate(shift)

            # combine both halves and run through PC2
            pre_subkey = list(c) + list(d)
            subkeys.append([ pre_subkey[ i - 1 ] for i in DES.PC2 ])

        return subkeys

    # perform an s box substitution on the right side, r
    def s_box_substitution(self, r):
        output = []
        for s_box, i in enumerate( range(0, 48, 6) ):
            # take a chunk of 6 bits
            chunk = r[i:i+6]
            # binary to int of the first and last bit
            row = int(chunk[0]) * 2 + int(chunk[5])
            #binary to int of the middle 4 bits
            col = int( ''.join(str(x) for x in chunk[1:5]), 2)
            # append s_box[row][col]
            output.append( DES.S_BOXES[s_box][ row * 16 + col] )
        return list(''.join( bin(x)[2:].zfill(4) for x in output ) )

    # feed the result of the s box substition on r into the p permutation
    def permute_p(self, r):
        return [ r[i - 1] for i in DES.P ]

