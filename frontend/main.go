package main

import (
  "os"
  "path/filepath"
  "io/ioutil"
  "net/http"
  "encoding/csv"
  "encoding/json"
  "sort"
  "strconv"
  "time"
  "github.com/gorilla/mux"
  "github.com/gorilla/handlers"
)


func main() {
  c := Controller{BuildRoot: os.Args[1]}
  r := mux.NewRouter()
  r.HandleFunc("/api/build/latest", c.handleLatest)
  r.HandleFunc("/api/build/{id}", c.handleBuilds)
  r.HandleFunc("/api/build/{id}/{ts}", c.handleBuild)
  r.HandleFunc("/api/build/{id}/{ts}/log", c.handleBuildLog)
  r.HandleFunc("/api/build/{id}/{ts}/input", c.handleInput)
  r.PathPrefix("/").Handler(http.FileServer(http.Dir("./static/")))
  http.ListenAndServe(":80", handlers.LoggingHandler(os.Stdout, r))
}


type Build struct {
  Id string `json:"id"`
  Status string `json:"status"`
  Ts string `json:"ts"`
  StartTime int64 `json:"starttime"`
  Duration int64 `json:"duration"`
}

func (b Build) toJSON() []byte {
  json, _ := json.Marshal(b)
  return json
}


type Controller struct {
  BuildRoot string
}

func (c Controller) handleLatest(w http.ResponseWriter, r *http.Request) {
  infos, err := ioutil.ReadDir(c.BuildRoot)
  if err != nil {
    http.Error(w, err.Error(), 500)
    return
  }
  builds := []Build{}
  for _, i := range infos {
    b, err := c.readBuild(i.Name(), "latest")
    if err == nil {
      builds = append(builds, b)
    }
  }
  sortBuildsByDate(builds)
  json, _ := json.Marshal(builds)
  w.Write(json)
}

func (c Controller) handleBuilds(w http.ResponseWriter, r *http.Request) {
  vars := mux.Vars(r)
  infos, err := ioutil.ReadDir(filepath.Join(c.BuildRoot, vars["id"], "output"))
  if err != nil {
    http.Error(w, err.Error(), 500)
    return
  }
  builds := []Build{}
  for _, i := range infos {
    if i.Mode() & os.ModeSymlink == 0 {
      b, err := c.readBuild(vars["id"], i.Name())
      if err == nil {
        builds = append(builds, b)
      }
    }
  }
  sortBuildsByDate(builds)
  json, _ := json.Marshal(builds)
  w.Write(json)
}

func (c Controller) handleBuild(w http.ResponseWriter, r *http.Request) {
  vars := mux.Vars(r)
  build, err := c.readBuild(vars["id"], vars["ts"])
  if err == nil {
    w.Write(build.toJSON())
  } else {
    http.Error(w, err.Error(), 500)
  }
}

func (c Controller) handleBuildLog(w http.ResponseWriter, r *http.Request) {
  vars := mux.Vars(r)
  content, err := ioutil.ReadFile(c.getBuildFile(vars["id"], vars["ts"], "build.log"))
  if err == nil {
    w.Write(content)
  } else {
    http.Error(w, err.Error(), 500)
  }
}

func (c Controller) handleInput(w http.ResponseWriter, r *http.Request) {
  vars := mux.Vars(r)
  content, err := ioutil.ReadFile(c.getBuildFile(vars["id"], vars["ts"], "INPUT"))
  if err == nil {
    w.Write(content)
  } else {
    http.Error(w, err.Error(), 500)
  }
}

func (c Controller) getBuildFile(id string, ts string, path ...string) string {
  return filepath.Join(append([]string{c.BuildRoot, id, "output", ts}, path...)...)
}

func (c Controller) readTimes(id string, ts string) (t map[string]int64, err error) {
  f, err := os.Open(c.getBuildFile(id, ts, "TIME"))
  if err != nil {
    return nil, err
  }
  defer f.Close()

  reader := csv.NewReader(f)
  reader.Comma = ' '
  lines, err := reader.ReadAll()
  if err != nil {
    return nil, err
  }
  t = make(map[string]int64)
  for _, line := range lines {
    value, err := strconv.ParseInt(line[1], 10, 64)
    if err == nil {
      t[line[0]] = value
    }
  }
  return t, nil
}

func (c Controller) readBuild(id string, ts string) (b Build, err error)  {
  b = Build{Id: id}
  path, err := filepath.EvalSymlinks(c.getBuildFile(id, ts))
  if err != nil {
    return b, err
  }
  b.Ts = filepath.Base(path)
  status, err := ioutil.ReadFile(c.getBuildFile(id, ts, "STATUS"))
  if err != nil {
    return b, err
  } 
  b.Status = string(status)

  t, err := c.readTimes(id, ts)
  if err == nil {
    b.StartTime = t["start"]
    end := t["end"]
    if end == 0 {
      now := time.Now()
      b.Duration = now.Unix() - b.StartTime
    } else {
      b.Duration = end - b.StartTime
    }
  }

  return b, nil
}

func sortBuildsByDate(builds []Build) {
  sort.Slice(builds, func(i, j int) bool {
    return builds[i].Ts > builds[j].Ts
  })
}
