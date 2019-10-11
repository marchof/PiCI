var latestbuilds = Vue.component("latestbuilds", {

  template: `
    <div>
    <h2>
      Latest Builds
    </h2>
    <ul class="buildlist">
      <li v-for="build in latestBuilds" :class="build.status">
        <span class="block"><router-link :to="{ name: 'builds', params: { id: build.id }}">{{ build.id }}</router-link></span>
        <span class="block"><router-link :to="{ name: 'builddetails', params: { id: build.id, ts: build.ts }}">{{ build.ts }}</router-link></span> 
        {{ build.status }}
      </li>
    </ul>
    </div>
  `,

  data: function () {
    return {
      latestBuilds: [],
      updateTimer: ''
    }
  },

  methods: {
    loadLatestBuilds: function () {
      axios.get("api/build/latest").then(response => {this.latestBuilds = response.data})
    }
  },

  mounted() {
    this.loadLatestBuilds()
    this.updateTimer = setInterval(this.loadLatestBuilds, 10000)
  },

  beforeDestroy () {
    clearInterval(this.updateTimer)
  }

})
