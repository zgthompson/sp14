from astar import AStar
class PermutationAStar(AStar):

    def __init__(self, start_node, goal_node):
        super(PermutationAStar, self).__init__(start_node, goal_node)

    def h_score(self, node):
        score = 0
        for i in range( len(node) - 1):
            if abs( node[i] - node[i+1] ) != 1: 
                score += 1
        return score / 2.0



    def children(self, node):
        child_list = []
        length = len(node)
        for i in range( length - 1 ):
            for j in range( i + 1, length ):
                #if self.both_breakpoints(node, i, j) and self.fixes_breakpoint(node, i, j):
                child_list.append( (self.reverse_between_indices(node, i, j), 1) )
        return child_list

    def both_breakpoints(self, node, i, j):
        if (i == 0):
            breakpoint_i = node[i] != 0
        else:
            breakpoint_i = abs(node[i] - node[i-1]) != 1

        last_index = len(node) - 1
        if (j == last_index):
            breakpoint_j =  node[last_index] != last_index
        else:
            breakpoint_j = abs(node[j] - node[j + 1]) != 1

        return breakpoint_i and breakpoint_j

    def fixes_breakpoint(self, node, i, j):
        if (i == 0):
            fix_i = node[j] == 0
        else:
            fix_i = abs( node[j] - node[i-1] ) == 1

        last_index = len(node) - 1
        if (j == last_index):
            fix_j = node[i] == last_index
        else:
            fix_j = abs( node[i] - node[j+1] ) == 1

        return fix_i or fix_j

    def reverse_between_indices(self, node, i, j):
        new_node = node[:]
        while i < j:
            temp = new_node[i]
            new_node[i] = new_node[j]
            new_node[j] = temp
            i += 1
            j -= 1
        return new_node

