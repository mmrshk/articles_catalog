import consumer from "./consumer"

consumer.subscriptions.create("NoticeChannel", {
  connected() {
    console.log("Connected to the room!");
  },

  disconnected() {
  },

  received(data) {
    $('#article-notice').append('<div class="message"> ' + data.id + ': ' + data.content + '</div>')
  }
});
