import copy

class MinMax(object):
    def __init__(self):
        self.node_count = 0

    def solve(self, node, **kwargs):
        self.node_count = 0
        
        if 'prune' in kwargs and kwargs['prune']:
            winner = self.minmax_prune(node, -1, 1)
        else:
            winner = self.minmax(node)

        if winner is -1: winner = 2

        if winner is 0:
            print "Tie game."
        else:
            print "Player %d wins." % winner 
            
        print "Nodes explored: %d" % self.node_count


    def minmax(self, node):
        self.node_count += 1
        if node.is_leaf():
            return node.value()
        elif node.is_max():
            cur_max = -1
            for child in node.children():
                cur_max = max(cur_max, self.minmax(child))
            return cur_max
        else:
            cur_min = 1
            for child in node.children():
                cur_min = min(cur_min, self.minmax(child))
            return cur_min

    def minmax_prune(self, node, alpha, beta):
        self.node_count += 1
        if node.is_leaf():
            return node.value()
        elif node.is_max():
            for child in node.children():
                alpha = max(alpha, self.minmax_prune(child, alpha, beta))
                if beta <= alpha:
                    break
            return alpha
        else:
            for child in node.children():
                beta = min(beta, self.minmax_prune(child, alpha, beta))
                if beta <= alpha:
                    break
            return beta 

class TicTacToeNode(object):

    def __init__(self, board, move=0):
        self._board = board
        self._move = move
        self._value = 0
        self._player = self._cur_player()

    def display(self):
        for i in range(3):
            print "%d, %d, %d" % (self._board[3*i], self._board[3*i+1], self._board[3*i+2])

    def children(self):
        child_nodes = list()
        for move in self._possible_moves():
            if self._board[move] is 0:
                new_board = copy.copy(self._board)
                new_board[move] = self._player
                child_nodes.append( TicTacToeNode(new_board, self._move + 1) )
        return child_nodes

    def is_leaf(self):
        return self._is_winner() or self._move is 9

    def value(self):
        if self._value is 2:
            return -1
        else:
            return self._value

    def is_max(self):
        return self._player is 1

    def _cur_player(self):
        if (
                (self._move > 2 and self._move % 2 is 1) or
                (self._move is 0)
                ):
            return 1
        else:
            return 2

    def _possible_moves(self):
        moves = set( range(9) )
        if self._diagonal_symmetry():
            moves.discard(3)
            moves.discard(6)
            moves.discard(7)
        
        if self._vertical_symmetry():
            moves.discard(6)
            moves.discard(7)
            moves.discard(8)

        if self._horizontal_symmetry():
            moves.discard(2)
            moves.discard(5)
            moves.discard(8)

        return moves

    def _is_winner(self):
        return self._is_horizontal_winner() or self._is_vertical_winner() or self._is_diagonal_winner()

    def _is_vertical_winner(self):
        for i in range(3):
            if (
                    (self._board[i] is not 0) and
                    (self._board[i] is self._board[i+3]) and
                    (self._board[i] is self._board[i+6])
                    ):
                self._value = self._board[i]
                return True
        return False

    def _is_horizontal_winner(self):
        for i in (0, 3, 6):
            if (
                    (self._board[i] is not 0) and
                    (self._board[i] is self._board[i+1]) and
                    (self._board[i] is self._board[i+2])
                    ):
                self._value = self._board[i]
                return True
        return False

    def _is_diagonal_winner(self):
        if (
                (self._board[0] is not 0 or self._board[2] is not 0) and
                (
                    (self._board[0] is self._board[4] and self._board[0] is self._board[8]) or
                    (self._board[2] is self._board[4] and self._board[2] is self._board[6])
                    )
                ):
            self._value = self._board[4]
            return True
        else:
            return False

    def _diagonal_symmetry(self):
        return self._board[1] is self._board[3] and self._board[2] is self._board[6] and self._board[5] is self._board[7]

    def _vertical_symmetry(self):
        return self._board[0] is self._board[6] and self._board[1] is self._board[7] and self._board[2] is self._board[8]

    def _horizontal_symmetry(self):
        return self._board[0] is self._board[2] and self._board[3] is self._board[5] and self._board[6] is self._board[8]

