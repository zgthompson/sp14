#include "Graph.h"

Graph::Graph( std::vector<std::vector<int> > distanceMatrix ) {
    graph = distanceMatrix;
    totalVertices = graph.size();
}

int Graph::getTotalVertices() const {
    return totalVertices;
}

int Graph::distanceBetween(int vertex1, int vertex2) const {
    return graph[vertex1][vertex2];
}

std::vector<int> Graph::getNeighborsOf(int vertex) const {
    std::vector<int> neighbors;

    for (int i = 0; i < totalVertices; ++i) {
        if (graph[vertex][i] >= 0) {
            neighbors.push_back(i);
        }
    }

    return neighbors;
}
