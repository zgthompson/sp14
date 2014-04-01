#include "Fringe.h"
#include <iostream>

Fringe::Fringe() {
    total_nodes = 0;
}

void Fringe::print() {

    std::cout << "[ ";
    for (int i = 0; i < total_nodes; ++i) {
        std::cout << heap[i] -> distance << " ";
    }
    std::cout << "]" << std::endl;
}

void Fringe::push( Node* node ) {
    heap.push_back(node);
    move_up(total_nodes++);
}

void Fringe::move_up(Node* node) {
    move_up( node -> position );
}

void Fringe::move_up(int location) {
    int current = location;
    int parent = parent_of(location);
    Node* node = heap[current];

    while (current > 0) {
        if (value_of(parent) > (node -> distance)) {
            heap[current] = heap[parent];
            heap[current] -> position = current;
            current = parent;
            parent = parent_of(current);
        }
        else break;
    }

    heap[current] = node;
    node -> position = current;
}

Node* Fringe::pop() {
    Node* node = heap[0];
    heap[0] = heap[--total_nodes];
    move_down(0);
    node -> position = -1;
    return node;
}

void Fringe::move_down(int location) {
    int current = location;
    int child = left_child_of(current);
    Node* node = heap[current];

    while (child < total_nodes) {

        if (child < total_nodes - 1 && value_of(child) > value_of(child + 1)) {
            ++child;
        }

        if ((node -> distance) > value_of(child)) {
            heap[current] = heap[child];
            heap[current] -> position = current;
            current = child;
            child = left_child_of(current);
        }
        else break;
    }

    heap[current] = node;
    node -> position = current;
}
