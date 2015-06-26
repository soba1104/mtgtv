$(document).ready(function() {
  new Vue({
    el: '.expansion',
    data: {
      rows: []
    },
    compiled: function() {
      $.get($(location).attr('href') + '/json', function(data) {
        var cards = data.cards.filter(function(card) {
          return card.type.match(/基本土地/) == null
        })
        var rowsize = 6
        var rows = []
        for (var i = 0; i < cards.length; i += rowsize) {
          rows.push({cards: cards.slice(i, i + rowsize)})
        }
      console.log(cards[0])
        this.$data.rows = rows
      }.bind(this))
    }
  })
})
