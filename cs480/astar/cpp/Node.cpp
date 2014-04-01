#include "Node.h"
#include <iostream>
#include <sstream>
#include <algorithm>

Node::Node(int* inArray, int inDistance) {
    array = inArray;
    hash = Node::arrayToString(array);
    distance = inDistance;
    position = -1;
}

std::string Node::arrayToString(int* array) {
    std::stringstream ss;
    for (int i = 0; i < NODE_LENGTH; ++i) {
        ss << array[i];
    }
    return ss.str();
}

Node* Node::createRandom() {
    int* permutation = new int[NODE_LENGTH];
    for (int i = 0; i < NODE_LENGTH; ++i) {
        permutation[i] = i + 1;
    }
    std::random_shuffle(permutation, permutation + NODE_LENGTH);

    return new Node(permutation, std::rand() % 10 + 1);
}
