import React, { useState, useEffect } from 'react';
import StageForm from './StageForm';
import Stages from './Stages';

function Project(props) {

  const stageForm = <StageForm
    project={props.project}
    root_url={props.root_url}
  />

  const stages = <Stages
    stages={props.stages}
  />

  return <div>
    {stageForm}
    {stages}
  </div>
}

export default Project;
