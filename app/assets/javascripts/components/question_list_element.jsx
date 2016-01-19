class QuestionListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {}); // Uncomment to add specific state
  }

  content() {
    var solvedMark = null;
    if (this.props.solved) {
      solvedMark = <i className="fa fa-check" />;
    }
    return (
      <div className='post-item question-item'>
        <div className='post-item-text'>
          <div className='post-item-text-name'>
            {this.props.title}
          </div>
          <div className='post-item-text-tagline'>
            posted by
            <PopoverUser user={this.props.user} />
            {solvedMark}
          </div>
        </div>
        <div className='post-item-upvote'>
          <Upvote {...this.props} />
        </div>
      </div>
    )
  }
}
