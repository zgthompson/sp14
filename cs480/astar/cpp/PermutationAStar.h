#include <string>
#include <map>
#include "Node.h"
#include "Fringe.h"

class PermutationAStar {
    public:
        PermutationAStar(Node* startNode, Node* endNode); 
        bool search();
    private:
        // private functions 
        int hScore(int* array);
        void addChildrenToFringe(Node* node);
        // private data
        Node* goalNode;
        Fringe fringe;
        std::map<std::string*, Node*> allNodes;
        std::map<std::string*, std::string*> cameFrom;
        int nodesVisited;
};
