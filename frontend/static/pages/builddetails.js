var builddetails = Vue.component("builddetails", {

  template: `
    <div>
    <h2>
      Details for Build {{ build.Ts }} of {{ build.Id }}
    </h2>
    <p>
      Status: {{ build.Status }}
    </p>
    <h2>Input</h2>
    <p>
      <pre class="info">{{ build.Input }}</pre>
    </p>
    <h2>Build Log</h2>
    <p>
      <a v-bind:href="'api/build/' + build.Id + '/' + build.Ts +'/log'">raw output</a>
    </p>
    <pre class="log">{{ logcontent }}</pre>
    </div>
  `,

  data: function () {
    return {
      build: {},
      logcontent: ""
    }
  },
  
  mounted() {
    axios.get("api/build/" + this.$route.params.id + "/" + this.$route.params.ts).then(response => {this.build = response.data})
    axios.get("api/build/" + this.$route.params.id + "/" + this.$route.params.ts + '/log').then(response => {this.logcontent = response.data})
  }

})