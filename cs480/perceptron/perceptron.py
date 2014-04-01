import random

class Perceptron(object):
    def __init__(self, training_set, testing_set):
        """
        inputs is an array of input arrays
        targets is an array of target outputs 
        """
        self.inputs, self.targets = training_set
        self.test_inputs, self.test_targets = testing_set
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

    def test(self):
        total_tests = len(self.test_targets)
        total_correct = 0.0
        for i in range( total_tests ):
            input_vector = [-1] + self.test_inputs[i]
            activation = self.sum_vector(input_vector)
            result = 1 if activation > 0 else 0
            if result == self.test_targets[i]: total_correct += 1
        return total_correct / total_tests

    def sum_vector(self, input_vector):
        activation = [ self.weights[index] * value for index, value in enumerate(input_vector) ]
        return sum(activation)

class TicTacToeData(object):
    def __init__(self, filename):
        self.inputs = []
        self.outputs = []
        self.parse_inputs_and_outputs(filename)

    def parse_inputs_and_outputs(self, filename):
        for row in open(filename, 'r'):
            row_array = row.replace('\n', '').split(',')
            inputs = []
            for i in row_array[:-1]:
                if i == 'x':
                    inputs.append(1)
                elif i == 'o':
                    inputs.append(0)
                else:
                    inputs.append(0)
            self.inputs.append(inputs)
            
            if row_array[-1] == 'positive':
                self.outputs.append(1)
            else:
                self.outputs.append(0)

    def random_training_and_test_set(self):
        total_outputs = len( self.outputs )
        random_order = range(total_outputs)
        random.shuffle(random_order)
        
        training_size = (total_outputs / 10) * 9

        training_input = []
        training_output = []

        for i in random_order[:training_size]:
            training_input.append(self.inputs[i])
            training_output.append(self.outputs[i])

        testing_input = []
        testing_output = []

        for i in random_order[training_size:]:
            testing_input.append(self.inputs[i])
            testing_output.append(self.outputs[i])

        training_set = ( training_input, training_output )
        testing_set = ( testing_input, testing_output )

        return training_set, testing_set


def main():
    data = TicTacToeData('tictactoe.data')
    training_set, testing_set = data.random_training_and_test_set()
    p = Perceptron(training_set, testing_set)
    total_epochs = 20
    total_attempts = 50 
    for epochs in range(1, total_epochs + 1):
        sum_of_percent_correct = 0.0
        for attempts in range(total_attempts):
            p = Perceptron( *data.random_training_and_test_set() )
            p.learn(.025, epochs)
            sum_of_percent_correct += p.test()
        print "Epoch %d: Average correct = %f" % (epochs, sum_of_percent_correct / total_attempts)

    # inputs = [ [1,1], [1,0], [0,1], [0,0] ]
    # outputs = [1,1,1,0]
    # p = Perceptron( (inputs, outputs), (inputs, outputs)  )
    # p.learn(.025, 1000)
    # print p.test()

main()


