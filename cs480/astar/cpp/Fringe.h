#ifndef FRINGE_H
#define FRINGE_H

#include <map>
#include <queue>
#include <string>
#include "Node.h"

class Fringe {
    public:
        Fringe();
        void print();
        void push( Node* node );
        Node* pop();
        void move_up( Node* node );

    private:
        std::vector<Node*> heap;
        int total_nodes;
        void move_up( int location );
        void move_down( int location );

        inline int parent_of(int location) { return (location - 1) / 2; };
        inline int left_child_of(int location) { return location * 2 + 1; };
        inline int value_of(int location) { return heap[location] -> distance; };

};

#endif
