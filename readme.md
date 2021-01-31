This R program implements a simple neural network model on pima indian dataset
It uses the Keras library to implement the neural network.

The neural network is a sequential model with 1 hidden layer.

The input layer with 2048 nodes activated using tanh. The hidden layer with 16
nodes is activated using sigmoid and output layer with 2 nodes is activated using
softmax.

Dropout layer is also added to enhance the learning and also the learning rate is
monitored and if the learning rate hits a plateau it is reduced.

The accuracy achieved is 77.73%
