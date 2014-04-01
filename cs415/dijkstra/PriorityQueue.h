#ifndef PRIORITY_QUEUE_H
#define PRIORITY_QUEUE_H

#include <vector>
#include <map>
#include <functional>

template <class T, class KeyCompare = std::less<T>, class ValueCompare = std::less<T> >
class PriorityQueue {
    public:
        PriorityQueue() {
            totalNodes = 0;
        }

        void push( T elem ) {
            // if element is already in queue 
            if ( elemLocation.count(elem) != 0 ) {
                // get the position of the element
                int position = elemLocation[elem];
                // and value of new element is better than current
                if ( ValueCompare()(elem, heap[position]) ) {
                    // replace old element with new element
                    removedNodes.push_back( heap[position] );
                    heap[position] = elem;
                    // move element up the heap to correct position
                    moveUp(position);
                }
            }
            else {
                // add element to the bottom of the heap
                heap.push_back(elem);
                // move element up the heap to correct position
                moveUp(totalNodes++);
            }

        }

        T pop() {
            T elem = heap[0];
            heap[0] = heap[--totalNodes];
            elemLocation.erase(elem);
            moveDown(0);
            return elem;
        }

        bool contains( T elem ) {
            return elemLocation.count( elem ) == 1;
        }

        bool empty() {
            return totalNodes == 0;
        }
    private:

        std::vector<T> heap;
        std::map<T, int, KeyCompare> elemLocation;
        std::vector<T> removedNodes;
        int totalNodes;

        void moveUp( int location ) {
            int current = location;
            int parent = parentOf(location);
            T elem = heap[current];

            while (current > 0) {
                if ( ValueCompare()(elem, heap[parent]) ) {
                    T parentElem = heap[parent];
                    heap[current] = parentElem;
                    elemLocation[parentElem] = current;
                    current = parent;
                    parent = parentOf(current);
                }
                else break;
            }

            heap[current] = elem;
            elemLocation[elem] = current;
        }

        void moveDown( int location) {
            int current = location;
            int child = leftChildOf(current);
            T elem = heap[current];

            while (child < totalNodes) {
                if (child < totalNodes - 1 && ValueCompare()( heap[child + 1], heap[child] )) {
                    ++child;
                }

                if ( ValueCompare()(heap[child], elem) ) {
                    T childElem = heap[child];
                    heap[current] = childElem;
                    elemLocation[childElem] = current;
                    current = child;
                    child = leftChildOf(current);
                }
                else break;
            }

            heap[current] = elem;
            elemLocation[elem] = current;
        }

        inline int parentOf(int location) { return (location - 1) / 2; };
        inline int leftChildOf(int location) { return location * 2 + 1; };
};

#endif
