
/**
 * Форма добавления/редактирования книг
 */

Ext.define('Swan.view.BookForm', {
    extend: 'Ext.form.Panel',
    bodyPadding: 5,
    width: '100%',

    url: 'index.php/Book/addBook',

    layout: 'anchor',
    defaults: {
        anchor: '100%'
    },

    defaultType: 'textfield',
    items: [{
        fieldLabel: 'Название книги',
        name: 'book_name',
        allowBlank: false
    },{
        xtype: 'combobox',
        forceSelection: true,
        fieldLabel: 'Автор',
        name: 'author_id',
        store: {
            fields: ['id', 'full_name'],
            proxy: {
                type: 'ajax',
                url: 'index.php/Book/loadAuthorList',
                reader: {
                    type: 'json',
                    idProperty: 'id'
                }
            },
            autoLoad: true
        },
        valueField: 'id',
        displayField: 'full_name'
    },{
        fieldLabel: 'Год издания',
        name: 'issue_year',
        regex: new RegExp('^(0)$|^([1-9])(\\d{2}|\\d{3})$'),
        allowBlank: false
    }],

    buttons: [{
        text: 'Reset',
        handler: function() {
            this.up('form').getForm().reset();
        }
    }, {
        text: 'Submit',
        formBind: true,
        disabled: true,
        handler: function() {
            var form = this.up('form').getForm();
            if (form.isValid()) {
                form.submit({
                    success: function(form, action) {
                        Ext.Msg.alert('Success', action.result.msg);
                        formAddWindow.hide();
                        Ext.getCmp('books-list').getStore().reload();
                    },
                    failure: function(form, action) {
                        Ext.Msg.alert('Failed', action.result.msg);
                    }
                });
            }
        }
    }],
    renderTo: Ext.getBody()
});

