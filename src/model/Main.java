package model;

import java.util.ArrayList;
import parser.DataParser;
import wekaImpl.WekaImpl;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		ArrayList<Walk> trainWalks = DataParser.parseFiles("train");
		Dataset ds = new Dataset(trainWalks);
		ds.extractFeatures();

		//ADTree, AODE, AODEsr, BayesianLogisticRegression, BayesNet, CitationKNN, ClassificationViaClustering, ComplementNaiveBayes, ConjunctiveRule, DecisionStump, DecisionTable, DMNBtext, FT, GaussianProcesses, HNB, HyperPipes, IB1, IBk, Id3, IsotonicRegression, J48, J48graft, JRip, KStar, LADTree, LBR, LeastMedSq, LibLINEAR, LinearRegression, LMT, Logistic, LogisticBase, M5Base, MDD, MIDD, MILR, MINND, MIOptimalBall, MISMO, MISVM, MultilayerPerceptron, MultipleClassifiersCombiner, NaiveBayes, NaiveBayesMultinomial, NaiveBayesSimple, NBTree, NNge, OneR, PaceRegression, PART, PLSClassifier, PMMLClassifier, PreConstructedLinearModel, Prism, RandomForest, RandomizableClassifier, RandomTree, RBFNetwork, REPTree, Ridor, RuleNode, SerializedClassifier, SimpleLinearRegression, SimpleLogistic, SingleClassifierEnhancer, SMO, SMOreg, SPegasos, UserClassifier, VFI, VotedPerceptron, WAODE, Winnow, ZeroR
		new WekaImpl(ds).run();
	}
}
