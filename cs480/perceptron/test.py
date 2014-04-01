import perceptron

def main():
    for line in open('tictactoe.data', 'r'):
        print line

    #p = perceptron.Perceptron([ [1,1], [1,0], [0,1], [0,0] ], [1,1,1,0] )
    #p.learn(.25, 5)

main()

