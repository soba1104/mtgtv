$(document).ready(function() {
  var evm = new Vue({
    el: '.expansion',
    data: {
      rows: [],
      cards: new Cards($(location).attr('href') + '/json')
    },
    compiled: function() {
      this.cards.onload = function() {
        this.update()
      }.bind(this)
      this.cards.load()
    },
    watch: {
      'rows': function(n, o) {
        $('img.lazy').lazyload()
      }
    }
  })
  evm.update = function(cards) {
    cards = cards ? cards : this.cards.data
    var slices = this.cards.slices(6, cards)
    this.rows = slices.map(function(slice) { return {cards: slice} })
  }

  var cf_gen = function(color) {
    return function(n, o) {
      var colors = ['W', 'B', 'R', 'U', 'G', 'O'].filter(function(c) {
        return this.$data[c]
      }.bind(this))
      evm.update(evm.cards.colors(colors))
    }
  }

  var cvm = new Vue({
    el: '#toolbox',
    data: {
      'W': true,
      'B': true,
      'R': true,
      'U': true,
      'G': true,
      'O': true,
    },
    watch: {
      'W': cf_gen('W'),
      'B': cf_gen('B'),
      'R': cf_gen('R'),
      'U': cf_gen('U'),
      'G': cf_gen('G'),
      'O': cf_gen('O'),
    }
  })
})
