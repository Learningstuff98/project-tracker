import React from 'react';

function Issue(props) {
  return <a className="green" href={`${props.root_url}/issues/${props.issue.id}`}>
    {props.issue.title}
  </a>
}

export default Issue;
