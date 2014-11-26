This java program allows a user to classify unseen walking data using training data.
Multiple classifiers can be used with their available options in Weka.

usage: java -jar MLCode.jar [options] [classifier] [classifier options]

Options:
-h --help                   Prints this message.
-test                       Path to the folder containing the test csv-files.
-train                      Path to the folder containing the test csv-files.
-lo --list options          Lists the available options given the classifier.
-d -- details               Prints the details of the classification.
-cm -- confusion            Prints the confusion matrix of the training set.

Classifier:
-c --classifier             The classifier to be used for the classification.

Classifier Options:
Additional options to be passed to the classifier can be specified here.
e.g. java -jar MLCode.jar -c kNN -k 15 
For a list of available options use -lo -c <classifier>.

Example Usage:
java -jar MLCode.jar -test testFolder -train trainFolder -d -cm -c tree