import React from "react";
import axios from 'axios';

function Stage(props) {

  const deleteStage = () => {
    if(confirm("Are you sure?")) {
      axios.delete(`${props.root_url}/stages/${props.stage.id}`)
      .catch((err) => console.log(err.response.data));
    }
  };

  return <div className="stage-box">
    <h3 className="stage-header-elements">{props.stage.name}</h3>
    <h5 className="stage-header-elements red cursor stage-delete-button" onClick={() => deleteStage()}>Delete</h5>
  </div>
}

export default Stage;
