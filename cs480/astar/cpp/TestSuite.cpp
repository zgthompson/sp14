#include <iostream>
#include "Node.h"
#include "Fringe.h"

const int TEST_SIZE = 20;

int main(void) {
    Fringe fringe;
    Node* changeNode;
    for (int i = 0; i < TEST_SIZE; ++i) {
        Node* node = Node::createRandom();
        if (i == 0) {
            node -> distance = 11;
            changeNode = node;
        }
        fringe.push( node );
        //fringe.print();
    }

    changeNode -> distance = 3;
    fringe.move_up( changeNode );

    for (int i = 0; i < TEST_SIZE; ++i) {
        Node* node = fringe.pop();
        std::cout << "distance: " << node -> distance << std::endl;
    }
}
