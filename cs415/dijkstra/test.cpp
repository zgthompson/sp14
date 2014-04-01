#include "PriorityQueue.h"
#include <algorithm>
#include <iostream>

struct Node {

    static int id;
    int key;
    int value;

    Node(int k, int v) {
        key = k;
        value = v;
    }

    static Node createRandom() {
        return Node(id++, std::rand() % 10 + 1);
    }

};

int Node::id = 0;

struct NodeKeyCompare {
    bool operator() (const Node& left, const Node& right) const {
        return left.key < right.key;
    }
};

struct NodeValueCompare {
    bool operator() (const Node& left, const Node& right) const {
        return left.value < right.value;
    }
};

int main(void) {
    PriorityQueue<Node, NodeKeyCompare, NodeValueCompare> pq;

    for (int i = 0; i < 20; ++i) {
        pq.push( Node::createRandom() );
    }

    pq.push( Node(2, 0) );

    for (int i = 0; i < 20; ++i) {
        Node node = pq.pop();
        std::cout << "key: " << node.key << ", value: " << node.value << std::endl;
    }
}
