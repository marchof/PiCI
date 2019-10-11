var builds = Vue.component("builds", {

  template: `
    <div>
    <h2>
      Builds for {{ $route.params.id }}
    </h2>
    <ul class="buildlist">
      <li v-for="build in builds" :class="build.status">
        <span class="block"><router-link :to="{ name: 'builddetails', params: { id: build.id, ts: build.ts }}">{{ build.ts }}</router-link></span> 
        {{ build.status }} {{ printDuration(build) }}
      </li>
    </ul>
    </div>
  `,

  data: function () {
    return {
      builds: [],
      updateTimer: ''
    }
  },

  methods: {
    loadBuilds: function () {
      axios.get("api/build/" + this.$route.params.id).then(response => {this.builds = response.data})
    }
  },

  mounted() {
    this.loadBuilds()
    this.updateTimer = setInterval(this.loadBuilds, 10000)
  },

  beforeDestroy () {
    clearInterval(this.updateTimer)
  }

})
