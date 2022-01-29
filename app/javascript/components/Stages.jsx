import React from "react";
import Stage from './Stage';

function Stages(props) {

  const stageComponent = (stage) => {
    return  <Stage
      stage={stage}
    /> 
  };

  return <div className="stages">
    {props.stages.map((stage) => {
      return <div key={stage.id}>
        {stageComponent(stage)}
      </div>
    })}
  </div>
}

export default Stages;
