var builds = Vue.component("builds", {

  template: `
    <div>
    <h2>
      Builds for {{ $route.params.id }}
    </h2>
    <ul class="buildlist">
      <li v-for="build in builds" :class="build.Status">
        <span class="block"><router-link :to="{ name: 'builddetails', params: { id: build.Id, ts: build.Ts }}">{{ build.Ts }}</router-link></span> 
        {{ build.Status }}
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