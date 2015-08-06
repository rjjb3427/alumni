var PostList = React.createClass({
  render: function() {
    return (
      <div>
        <div className='col-sm-3 posts-column'>
        <div className='posts-column-new'>
          ADD A NEW RESOURCE
        </div>
          {this.props.resources.map(resource => {
            var props = _.merge(resource, { key: `${resource.type}-${resource.id}` });
            return React.createElement(eval(resource.type + "ListElement"), props);
          })}
        </div>
        <div className='col-sm-3 posts-column'>
        <div className='posts-column-new'>
          ASK A NEW QUESTION
        </div>
          {this.props.questions.map(question => {
            var props = _.merge(question, { key: `${question.type}-${question.id}` });
            return React.createElement(eval(question.type + "ListElement"), props);
          })}
        </div>
        <div className='col-sm-3 posts-column'>
          <div className='posts-column-new'>
            ADD A NEW JOB
          </div>
        </div>
        <div className='col-sm-3 posts-column'>
          <div className='posts-column-new'>
            ADD A NEW MILESTONE
          </div>
        </div>
      </div>
    );
  }
});
