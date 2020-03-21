import { Elm } from "./App.elm"
import { createBrowserHistory } from 'history'

const history = createBrowserHistory()
const app = Elm.App.init({ 
  flags: history.location.pathname,
  node: document.querySelector('main'),
})

history.listen((location, _) => {
  app.ports.onUrlChanged.send(location.pathname)
})

app.ports.replace.subscribe(path => {
  history.push(path)
})
