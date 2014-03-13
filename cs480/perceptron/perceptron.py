import random

class Perceptron(object):
    def __init__(self, inputs, targets):
        """
        inputs is an array of input arrays
        targets is an array of target outputs 
        """
        self.inputs = inputs
        self.targets = targets
        self.weights = [ (random.random() *.1) - 0.05 for x in range( len(self.inputs[0]) + 1 ) ]

    def learn(self, learning_rate, iterations):
        total_inputs = len(self.inputs[0]) + 1

        for times in range(iterations):
            for i in range(len(self.inputs)):

                target = self.targets[i]
                input_vector = [-1] + self.inputs[i]

                activation = self.sum_vector(input_vector)

                result = 1 if activation > 0 else 0
                error = target - result

                if error != 0:
                    for index, value in enumerate(input_vector):
                        self.weights[index] += learning_rate * error * value
                print self.weights

    def sum_vector(self, input_vector):
        activation = [ self.weights[index] * value for index, value in enumerate(input_vector) ]
        return sum(activation)











