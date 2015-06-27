function Cards(url) {
  return {
    url: url,
    data: [],
    load: function() {
      $.get(this.url, function(data) {
        this.data = data.cards.filter(function(card) {
          return card.type.match(/基本土地/) == null
        })
        this.onload();
      }.bind(this))
    },
    onload: function() {},
    slices: function(size) {
      var slices = []
      var cards = this.data
      for (var i = 0; i < cards.length; i += size) {
        var slice = cards.slice(i, i + size)
        slices.push(slice)
      }
      return slices
    },
  }
}
