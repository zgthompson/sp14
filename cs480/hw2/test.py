import minmax
solver = minmax.MinMax()

solver.solve( minmax.TicTacToeNode( [0] * 9 ) )
solver.solve( minmax.TicTacToeNode( [0] * 9 ), prune=True )

solver.solve( minmax.TicTacToeNode( [0, 2, 0, 0, 1, 0, 0, 2, 0], 3  ) )
solver.solve( minmax.TicTacToeNode( [0, 2, 0, 0, 1, 0, 0, 2, 0], 3), prune=True) 


