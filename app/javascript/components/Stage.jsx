import React, { useState } from "react";
import axios from 'axios';
import EditStageForm from './EditStageForm';
import Issue from './Issue';

function Stage(props) {
  const [showEditForm, setShowEditForm] = useState(false);

  const deleteStage = () => {
    if(confirm("Are you sure?")) {
      axios.delete(`${props.root_url}/projects/${props.project.id}/stages/${props.stage.id}`)
      .catch((err) => console.log(err.response.data));
    }
  };

  const editStageForm = <EditStageForm
    root_url={props.root_url}
    stage={props.stage}
    setShowEditForm={setShowEditForm}
    project={props.project}
  />

  const handleButtons = () => {
    if(props.isProjectOwner) {
      return <div>
        <h5 className="cursor stage-button blue" onClick={() => setShowEditForm(true)}>Edit</h5>
        <h5 className="cursor stage-button red" onClick={() => deleteStage()}>Delete</h5>
        <a className="cursor stage-button green new-issue-link" href={`${props.root_url}/projects/${props.project.id}/stages/${props.stage.id}/issues/new`}>
          New Issue
        </a>
      </div>
    }
  };

  const renderIssue = (issue) => {
    return <Issue
      issue={issue}
      root_url={props.root_url}
    />
  };

  const filterIssues = () => {
    return props.issues.filter(issue => issue.stage_id === props.stage.id);
  };

  const renderIssues = () => {
    return filterIssues().map((issue) => {
      return <div key={issue.id}>
        {renderIssue(issue)}
      </div>
    });
  };

  if(showEditForm) {
    return <div className="stage-box spacing-below">
      <div className="stage-header-elements">{editStageForm}</div>
      <h5 className="cursor stage-button blue" onClick={() => setShowEditForm(false)}>Close</h5>
      {renderIssues()}
    </div>
  }

  return <div className="stage-box spacing-below">
    <h3 className="stage-header-elements">{props.stage.name}</h3>
    {handleButtons()}
    {renderIssues()}
  </div>
}

export default Stage;
