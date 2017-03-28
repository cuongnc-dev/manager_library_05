CKEDITOR.editorConfig = function(config) {
  config.toolbar = 'booktoolbar';
  config.toolbar_booktoolbar =
  [
    {name: 'basicstyles', items: ['Bold', 'Italic', 'Strike']},
    {name: 'paragraph', items: ['NumberedList', 'BulletedList']},
    {name: 'editing', items: ['Find','Replace', 'Image', 'Table', 'Link']},
    {name: 'tools', items: ['Maximize' ]},
    {name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'Undo', 'Redo' ]},
    {name: 'styles', items: ['Styles','Format']}
  ];
  config.resize_enabled = false;
};
