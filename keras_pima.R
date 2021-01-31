require("keras")pca
require("caret")
set.seed(69420)
df<-read.csv("C:/Users/sampa/Documents/dataset/pima-indians-diabetes.data.csv")
df<-as.data.frame(df)
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) }
x <- as.data.frame(lapply(df[1:8], normalize))
#x<-df[1:8]
y<-df[9]
y_train <- to_categorical(unlist(y), num_classes=2)
x<-data.matrix(x)
model = keras_model_sequential() %>% 
  layer_dense(units=2048, activation = 'tanh', input_shape = ncol(x)) %>%
  layer_dropout(rate=0.4) %>%
  layer_dense(units=16, activation='sigmoid') %>%
  layer_dense(units=2, activation='softmax')
callbacks=list(callback_reduce_lr_on_plateau(monitor = "val_loss", factor = 0.5, 
                      patience = 5, verbose = 0, mode = "auto", cooldown = 1))
compile(model, loss = 'binary_crossentropy', optimizer = optimizer_adam(), 
        metrics = 'accuracy')
history =fit(model, x, y_train, epochs=100, batch_size =256, 
             validation_split = 0.2, callbacks = callbacks)
eval = evaluate(model, x, y_train)
print(eval)
predictions <- model %>% predict_classes(x)
predictions<-factor(predictions)
y_<-factor(unlist(y))
cm<-confusionMatrix(predictions, y_)
f_measure<- 2*((cm$byClass['Pos Pred Value']* cm$byClass['Sensitivity'])/(
  cm$byClass['Pos Pred Value'] + cm$byClass['Sensitivity']))
print(cm$byClass['Pos Pred Value'])
print(cm$byClass['Sensitivity'])
print(cm)
print(f_measure)