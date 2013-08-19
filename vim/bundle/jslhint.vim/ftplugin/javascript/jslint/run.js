/*jslint node: true, sloppy: true, stupid: true */
/*jshint node: true, unused: true, indent: 4, quotmark: single, eqnull: true, maxlen: 80*/

var print = require('util').puts,
    JSLINT = require('jslint');


function readSTDIN(callback) {
    var stdin = process.openStdin(),
        body = [];

    stdin.on('data', function (chunk) {
        body.push(chunk);
    });

    stdin.on('end', function () {
        callback(body.join('\n'));
    });
}

readSTDIN(function (body) {
    var ok = JSLINT(body),
        dataInfo,
        msg = [],
        WARN = 'WARN',
        ERROR = 'ERROR';

    if (!ok) {
        dataInfo = JSLINT.data();
        if (JSLINT.errors && JSLINT.errors.length) {
            JSLINT.errors.forEach(function (item) {
                if (item && item.line) {
                    msg.push([item.line, item.character, ERROR,
                        item.reason].join(':'));
                }
            });
        }
        //for unused
        if (dataInfo && dataInfo.unused && dataInfo.unused.length) {
            dataInfo.unused.forEach(function (item) {
                var reason;
                if (item && item.line) {
                    reason = 'in function ' + item['function'] +
                        ' unused: ' + item.name;
                    msg.push([item.line, item.character || 1,
                        WARN, reason].join(':'));
                }
            });
        }
    } else {
        msg.push([0, 0, WARN, 'NO errors in this file'].join(':'));
    }
    print(msg.join('\n'));
});
