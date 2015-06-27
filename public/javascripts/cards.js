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
    slices: function(size, data) {
      var slices = []
      var cards = data ? data : this.data
      for (var i = 0; i < cards.length; i += size) {
        var slice = cards.slice(i, i + size)
        slices.push(slice)
      }
      return slices
    },
    colors: function(colors, data) {
      var cards = data ? data : this.data
      colors = colors.sort()
      return cards.filter(function(card) {
        var a0 = card.colors
        var a1 = colors
        var i0 = i1 = 0
        while (i0 < a0.length && i1 < a1.length) {
          if (a0[i0] == a1[i1]) {
            return true;
          } else if (a0[i0] < a1[i1]) {
            i0++
          } else {
            i1++
          }
        }
        return false
      })
    }
  }
}
