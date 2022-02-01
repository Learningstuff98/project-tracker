import React, { useState } from "react";
import axios from 'axios';

function StageEditForm(props) {
  const [input, setInput] = useState(props.stage.name);

  const submitStage = (formData) => {
    axios.patch(`${props.root_url}/stages/${props.stage.id}`, formData)
    .catch((err) => console.log(err.response.data));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if(input.length > 0) {
      submitStage({ name: input });
      setInput('');
      props.setShowEditForm(false);
    } else {
      alert("Stage name can't be blank");
    }
  };

  const inputButton = () => {
    return <input
      type="submit"
      value="Submit"
      className="btn btn-primary"
    />
  };

  const inputElement = () => {
    return <input
      type="text"
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

export default StageEditForm;
