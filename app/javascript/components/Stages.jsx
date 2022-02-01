import React from "react";
import Stage from './Stage';

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

  return <div className="stages">
    {sortStagesByID().map((stage) => {
      return <div key={stage.id}>
        {stageComponent(stage)}
      </div>
    })}
  </div>
}

export default Stages;
