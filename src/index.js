import { Elm } from "./App.elm"
import { createBrowserHistory } from 'history'

const history = createBrowserHistory()
const app = Elm.App.init({ node: document.querySelector('main') })

history.listen((location, action) => {
  app.ports.onUrlChanged.send(location.pathname)
})

app.ports.replace.subscribe(path => {
  history.push(path)
})
