import React from "react";
import Stage from './Stage';
import NewStage from './NewStage';

function Stages(props) {

  const stageComponent = (stage) => {
    return <Stage
      stage={stage}
      root_url={props.root_url}
    /> 
  };

  const sortStagesByID = () => {
    return props.stages.sort((x, y) => {
      return x.id - y.id;
    });
  };

  const newStage = <NewStage
    root_url={props.root_url}
    project={props.project}
  />

  return <div className="stages">
    {sortStagesByID().map((stage) => {
      return <div key={stage.id}>
        {stageComponent(stage)}
      </div>
    })}
    {newStage}
  </div>
}

export default Stages;
