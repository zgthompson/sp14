#ifndef GRAPH_H
#define GRAPH_H

#include <vector>


class Graph {
    public:
        Graph( std::vector<std::vector<int> > distanceMatrix );
        int getTotalVertices() const;
        int distanceBetween(int vertex1, int vertex2) const;
        std::vector<int> getNeighborsOf(int vertex) const;
        void search(int start, int goal);
    private:
        std::vector<std::vector<int> > graph;
        int totalVertices;
};

#endif
