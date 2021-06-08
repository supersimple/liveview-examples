// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import { Socket } from "phoenix"
import topbar from "topbar"
import { LiveSocket } from "phoenix_live_view"

let Hooks = {}
Hooks.CounterUpdate = {
    mounted() {
        this.el.addEventListener("click", e => {
            let container = this.el.closest("div");
            let list = [...container.getElementsByTagName('ul')][0];
            let new_item = document.createElement("li");
            let rand = Math.floor(Math.random() * 30);

            new_item.innerText = rand == 22 ? '🦄' : '🐑';
            new_item.classList.add('inline');
            list.appendChild(new_item);

            e.preventDefault();
        })
    }
}

Hooks.AddTodo = {
    mounted() {
        this.el.addEventListener("click", e => {
            let container = this.el.closest("form").getElementsByClassName("todo_list_container")[0]

            let labels = [...container.getElementsByTagName('label')];
            let new_label = document.createElement("label");
            let new_input = document.createElement("input")
            new_input.setAttribute("name", "items[]");
            new_input.setAttribute("type", "text");
            new_input.setAttribute("value", "");
            new_label.appendChild(new_input);
            container.appendChild(new_label);

            // make sure the remove button is visible
            let rmv = [...this.el.closest("form").getElementsByClassName('remove')];
            rmv[0].classList.remove("hidden");
            e.preventDefault();
        })
    }
}

Hooks.RemoveTodo = {
    mounted() {
        this.el.addEventListener("click", e => {
            let container = this.el.closest("form").getElementsByClassName("todo_list_container")[0];
            let labels = [...container.getElementsByTagName('label')];

            if (labels.length > 0) { labels[labels.length - 1].remove(); }
            if ([...container.getElementsByTagName('label')].length == 0) {
                let rmv = [...this.el.closest("form").getElementsByClassName('remove')];
                rmv[0].classList.add("hidden");
            }
            e.preventDefault();
        })
    }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken }, hooks: Hooks })

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

