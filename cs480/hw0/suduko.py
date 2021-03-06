import sys
from copy import deepcopy

class SudukoSolver(object):
    def __init__(self, grid):
        self.grid = grid
        self.grid_stack = [ grid ]
        self.node_counter = 0

    def solve(self):
        while self.grid_stack:
            self.grid = self.grid_stack.pop()
            self.node_counter += 1
            row, col = self.best_zero()
            # Grid is full!
            if row is -1 and col is -1:
                return self.grid
            else:
                # adds new grids to stack in ascending order
                for value in self.candidates(row, col):
                    # create copy of the grid
                    new_grid = deepcopy(self.grid)
                    # insert next move
                    new_grid[row][col] = value
                    # add this new board to the stack
                    self.grid_stack.append(new_grid)
        return None



    # returns the empty space with the least amount of options
    def best_zero(self):

        min_options = 10
        min_coords = (-1, -1)

        for row in range(9):
            for col in range(9):
                if self.grid[row][col] is 0:
                    cur_options= len(self.candidates(row, col))
                    if cur_options < min_options:
                        min_options = cur_options
                        min_coords = (row, col)
        return min_coords


    # returns the first empty space going left to right, up to down
    def first_zero(self):
        for row in range(9):
            for col in range(9):
                if self.grid[row][col] is 0:
                    return (row, col)
    # no empty space found
        return (-1, -1)

    # given an empty space, returns all legal moves in descending order
    def candidates(self, row, col):
        remaining = set( range(1, 10) )

        for i in range(9):
            # remove all in same column 
            remaining.discard( self.grid[i][col] )
            # remove all in same row
            remaining.discard( self.grid[row][i] )

        block_row_start = (row / 3) * 3
        block_col_start = (col / 3) * 3

        # remove all in same block
        for block_row in range( block_row_start, block_row_start + 3 ):
            for block_col in range( block_col_start, block_col_start + 3):
                remaining.discard( self.grid[block_row][block_col] )

        return sorted(remaining)


def load_puzzle( puzzle ):
    result = [ [[] for c in range(9)] for r in range(9) ]
    try:
        f = open(puzzle, 'r')
    except IOError:
        print "Not a valid file."
        return None
    else:
        # read the first line except the \n character
        state = f.read().replace('\n', '').replace(' ', '')
        if len(state) is 81:
            try:
                for pos, value in enumerate(state):
                    #result[row][col] = value
                    result[pos / 9][pos % 9] = int(value)
            except ValueError:
                print "All characters in file must be numbers."
                return None
        else:
            print "Wrong number of values to fill grid."
            return None

    # No errors thrown and result is populated
    f.close()
    return result

def main():
    if len(sys.argv) is not 2:
        print "Use: python suduko.py puzzle1.txt"
        return

    grid = load_puzzle( sys.argv[1] )

    # error was thrown while populating grid
    if not grid:
        return

    solver = SudukoSolver(grid)
    solution = solver.solve()

    if solution:
        for row in solution:
            print row
    else:
        print "No solution"

    print "Nodes visited: " + str(solver.node_counter)

main()
