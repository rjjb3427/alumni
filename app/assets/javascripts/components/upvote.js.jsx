class Upvote extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      upVoters: props.up_voters,
      upVoted: props.up_voted
    };

    // http://facebook.github.io/react/blog/2015/01/27/react-v0.13.0-beta-1.html#autobinding
    this.onStoreChange = this.onStoreChange.bind(this);
    this.upVote        = this.upVote.bind(this);
  }

  componentDidMount() {
    PostStore.listen(this.onStoreChange);
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onStoreChange);
  }

  onStoreChange(store) {
    var post = store.getPost(this.props.type, this.props.id);
    if (post) {
      this.setState({
        upVoters: post.up_voters,
        upVoted: post.up_voted
      });
    }
  }

  render() {
    var upvoteClasses = classNames({
      'upvote': true,
      'is-upvoted': this.state.upVoted
    });
    return(
      <div onClick={this.upVote} className={upvoteClasses}>
        <div className='upvote-item'>
          <figure className='fa fa-caret-up' />
        </div>
        <div className='upvote-count'>
          {this.state.upVoters.length}
        </div>
      </div>
    )
  }

  upVote(e) {
    PostActions.upVote(this.props.type, this.props.id);
    e.preventDefault();
  }
}
