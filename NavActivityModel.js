

Ext.define('TypeNavigator.model.NavActivityModel', {
    extend: 'Ext.data.Model',
    alias: 'model.navactivitymodel',

    fields: [
        {
            name: 'object_name'
        },
        {
            name: 'id'
        },
        {
            name: 'modified',
            type: 'date'
        },
        {
            name: 'modified_by'
        },
        {
            name: 'comments'
        },
        {
            name: 'history'
        },
        {
            name: 'image'
        }
    ],


    proxy: {
        type: 'ajax',
        url: 'data/activities.json',
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});