import React from 'react';

function Issue(props) {
  return <div className="issue-box">
    <h5>{props.issue.title}</h5>
    <a className="green" href={`${props.root_url}/issues/${props.issue.id}`}>
      See Details
    </a>
  </div>
}

export default Issue;
