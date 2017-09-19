const CDP = require('chrome-remote-interface')

CDP((client) => {
    // extract domains
    const {Network, Page, Runtime} = client
    // setup handlers
    Network.requestWillBeSent((params) => {
        console.log('[req] ' + params.request.url)
    })
    // enable events then start!
    Promise.all([
        Network.enable(),
        Page.enable()
    ]).then(() => {
        Page.navigate({url: 'https://www.amazon.co.jp/mn/dcw/myx.html/ref=kinw_myk_redirect'})

        // login check
        Page.loadEventFired(() => {
          console.log('onload!')
          client.close()
        })


    }).catch((err) => {
        console.error(err)
        client.close()
    })
}).on('error', (err) => {
    // cannot connect to the remote endpoint
    console.error(err)
})
