var http = require('http');
var url  = require('url');
var fs   = require('fs');
var port = 80

http.createServer(function(req, res) {
    if (req.url == '/cors-poc') {
        fs.readFile('cors.html', function(err, data) {
            res.writeHead(200, {'Content-Type':'text/html'});
            res.write(data);
            res.end();
        });
    } else {
        res.writeHead(200, {'Content-Type':'text/html'});
        res.write('never gonna give you up...');
        res.end();
    }
}).listen(port, '0.0.0.0');
console.log(`Serving on port ${port}`);
