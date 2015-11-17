var React = require('react');
var ReactDOM = require('react-dom');

// form
// - theme
// - - question set

var Form = React.createClass({
  render: function() {
    return (
       <Theme />
    );
  }
});

var Theme = React.createClass({
  render: function() {
    return (
      <div className="theme">
        <h1>Theme</h1>
        <QuestionSet />
      </div>
    );
  }
});

var QuestionSet = React.createClass({
  render: function() {
    return (
        <div className="form-group">
          <label>Label</label>
          <input />
        </div>
    );
  }
});

ReactDOM.render(
  <Form />,
  document.getElementById('main')
);

