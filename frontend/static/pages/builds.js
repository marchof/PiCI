var builds = Vue.component("builds", {

  template: `
    <div>
    <h2>
      Builds for {{ $route.params.id }}
    </h2>
    <ul class="buildlist">
      <li v-for="build in builds" :class="build.status">
        <span class="block"><router-link :to="{ name: 'builddetails', params: { id: build.id, ts: build.ts }}">{{ build.ts }}</router-link></span> 
        {{ build.status }}
      </li>
    </ul>
    </div>
  `,

  data: function () {
    return {
      builds: []
    }
  },
  
  mounted() {
    axios.get("api/build/" + this.$route.params.id).then(response => {this.builds = response.data})
  }

})
