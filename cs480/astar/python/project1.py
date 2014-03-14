from permutation_astar import *
import random
import time

def main():
    print "What is the size of the permutation?"
    n = int( raw_input() )

    example = range(1, n + 1)
    random.shuffle(example)
    print "What is the permutation? Ex: %s" % str(example)[1:-1].replace(',', '')
    start_node = [ int(x) for x in raw_input().split() ]

    goal_node = range(1, n + 1)

    a = PermutationAStar(start_node, goal_node)
    start = time.time()
    a.search()
    end = time.time()
    total_time = (end - start) * 1000
    print "Nodes visited: %s" % a.nodes_visited
    print "time elapsed: %.0f milliseconds" % total_time


main()
