write-Output "Invoke Data Factory Pipeline Test for Southridge CosmosDb"
$runId = Invoke-AzDataFactoryV2Pipeline -DataFactoryName "adfchallenge2" -ResourceGroupName "challenge2" -PipelineName "CopySouthRidge" -ParameterFile ".\southridge-pipeline-param.json"
write-output "RunId: $runId"
