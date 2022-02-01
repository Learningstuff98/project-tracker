import React, { useState } from "react";
import axios from 'axios';
import StageEditForm from './StageEditForm';

function Stage(props) {
  const [showEditForm, setShowEditForm] = useState(false);

  const deleteStage = () => {
    if(confirm("Are you sure?")) {
      axios.delete(`${props.root_url}/stages/${props.stage.id}`)
      .catch((err) => console.log(err.response.data));
    }
  };

  const stageEditForm = <StageEditForm
    root_url={props.root_url}
    stage={props.stage}
    setShowEditForm={setShowEditForm}
  />

  if(showEditForm) {
    return <div className="stage-box">
      <div className="stage-header-elements">{stageEditForm}</div>
      <h5 className="cursor stage-button blue" onClick={() => setShowEditForm(false)}>Close</h5>
    </div>
  }

  return <div className="stage-box">
    <h3 className="stage-header-elements">{props.stage.name}</h3>
    <h5 className="cursor stage-button blue" onClick={() => setShowEditForm(true)}>Edit</h5>
    <h5 className="cursor stage-button red" onClick={() => deleteStage()}>Delete</h5>
  </div>
}

export default Stage;
