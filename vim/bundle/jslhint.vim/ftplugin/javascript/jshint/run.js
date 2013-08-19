/*jshint node:true, unused: true, undef: true, maxlen: 80*/

var print = require('util').puts,
    JSHINT = require('jshint').JSHINT;


function readSTDIN(callback) {
    var stdin = process.openStdin(),
        body = [];

    stdin.on('data', function (chunk) {
        body.push(chunk);
    });

    stdin.on('end', function () {
        callback(body.join(''));
    });
}
/**
 * @param {String} body
 */
readSTDIN(function (body) {
    body = body.split('\n');
    var ok,
        dataInfo,
        globals,
        jshintrcLen = parseInt(body.shift(), 10),
        options,
        msg = [],
        WARN = 'WARN',
        ERROR = 'ERROR';

    if (jshintrcLen === 0) {
        options = {};
    } else {
        options = body.splice(0, jshintrcLen);
        options = options.join('');
        try {
            options = JSON.parse(options);
        } catch (ex) {
            print([0, 0, ERROR,
                'BAD options in .jslinrc file'].join(':'));
            return;
        }
    }
    globals = options.globals || {};
    delete options.globals;
    ok = JSHINT(body, options, globals);

    if (!ok) {
        dataInfo = JSHINT.data();
        //for errors
        msg = dataInfo.errors.map(function (item) {
            //print([item.line, item.character, ERROR, item.reason].join(':'));
            if (item && item.line) {
                return([item.line, item.character,
                    ERROR, item.reason].join(':'));
            }
        });
        print(msg.join('\n'));
    } else {
        print([0, 0, WARN, 'No problems in this file!'].join(':'));
    }
});
