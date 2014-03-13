import java.util.Comparator;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.Map;
import java.util.HashMap;

public class AStarFringe {

    private static int entryCount = 0;

    Queue<AStarEntry> pq;
    Map<String, AStarEntry> entryFinder;
    
    public AStarFringe() {
        this.pq = new PriorityQueue<AStarEntry>(100, new AStarEntryComparator());
        this.entryFinder = new HashMap<String, AStarEntry>();
    }

    public void addNode(Object node, int priority) {
        String key = node.toString();
        AStarEntry entry = this.entryFinder.get(key);
        if (entry != null) {
            this.removeNode(node);
        }
        entry = new AStarEntry(node, priority);
        this.entryFinder.put(key, entry);
        this.pq.add(entry);
    }

    public void removeNode(Object node) {
        AStarEntry entry = this.entryFinder.remove(node.toString());
        entry.node = null;
    }

    public Object popNode() {
        while ( !this.entryFinder.isEmpty() ) {
            AStarEntry curEntry = this.pq.poll();
            if (curEntry.node != null) {
                this.entryFinder.remove(curEntry.node.toString());
                return curEntry.node;
            }
        }
        return null;
    }

    public boolean isEmpty() {
        return this.entryFinder.isEmpty();
    }

    private class AStarEntry {

        Object node;
        int priority;
        int entryNumber;

        public AStarEntry(Object node, int priority) {
            this.node = node;
            this.priority = priority;
            this.entryNumber = ++entryCount;
        }

    }

    private class AStarEntryComparator implements Comparator<AStarEntry> {
        @Override
        public int compare(AStarEntry entry1, AStarEntry entry2) {
            int diff = entry1.priority - entry2.priority;
            if (diff == 0) diff = entry1.entryNumber - entry2.entryNumber;
            return diff;
        }
    }
}
