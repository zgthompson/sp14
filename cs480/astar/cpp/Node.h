#ifndef NODE_H
#define NODE_H

#include <string>

struct Node {
    static const int NODE_LENGTH = 9;
    static std::string arrayToString(int* array);
    static Node* createRandom();
    Node(int* inArray, int distance);
    int* array;
    std::string hash;
    int distance;
    int position;
};

#endif
