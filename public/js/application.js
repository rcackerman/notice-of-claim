
// - form
// - - theme (intro, demographics, etc)
// - - - fieldset

var NOCForm = React.createClass({
  render: function() {
    //var themes = _.uniq(
        //_.map(QUESTIONS,
              //function(i) { return i.theme }
        //)
    //);
    return (
        Hello
        //<NOCThemeGroup questions={this.props.questions}/>    
    );
    //return (
      //themes.forEach(function(theme) {
        //<div className={theme}>
          //<NOCThemeGroup theme={theme} />
        //</div>
      //})
    //);
  }
});

//var NOCThemeGroup = React.createClass({
  //render: function() {
    //var themeQuestions = _.where(this.props.questions,
                                  //{theme: "intro"}
                                //);
    //return (
        //<p>Themes are: {this.props.questions.theme}</p>
        //<div className="themes">
          //<NOCFieldset questions={themeQuestions}/>
        //</div>
    //);
  //}
//});

//var NOCFieldset = React.createClass({
  //render: function() {
    //<div className="checkbox">
      //Fieldset
    //</div>
  //}
//});

//var QUESTIONS = [
  //{theme: "intro"},
  //{theme: "demographics"}
//];

ReactDOM.render(
  <NOCForm />,
  document.getElementById('main')
);

