//
// IBGradesPredicter4.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML
import Foundation


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class IBGradesPredicter4Input : MLFeatureProvider {

    /// Subject as string value
    var Subject: String

    /// Level as string value
    var Level: String

    /// Predicted grade as double value
    var Predicted_grade: Double

    var featureNames: Set<String> {
        get {
            return ["Subject", "Level", "Predicted grade"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "Subject") {
            return MLFeatureValue(string: Subject)
        }
        if (featureName == "Level") {
            return MLFeatureValue(string: Level)
        }
        if (featureName == "Predicted grade") {
            return MLFeatureValue(double: Predicted_grade)
        }
        return nil
    }
    
    init(Subject: String, Level: String, Predicted_grade: Double) {
        self.Subject = Subject
        self.Level = Level
        self.Predicted_grade = Predicted_grade
    }

}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class IBGradesPredicter4Output : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// Grade as double value
    lazy var Grade: Double = {
        [unowned self] in return self.provider.featureValue(for: "Grade")!.doubleValue
    }()

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(Grade: Double) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["Grade" : MLFeatureValue(double: Grade)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class IBGradesPredicter4 {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        /*
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "IBGradesPredicter4", withExtension:"mlmodelc")!
         */
        return try! MLModel.compileModel(at: Bundle.main.url(forResource: "IBGradesPredicter4", withExtension: "mlmodel")!)
    }

    /**
        Construct IBGradesPredicter4 instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of IBGradesPredicter4.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `IBGradesPredicter4.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct IBGradesPredicter4 instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct IBGradesPredicter4 instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct IBGradesPredicter4 instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<IBGradesPredicter4, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct IBGradesPredicter4 instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> IBGradesPredicter4 {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct IBGradesPredicter4 instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<IBGradesPredicter4, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(IBGradesPredicter4(model: model)))
            }
        }
    }

    /**
        Construct IBGradesPredicter4 instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> IBGradesPredicter4 {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return IBGradesPredicter4(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as IBGradesPredicter4Input

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as IBGradesPredicter4Output
    */
    func prediction(input: IBGradesPredicter4Input) throws -> IBGradesPredicter4Output {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as IBGradesPredicter4Input
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as IBGradesPredicter4Output
    */
    func prediction(input: IBGradesPredicter4Input, options: MLPredictionOptions) throws -> IBGradesPredicter4Output {
        let outFeatures = try model.prediction(from: input, options:options)
        return IBGradesPredicter4Output(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - Subject as string value
            - Level as string value
            - Predicted_grade as double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as IBGradesPredicter4Output
    */
    func prediction(Subject: String, Level: String, Predicted_grade: Double) throws -> IBGradesPredicter4Output {
        let input_ = IBGradesPredicter4Input(Subject: Subject, Level: Level, Predicted_grade: Predicted_grade)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [IBGradesPredicter4Input]
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [IBGradesPredicter4Output]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [IBGradesPredicter4Input], options: MLPredictionOptions = MLPredictionOptions()) throws -> [IBGradesPredicter4Output] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [IBGradesPredicter4Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  IBGradesPredicter4Output(features: outProvider)
            results.append(result)
        }
        return results
    }
}
