var latestbuilds = Vue.component("latestbuilds", {

  template: `
    <div>
    <h2>
      Latest Builds
    </h2>
    <ul class="buildlist">
      <li v-for="build in latestBuilds" :class="build.Status">
        <span class="block"><router-link :to="{ name: 'builds', params: { id: build.Id }}">{{ build.Id }}</router-link></span>
        <span class="block"><router-link :to="{ name: 'builddetails', params: { id: build.Id, ts: build.Ts }}">{{ build.Ts }}</router-link></span> 
        {{ build.Status }}
      </li>
    </ul>
    </div>
  `,

  data: function () {
    return {
      latestBuilds: []
    }
  },
  
  mounted() {
    axios.get("api/build/latest").then(response => {this.latestBuilds = response.data})
  }

})