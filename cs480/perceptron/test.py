import perceptron

p = perceptron.Perceptron([ [1,1], [1,0], [0,1], [0,0] ], [1,1,1,0] )

p.learn(.25, 5)

