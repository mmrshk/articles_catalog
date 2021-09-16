import consumer from "./consumer"

consumer.subscriptions.create("NoticeChannel", {
  connected() {
    console.log("Connected to the room!");
  },

  disconnected() {
  },

  received(data) {
    $('#article-notice').append(`
      <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <div class="message"> ${data.id}: ${data.content}</div>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    `)
  }
});
