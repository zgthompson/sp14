#include "Dijkstra.h"
#include "PriorityQueue.h"
#include <climits>
#include <iostream>

struct Node {
    int vertex;
    int distance;

    Node(int k, int v) {
        vertex = k;
        distance = v;
    }
};

struct NodeKeyCompare {
    bool operator() (const Node& left, const Node& right) const {
        return left.vertex < right.vertex;
    }
};

struct NodeValueCompare {
    bool operator() (const Node& left, const Node& right) const {
        return left.distance < right.distance;
    }
};

void Dijkstra::operator() (const Graph& graph, int startVertex, int goalVertex) const {

    int totalVertices = graph.getTotalVertices();

    std::vector<int> distanceToStart = std::vector<int>(totalVertices);
    std::vector<int> previousVertex = std::vector<int>(totalVertices, -1);
    PriorityQueue<Node, NodeKeyCompare, NodeValueCompare> pq;

    // initialize all distances to infinity, except for start which is 0
    for (int currentVert = 0; currentVert < totalVertices; ++currentVert) {
        int distance = currentVert == startVertex ? 0 : INT_MAX;
        distanceToStart[currentVert] = distance;
        pq.push( Node(currentVert, distance) );
    }

    while ( !pq.empty() ) {
        Node shortest = pq.pop();
        std::vector<int> neighbors = graph.getNeighborsOf(shortest.vertex);
        for (int i = 0; i < neighbors.size(); ++i) {

            int neighborVertex = neighbors[i];
            int totalDistance = shortest.distance + graph.distanceBetween(shortest.vertex, neighborVertex);
            Node neighbor = Node(neighborVertex, totalDistance);
            
            if ( distanceToStart[neighborVertex] > totalDistance && pq.contains(neighbor) ) {
                distanceToStart[neighborVertex] = totalDistance;
                previousVertex[neighborVertex] = shortest.vertex;
                pq.push(neighbor);
            }
        }
    }

    printResults(previousVertex, startVertex, goalVertex, distanceToStart[goalVertex]);

}

void Dijkstra::printResults(const std::vector<int>& previousVertex, int startVertex, int goalVertex, int totalDistance) const {

    if (previousVertex[goalVertex] == -1) {
        std::cout << "There is no path to the goal." << std::endl;
        return;
    }

    if (startVertex == goalVertex) {
        std::cout << "The start is the goal. Total distance is 0." << std::endl;
        return;
    }

    std::vector<int> vertexPath;

    int currentVertex = goalVertex;

    while (currentVertex != startVertex) {
        currentVertex = previousVertex[currentVertex];
        vertexPath.push_back(currentVertex);
    }

    for (int i = vertexPath.size() - 1; i >= 0; --i) {
        std::cout << vertexPath[i] << " -> ";
    }

    std::cout << goalVertex << std::endl;
    std::cout << "Total distance: " << totalDistance << std::endl;
}



