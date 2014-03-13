import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;

public abstract class AStar {

    Object goalNode;
    AStarFringe fringe;
    Map<String, Integer> minNodeScore;
    Map<String, Object> cameFrom;
    int nodesVisited;

    public AStar(Object rootNode, Object goalNode) {
        this.goalNode = goalNode;

        this.fringe = new AStarFringe();
        this.fringe.addNode( rootNode, this.hScore(rootNode) );

        this.minNodeScore = new HashMap<String, Integer>();
        this.minNodeScore.put( rootNode.toString(), 0 );

        this.cameFrom = new HashMap<String, Object>();

        this.nodesVisited = 0;
    }

    public abstract List<NodeAndCost> children(Object node);
    public abstract Integer hScore(Object node);

    public List<Object> search() {
        while ( !this.fringe.isEmpty() ) {
            Object currentNode = this.fringe.popNode();
            this.nodesVisited++;

            if (this.isGoal(currentNode)) {
                return this.pathToRoot(currentNode);
            }
            else {
                this.addChildrenToFringe(currentNode);
            }
        }
        return null;
    }

    public void printPath(List<Object> path) {
        for (Object node : path) {
            System.out.println(node.toString());
        }
    }

    private List<Object> pathToRoot(Object node) {
        List<Object> path = new ArrayList<Object>();
        Object curNode = node;
        do {
            path.add(curNode);
            curNode = this.cameFrom.get(curNode.toString());
        } while ( curNode != null);

        Collections.reverse(path);

        return path;
    }

    private boolean isGoal(Object node) {
        return node.toString().equals(this.goalNode.toString());
    }

    private void addChildrenToFringe(Object node) {
        String nodeKey = node.toString();
        Integer costToNode = this.minNodeScore.get(nodeKey);

        for (NodeAndCost childAndCost : this.children(node)) {
            Integer costToChild = costToNode + childAndCost.cost;
            String childKey = childAndCost.node.toString();

            Integer curChildCost = this.minNodeScore.get(childKey);
            if (curChildCost == null || costToChild < curChildCost) {
                this.fringe.addNode(childAndCost.node, costToChild + this.hScore(childAndCost.node));
                this.minNodeScore.put(childKey, costToChild);
                this.cameFrom.put(childKey, node);
            }
        }
    }

    public class NodeAndCost {
        Object node;
        Integer cost;

        public NodeAndCost(Object node, Integer cost) {
            this.node = node;
            this.cost = cost;
        }
    }
}
