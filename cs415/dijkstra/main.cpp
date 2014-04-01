#include "Graph.h"
#include "Dijkstra.h"
#include <vector>

int main(void) {

    std::vector<std::vector<int> > distanceMatrix = std::vector<std::vector<int> >(8, std::vector<int>(8, -1));

    for (int i = 0; i < 8; ++i)
        distanceMatrix[i][i] = 1;

    Graph graph = Graph(distanceMatrix);
    Dijkstra()(graph, 0, 4);
}
