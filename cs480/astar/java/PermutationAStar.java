import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
import java.lang.Math;
import java.util.Collections;
import java.util.Random;

public class PermutationAStar extends AStar {

    public PermutationAStar(List<Integer> rootNode, List<Integer> goalNode) {
        super(rootNode, goalNode);
    }

    @SuppressWarnings("unchecked")
    @Override
    public Integer hScore(Object node) {
        List<Integer> nodeList = (List<Integer>) node;
        Integer score = 0;
        for (int i = 0; i < nodeList.size() - 1; ++i) {
            if ( Math.abs( nodeList.get(i) - nodeList.get(i+1)) != 1 ) {
                ++score;
            }
        }
        return score / 2;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<NodeAndCost> children(Object node) {
        List<Integer> nodeList = (List<Integer>) node;
        List<NodeAndCost> childList = new ArrayList<NodeAndCost>();
        for (int i = 0; i < nodeList.size() - 1; ++i) {
            for (int j = i + 1; j < nodeList.size(); ++j) {
                childList.add( new NodeAndCost( this.reverseBetweenIndices(nodeList, i, j), 1 ) );
            }
        }
        return childList;
    }

    private List<Integer> reverseBetweenIndices(List<Integer> node, int i, int j) {
        List<Integer> newNode = new ArrayList<Integer>(node);
        for (; i < j; ++i, --j) {
            Collections.swap(newNode, i, j);
        }
        return newNode;
    }

    public static void main(String[] args) {
        List<Integer> goalNode = new ArrayList<Integer>();
        for (int i = 0; i < 10; ++i) {
            goalNode.add(i);
        }

        List<Integer> rootNode = new ArrayList<Integer>(goalNode);
        
        long seed = System.nanoTime();
        Collections.shuffle( rootNode, new Random(seed) );

        PermutationAStar a = new PermutationAStar( rootNode, goalNode );
        long startTime = System.currentTimeMillis();
        List<Object> path = a.search();
        long endTime = System.currentTimeMillis();
        if (path != null) {
            a.printPath(path);
            System.out.println( a.nodesVisited );
            System.out.println( "time elapsed: " + (endTime - startTime) + " milliseconds." );
        }
    }


}
