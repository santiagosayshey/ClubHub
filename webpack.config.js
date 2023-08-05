const path = require('path');
const glob = require('glob');
const { VueLoaderPlugin } = require('vue-loader');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const srcPath = './src';

function getEntryFiles() {
    const entries = {
        "css/main.css": path.resolve(__dirname, `${path.relative('./', srcPath)}/scss/main.scss`),
    };

    // Add more folders as needed
    (glob.sync(`${path.relative('./', srcPath)}/js/pages/*(club|directory|events|account|authorization|manage)/!(_)*.js`) || []).forEach((file) => {
        const entryName = file.replace(/.*js\/(.*?)\.js$/gi, 'js/$1');
        entries[entryName] = path.resolve(__dirname, file);
    });

    return entries;
}

module.exports = {
    mode: process.env.NODE_ENV === 'development' ? 'development' : 'production',
    entry: getEntryFiles(),
    output: {
        path: path.resolve(__dirname, 'public'),
        filename: '[name].js',
    },
    cache: {
        type: 'filesystem',
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: 'babel-loader',
            },
            {
                test: /\.vue$/,
                loader: 'vue-loader',
            },
            {
                test: /\.sass$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    'css-loader',
                    'sass-loader',
                ],
            },
            {
                test: /\.scss$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    'css-loader',
                    'sass-loader',
                ],
            },
        ],
    },
    plugins: [
        new VueLoaderPlugin(),
        new MiniCssExtractPlugin({
            filename: 'css/main.css',
        }),
    ],
};
