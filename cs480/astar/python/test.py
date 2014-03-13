import cProfile
from permutation_astar import *
import random
import time

perm_size = 4

start_node = range(1, perm_size+1)
random.shuffle(start_node)

# test 1
# start_node = [1, 10, 2, 9, 3, 8, 4, 7, 5, 6]

#test 2
#start_node = [10, 9, 11, 13, 8, 1, 6, 3, 2, 5, 12, 4, 7]

# worst cases encountered
#start_node = [5, 19, 16, 8, 14, 2, 18, 9, 7, 13, 0, 11, 20, 3, 1, 6, 4, 21, 15, 17, 10, 12]
#start_node = [18, 5, 9, 19, 20, 12, 16, 21, 8, 13, 10, 7, 1, 17, 15, 11, 3, 0, 14, 2, 6, 4]
goal_node = range(1, perm_size+1)

a = PermutationAStar(start_node, goal_node)
start = time.time()
cProfile.run('a.search()')
end = time.time()
total_time = (end - start) * 1000
print "Nodes visited: %s" % a.nodes_visited
print "time elapsed: %.0f milliseconds" % total_time
