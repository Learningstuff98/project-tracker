import React from "react";

function Stage(props) {
  return <div className="stage-box">
    <h3 className="stage-name">
      {props.stage.name}
    </h3>
  </div>
}

export default Stage;
