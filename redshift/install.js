#!/usr/bin/env node

const symlinkSync = require('fs').symlinkSync
const homedir = require('os').homedir
const relative = require('path').relative
const resolve = require('path').resolve
const dirname = require('path').dirname

const location = resolve(homedir(), '.config', 'redshift.conf')
const target = resolve(__dirname, 'redshift.conf')
const relative_target = relative(dirname(location), target)

symlinkSync(relative_target, location)
