import React from "react";
import Stage from './Stage';
import NewStage from './NewStage';

function Stages(props) {

  const stageComponent = (stage) => {
    return <Stage
      stage={stage}
      root_url={props.root_url}
      project={props.project}
      isProjectOwner={props.isProjectOwner}
      issues={props.issues}
      setSelectedIssue={props.setSelectedIssue}
      selectedIssue={props.selectedIssue}
    /> 
  };

  const sortStagesByID = () => {
    return props.stages.sort((x, y) => {
      return x.id - y.id;
    });
  };

  const handleNewStage = () => {
    if(props.isProjectOwner) {
      return <NewStage
        root_url={props.root_url}
        project={props.project}
      />
    }
  };

  return <div className="stages">
    {sortStagesByID().map((stage) => {
      return <div key={stage.id}>
        {stageComponent(stage)}
      </div>
    })}
    {handleNewStage()}
  </div>
}

export default Stages;
