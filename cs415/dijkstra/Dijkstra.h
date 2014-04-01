#ifndef DIJKSTRA_H
#define DIJKSTRA_H

#include "Graph.h"

class Dijkstra {
    public:
        void operator() (const Graph& graph, int startVertex, int goalVertex) const;
    private:
        void printResults(const std::vector<int>& previousVertex, int startVertex, int goalVertex, int totalDistance) const;
};

#endif


