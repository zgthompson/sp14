from bst import BinarySearchTree

class AStar(object):
    """
    Given a starting node and a goal node, finds the shortest cost path
    from the starting node to the goal node
    """
    def __init__(self, root_node, goal_node):
        """
        Initializes the AStar object and sets function that determines the
        order in which the nodes are evaluated.
        """
        if AStarObject not in root_node.__class__.__bases__:
            raise TypeError( "Argument must be a subclass of AStarObject" )

        self._fringe = BinarySearchTree( root_node.__class__.total_estimated_cost )
        self._fringe.insert( root_node )

        self._goal_node = goal_node

    def search(self):
        """
        Return the length of the shortest path from the start node to the goal
        node. Returns -1 if there is no path.
        """
        while self._fringe:

            # grabs the best candidate so far
            node = self._fringe.pop_min()

            if self._is_goal_node(node):
                return node.cost_from_root()
            else:
                self._add_children_to_fringe(node)
        # no path was found
        return -1

    def _is_goal_node(self, node):
        """
        Returns True if node and goal_node are the same and False otherwise
        """
        return str(node) is str(self._goal_node)

    def _add_children_to_fringe(node):
        """
        Adds all children of node to the fringe
        """
        for child in node.get_children():
            self._fringe.insert( child )

class AStarObject(object):
    """
    An object to use with the AStar search class. It must implement the class method
    total_estimated_cost(node) and the instance methods get_children()
    """
    @staticmethod
    def total_estimated_cost(node):
        """
        Returns the sum of the distance from the root and the estimated
        distance to the goal
        """
        return node.cost_from_root() + node.estimated_cost_to_goal()

    def estimated_cost_to_goal():
        """
        Returns the estimated cost to reach the goal node from this node
        """
        raise NotImplementedError

    def cost_from_root(self):
        """
        Returns the total cost incurred so far to get to this node
        from the root node
        """
        raise NotImplementedError

    def get_children(self):
        """
        Returns an iterator of all the states reachable from the current
        state
        """
        raise NotImplementedError
