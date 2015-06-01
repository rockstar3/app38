/*
 * File: app/controller/TypeNavController.js
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

Ext.define('TypeNavigator.controller.TypeNavController', {
    extend: 'Ext.app.Controller',

    models: [
        'NavGridModel'
    ],
    stores: [
        'NavGrid'
    ],
    views: [
        'NavGridForm',
        'NavImage',
        'NavGridView',
        'NavChart',
        'NavPanel'
    ],

    refs: [
        {
            ref: 'form',
            selector: 'navgridform'
        },
        {
            ref: 'image',
            selector: 'navimage'
        },
        {
            ref: 'grid',
            selector: 'navgridview'
        },
        {
            ref: 'tree',
            selector: 'navpaneltree'
        },
        {
            ref: 'chart',
            selector: 'navchart'
        },
        {
            ref: 'chartpanel',
            selector: 'navpanel'
        }
    ],

    init: function(application) {
        this.control({ 
            'navgridview': {
                select: this.onGridSelect
            },
            'navimage': {
                select: this.onImageSelect
            },

            'navchart': {
                afterrender: this.onChartClick            
            },

            'navchart': {

            },
            'navpaneltree': {
                itemclick: this.onTreeSelect,
                afterrender: this.onNavTreeInit        
            }


        });

        this.getNavGridStore().on('update', this.onObjectSelect, this);

    },

    onGridSelect: function(component, record) {
        if ( record ) {
            this.getForm().getForm().loadRecord(record);
            this.getImage().getSelectionModel().select(record);
            this.getNavGridStore().commitChanges();
        }

    },

    onImageSelect: function(component, record) {
        if ( record ) {
            this.getForm().getForm().loadRecord(record);
            this.getGrid().getSelectionModel().select(record);
            this.getNavGridStore().commitChanges();
        }
    },

    onTreeSelect: function(component, record, item, e) {
        getDeepAllChildNodes = function(node){ 
            var allNodes = new Array(); 
            if(!Ext.value(node,false)){ 
                return []; 
            } 

            if(!node.hasChildNodes()){ 
                return node; 
            }else{ 
                allNodes.push(node); 
                node.eachChild(function(Mynode){allNodes = allNodes.concat(getDeepAllChildNodes(Mynode));});         
            } 
            return allNodes; 
        };


        var me = this;
        if ( record.data && !record.data.children ) {

            // Get the current store 
            var s = this.getNavGridStore();
            if ( s ) {

                // Do not clear filters currently applied to the store
                // as we want this to be an additional filter combined w/ state selected
                //s.clearFilter(true);
                s.filter( {id: "season", property:"season", value: record.data.text} );
                me.updateGridTitles();
            }
            console.log(s);
        }
        if( record.data.children ){
            var allChildNodes = getDeepAllChildNodes(record);
            var chartNotice;
            if(allChildNodes.length>0){
                console.log('Folder is not empty');
                chartNotice = this.getChartpanel().queryById('navchartnotice');
                chartNotice.hide();
                this.getChart().show();
            }else{
                console.log('Folder is empty');
                chartNotice = this.getChartpanel().queryById('navchartnotice');
                chartNotice.hide();
                chartNotice.update("No data for " + record.data.text );
                chartNotice.show();
                this.getChart().hide();
            }
        }
        Ext.Ajax.request({
            url: 'data/save_treepanel_session.json',
            method: 'POST',
            params: {
                requestParam: 'notInRequestBody'
            },
            jsonData: { "id": record.data.id, "expanded": record.isExpanded( ) },
            success: function(response) {
                console.log('success');
                var tree_sessions = Ext.decode(response.responseText);
                console.log(tree_sessions);
            },
            failure: function() {
                console.log('failure');
            }
        });



    },

    onChartClick: function(object) {
        var me = this;
        if (this.initializedEvents == true) return;
        this.initializedEvents = true;

        console.log("Initializing the onclick method for the chart");
        console.log(object);
        var series = object.series.getAt(0);
        series.listeners = {
            itemmouseup: function(item) {
                console.log('Clicked on ' + item.value[0]);

                // Get the current store 
                var s = me.getNavGridStore();
                if ( s ) {
                    // Do not clear filters currently applied to the store
                    // as we want this to be an additional filter combined w/ state selected
                    s.filter( {id: "State", property:"state", value: item.value[0]} );
                    me.updateGridTitles();
                }
                console.log(s);
            }
        };

    },

    updateGridTitles: function(object) {
        var me = this;

        var activefilterNames = [];
        var selectedfilterValues = [];

        //Determine active filters
        var s = me.getNavGridStore();
        var applied = "";

        if ( s.filters && s.filters.items.length > 0 ) {
            for ( var i=0; i<s.filters.items.length;i++ ) {
                var f = s.filters.items[i];
                console.log(f);
                applied += f.id + "=" + f.value + ", ";
            }

            if ( applied.length > 0 ) {
                applied = applied.substring(0, applied.length-2);
            }
        } else {
            applied = "None";
        }
        console.log("retrieved filters");


        me.getGrid().setTitle("Applied Filters: " + applied);
    },

    onNavTreeInit: function(component) {
        getDeepAllChildNodes = function(node){ 
            var allNodes = new Array(); 
            if(!Ext.value(node,false)){ 
                return []; 
            } 

            if(!node.hasChildNodes()){ 
                return node; 
            }else{ 
                allNodes.push(node); 
                node.eachChild(function(Mynode){allNodes = allNodes.concat(getDeepAllChildNodes(Mynode));});         
            } 
            return allNodes; 
        };
        var rootNode = this.getTree().getRootNode();
        var storeNavGrid = this.getNavGridStore();
        var chartPanel = this.getChartpanel();

        var me = this;
        Ext.Ajax.request({
            url: 'data/treepanel_session.json',
            success: function(response) {
                var tree_session = Ext.decode(response.responseText);

                var allChildNodes = getDeepAllChildNodes(rootNode);
                Ext.Array.each(allChildNodes, function(node){

                    Ext.Array.each(tree_session['expanded'], function(expand_item) {

                        if(expand_item.id == node.data.id){
                            node.expand();
                        }
                    });
                });
                if(tree_session['selected_node_value'] != ""){


                    if ( storeNavGrid ) {

                        // Do not clear filters currently applied to the store
                        // as we want this to be an additional filter combined w/ state selected
                        //s.clearFilter(true);
                        storeNavGrid.filter( {id: "season", property:"season", value: tree_session['selected_node_value']} );
                        me.updateGridTitles();

                    }
                    //var chartNotice = Ext.getCmp('navchartnotice');
                    //chartNotice.update("Testing...");
                    var chartNotice = chartPanel.queryById('navchartnotice');
                    chartNotice.hide();
                }
                //component.expandAll();
            },
            failure: function() {
                console.log('failure');
            }
        });

    }

});