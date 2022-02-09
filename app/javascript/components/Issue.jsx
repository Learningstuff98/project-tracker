import React from 'react';
import axios from 'axios';

function Issue(props) {

  const deleteIssue = () => {
    if(confirm("Are you sure?")) {
      axios.delete(`${props.root_url}/projects/${props.project.id}/issues/${props.issue.id}`)
      .catch((err) => console.log(err.response.data));
    }
  };

  const handleButtons = () => {
    if(props.isProjectOwner) {
      return <div>
        <div onClick={() => deleteIssue()} className="red cursor issue-button">
          Delete
        </div>
        <a href={`${props.root_url}/projects/${props.project.id}/issues/${props.issue.id}/edit`}>
          Edit
        </a>
      </div>
    }
  };

  return <div className="issue-box">
    <h5>{props.issue.title}</h5>
    <a className="green" href={`${props.root_url}/issues/${props.issue.id}`}>
      See Details
    </a>
    {handleButtons()}
  </div>
}

export default Issue;
