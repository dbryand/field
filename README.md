## Debugging

     # https://www.eventedmind.com/feed/meteor-observe-in-a-publish-function

     # Install
     npm install -g node-inspector

     # Start server
     NODE_OPTIONS='--debug' mrt

     # Start the node inspector in another terminal window
     node-inspector

     # Open Chrome and navigate to:
     # http://localhost:8080/debug?port=5858
     # Debug like in browser

## Funkiness

* Jade templates need to get loaded before coffee, so we suffix with .html
