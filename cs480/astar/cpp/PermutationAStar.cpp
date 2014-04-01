#include "PermutationAStar.h"
#include <cmath>

PermutationAStar::PermutationAStar(Node* startNode, Node* endNode) {
    goalNode = endNode;
    nodesVisited = 0;
    fringe.push(startNode);
}

int PermutationAStar::hScore(int* array) {
    int breakpoints = 0;
    for (int i = 0; i < Node::NODE_LENGTH - 1; ++i) {
        if ( std::abs( array[i] - array[i + 1] ) != 1 ) ++breakpoints;
    }
    return breakpoints;
}

void addChildrenToFringe(Node* node) {
    for (int i; i < Node::NODE_LENGTH - 1; ++i) {
        for (int j = i + 1; j < Node::NODE_LENGTH; ++j) {
        }
    }
}

int* reverseBetweenIndices(int* array, int start, int end) {
    int* newArray = new int[Node::NODE_LENGTH];

    int i = 0, j = Node::NODE_LENGTH - 1;
    for (;i < start;++i) newArray[i] = array[i];
    for (;j > end; --j) newArray[j] = array[j];
    // NEED TO FINISH METHOD



}
