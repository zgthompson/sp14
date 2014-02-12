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
        if AStarNode not in root_node.__class__.__bases__:
            raise TypeError( "Argument must be a subclass of AStarObject" )

        self._goal_node = goal_node

        # set the goal node
        root_node.set_goal(goal_node)

        # binary search tree for finding minimum cost efficiently
        self._fringe = BinarySearchTree( self._sort_value )
        self._fringe.insert( root_node )

        # set of already visited nodes for efficient membership lookup
        self._visited = set()

    def search(self):
        """
        Returns a list that contains the nodes of the shortest path to the goal,
        starting with the root node and ending with the goal node. Will return
        None if there is no solution.
        """
        while self._fringe:
            # grabs the best candidate so far
            node = self._fringe.pop_min()
            # add node to list of visited nodes

            if hash(node) not in self._visited:
                if node.is_goal():
                    return node.path_to_goal()
                else:
                    self._add_children_to_fringe(node)
                    self._visited.add( hash(node) )
        # no path was found
        return None

    def _sort_value(node):
        return node.total_cost()

    def _add_children_to_fringe(node):
        """
        Adds all children of node to the fringe
        """
        for child in node.children():
            self._fringe.insert( child )

class AStarNode(object):
    """
    An object to use with the AStar search class. It must implement the methods
    _total_estimated_cost() and children()
    """

    def __init__(self, state, cost_so_far=0, parent_node=None):
        self._state = state
        self._cost = cost_so_far
        self._parent = parent_node
        if parent_node:
            self._goal = parent_node._goal
            self._heuristic_cost = self._estimated_cost_to_goal()
        else:
            self._heuristic_cost = 0

    def set_goal(self, goal_node):
        """
        Set the goal node explicitly, this is used for the starting node, all
        the children nodes will inherit the goal from their parent
        """
        self._goal = goal_node
        self._heuristic_cost = self._estimated_cost_to_goal()

    def total_cost(self):
        """
        Return the sum of the cost incurred and the estimated cost remaining
        """
        return self._cost + self._heuristic_cost

    def children(self):
        """
        Returns an iterator of all the states reachable from the current
        state
        """
        raise NotImplementedError

    def is_goal(self):
        """
        Returns true if this node is same as the goal node
        """
        return str(self._state) == str(self._goal._state)

    def path_to_goal(self):
        """
        Returns a list containing all the states starting from the root and
        ending at the current node
        """
        if self._parent:
            path = self._parent.path_to_goal()
            path.append(self._state)
            return path
        else:
            return [ self._state ]

    def __hash__(self):
        """
        Return a hashable representation of AStarObject
        """
        return hash( str(self._state) )

    def __str__(self):
        """
        Return the string representation of the state
        """
        return str(self._state)

    def _estimated_cost_to_goal(self):
        """
        Returns the estimated cost to reach the goal node from this node
        """
        raise NotImplementedError

    
