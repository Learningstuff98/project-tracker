import React, { useState } from 'react';
import NewStageForm from './NewStageForm';

function NewStage(props) {
  const [showNewForm, setShowNewForm] = useState(false);

  const newStageForm = <NewStageForm
    root_url={props.root_url}
    project={props.project}
    setShowNewForm={setShowNewForm}
  />

  if(showNewForm) {
    return <div className="stage-box">
      <div className="stage-header-elements">{newStageForm}</div>
      <h5 onClick={() => setShowNewForm(false)} className="cursor stage-button blue">Close</h5>
    </div>
  }

  return <div className="stage-box">
    <h5 onClick={() => setShowNewForm(true)} className="cursor stage-header-elements new-stage-button">
      + Add a new stage
    </h5>
  </div>  
}

export default NewStage;
