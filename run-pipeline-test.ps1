$resourceGroupName = "challenge2"
$pipelineName = "CopySouthRidge"
$dataFactoryName = "adfchallenge2"

write-Output "Invoke Data Factory Pipeline Test for Southridge CosmosDb"
$runId = Invoke-AzDataFactoryV2Pipeline -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -PipelineName $pipelineName -ParameterFile ".\southridge-pipeline-param.json"
write-output "RunId: $runId"

$exitCode = 1

while ($True) {
    $run = Get-AzDataFactoryV2PipelineRun -ResourceGroupName $resourceGroupName -DataFactoryName $DataFactoryName -PipelineRunId $runId

    if ($run) {
        if ($run.Status -ne 'InProgress') {
            Write-Host "Pipeline run finished. The status is: " $run.Status -foregroundcolor "Yellow"
            $run
            
            break
        }
        Write-Host  "Pipeline is running...status: InProgress" -foregroundcolor "Yellow"
    }

    Start-Sleep -Seconds 30
}

Write-Error "Pipline failed with ExitCode $exitCode"
