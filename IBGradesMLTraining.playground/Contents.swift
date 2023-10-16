import Cocoa
import CreateML

let csvFile = Bundle.main.url(forResource: "IBGrades", withExtension: "csv")!
let dataTable = try MLDataTable(contentsOf: csvFile)

print(dataTable)

let regressorColumns = ["Subject", "Level", "Predicted grade"]
let regressorTable = dataTable[regressorColumns]


let (regressorEvaluationTable, regressorTrainingTable) = regressorTable.randomSplit(by: 0.10, seed: 5)

let regressor = try MLLinearRegressor(trainingData: regressorTrainingTable, targetColumn: "Grade")

let worstTrainingError = regressor.trainingMetrics.maximumError
let worstValidationError = regressor.validationMetrics.maximumError

/// Evaluate the regressor
let regressorEvaluation = regressor.evaluation(on: regressorEvaluationTable)

/// The largest distance between predictions and the expected values
let worstEvaluationError = regressorEvaluation.maximumError


//let regressor = try MLLinearRegressor(trainingData: regressorTable, targetColumn: "Grade")


/// Save the trained regressor model to the Desktop.
let homePath = FileManager.default.homeDirectoryForCurrentUser
let desktopPath = homePath.appendingPathComponent("Desktop")

let regressorMetadata = MLModelMetadata(author: "Gustavo Garfias",
                                        shortDescription: "Predicts the IB grade of a student according to subject, level and predicted grade.",
                                        version: "1.0")

try regressor.write(to: desktopPath.appendingPathComponent("IBGradesPredicter1.mlmodel"),
                    metadata: regressorMetadata)
