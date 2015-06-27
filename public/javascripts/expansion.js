$(document).ready(function() {
  new Vue({
    el: '.expansion',
    data: {
      rows: [],
      cards: new Cards($(location).attr('href') + '/json')
    },
    compiled: function() {
      this.cards.onload = function() {
        var slices = this.cards.slices(6)
        var rows = slices.map(function(slice) { return {cards: slice} })
        this.$data.rows = rows
      }.bind(this)
      this.cards.load()
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
