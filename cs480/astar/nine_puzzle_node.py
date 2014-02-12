from astar import AStarNode


class NinePuzzleNode(AStarNode):
    """
    A nine puzzle state is represented as a list of the numbers 0 through 8
    """
    def _estimated_cost_to_goal(self):
        """
        This returns the total number of misplaced tiles
        """
        for i in range(9):
            misplaced = 9
            if self._state[i] is i+1: misplaced -= 1
            return misplaced

    def children(self):
        pass
        

