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
        this.$data.rows = rows
      }.bind(this))
    },
    watch: {
      'rows': function(n, o) {
        $('img.lazy').lazyload()
      }
    }
  })

  var cf_gen = function(color) {
    return function(n, o) {
      console.log(color + ': ' + o + ' -> ' + n)
    }
  }

  new Vue({
    el: '#toolbox',
    data: {
      white: true,
      black: true,
      red: true,
      blue: true,
      green: true,
      other: true,
    },
    watch: {
      'white': cf_gen('W'),
      'black': cf_gen('B'),
      'red': cf_gen('R'),
      'blue': cf_gen('U'),
      'green': cf_gen('G'),
      'other': cf_gen('O'),
    }
  })
})
