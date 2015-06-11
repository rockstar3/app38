/*
 * File: app/model/NavActivityModel.js
 *
 * This file was generated by Sencha Architect version 2.2.2.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Ext JS 4.2.x library, under independent license.
 * License of Sencha Architect does not include license for Ext JS 4.2.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */


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