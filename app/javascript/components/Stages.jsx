import React from "react";

function Stages(props) {
  return <div>
    {props.stages.map((stage) => {
      return <h3 className="green" key={stage.id}>
        {stage.name}
      </h3>
    })}
  </div>
}

export default Stages;
