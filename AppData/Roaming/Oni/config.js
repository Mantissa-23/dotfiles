"use strict";
exports.__esModule = true;
exports.activate = function (oni) {
    console.log("config activated");
    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", function () { return console.log("Control+Enter was pressed"); });
    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
};
exports.deactivate = function (oni) {
    console.log("config deactivated");
};
exports.configuration = {
    /// Configuration of configuration
    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,
    /// Aesthetic
    "ui.colorscheme": "gruvbox",
    "editor.fontSize": "12px",
    "editor.fontFamily": "Consolas",
    // UI customizations
    "ui.animations.enabled": false,
    "ui.fontSmoothing": false
};
