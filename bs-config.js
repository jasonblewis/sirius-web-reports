
/*
 |--------------------------------------------------------------------------
 | Browser-sync config file
 |--------------------------------------------------------------------------
 |
 | For up-to-date information about the options:
 |   http://www.browsersync.io/docs/options/
 |
 | There are more options than you see here, these are just the ones that are
 | set internally. See the website for more info.
 |
 |
 */
module.exports = {
    proxy: 'localhost:5000',
    files: ['lib/**/*.pm',
            'view/**/*.tt',
            'public/*.html',
            'public/css/*.css',
            'public/images/*',
            'public/javascripts/*.js',
           ],
    host: 'localhost',
    open: "external",
    browser: "google-chrome",
};
