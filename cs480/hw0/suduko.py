import sys
from copy import deepcopy

class SudukoSolver(object):
    def __init__(self, grid):
        self.grid = grid
        self.grid_stack = [ grid ]
        self.open_grid_set = set( [str(grid)] )
        self.closed_grid_set = set()

    def solve(self):
        while self.grid_stack:
            self.grid = self.grid_stack.pop()
            row, col = self.first_zero()
            # Grid is full!
            if row is -1 and col is -1:
                return self.grid
            else:
                for value in self.candidates(row, col):
                    new_grid = deepcopy(self.grid)
                    new_grid[row][col] = value
                    new_grid_string = str(new_grid)

                    if new_grid_string not in self.open_grid_set and new_grid_string not in self.closed_grid_set:
                        self.open_grid_set.add(new_grid_string)
                        self.grid_stack.append(new_grid)

                # add grid string to closed set and remove from open set
                grid_string = str(self.grid)
                self.closed_grid_set.add( grid_string )
                self.open_grid_set.remove( grid_string )
        return None



    # returns the first empty space going left to right, up to down
    def first_zero(self):
        for row in range(9):
            for col in range(9):
                if self.grid[row][col] is 0:
                    return (row, col)
    # no 0 found
        return (-1, -1)

    # given an empty space, returns all legal moves
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

        return remaining


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
        print solution
    else:
        print "No solution"

main()
