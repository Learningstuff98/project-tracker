import React, { useState } from "react";
import axios from 'axios';

function NewStageForm(props) {
  const [input, setInput] = useState('');

  const submitStage = (formData) => {
    axios.post(`${props.root_url}projects/${props.project.id}/stages`, formData)
    .catch((err) => console.log(err.response.data));
  };
  
  const handleSubmit = (e) => {
    e.preventDefault();
    if(input.length > 0) {
      submitStage({ name: input });
      props.setShowNewForm(false);
    } else {
      alert("Stage name can't be blank");
    }
  };
  
  const inputButton = () => {
    return <input
      type="submit"
      value="Save"
      className="btn btn-primary"
    />
  };
  
  const inputElement = () => {
    return <input
      type="text"
      placeholder="stage name"
      id="input-element"
      size="30"
      value={input}
      onChange={e => setInput(e.target.value)}
    />
  };
  
  return <form onSubmit={handleSubmit}>
    <div className="spacing-below">{inputElement()}</div>
    {inputButton()}
  </form>
}

export default NewStageForm;
