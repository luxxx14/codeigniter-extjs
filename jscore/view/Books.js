/**
 * Список книг
 */
Ext.define('Swan.view.Books', {
	extend: 'Ext.grid.Panel',
    id: 'books-list',
	store: {
		proxy: {
			type: 'ajax',
			url: 'index.php/Book/loadList',
			reader: {
				type: 'json',
				idProperty: 'id'
			}
		},
		autoLoad: true,
		remoteSort: false,
		sorters: [{
			property: 'book_name',
			direction: 'ASC'
		}]
	},
	defaultListenerScope: true,
	tbar: [{
		text: 'Добавить',
		handler: function() {
            formAddWindow = Ext.create('Ext.window.Window', {
                x: 350,
                y: 130,
                title: 'Добавить книгу',
                width: 500,
                height: 400,
                maximizable: false,
                bodyPadding: '10px',
                autoScroll: true,
                closeAction: 'close',
                modal: true,
                items:[
                    Ext.create('Swan.view.BookForm')
                ]
            });
            formAddWindow.show();
		}
	}, {
		text: 'Редактировать',
        id: 'edit-btn',
        disabled: true,
		handler: function() {
			// todo надо реализовать редактирование
			Ext.Msg.alert('В разработке', 'Данный функционал ещё не реализован');
		}
	}, {
		text: 'Удалить',
        id: 'delete-btn',
        disabled: true,
		handler: function() {
            Ext.Ajax.request({
                url: 'index.php/Book/deleteBook',
                method: 'POST',
                params: {
                    'id': ItemId
                },

                success: function(response, opts) {
                    var responseObject = Ext.decode(response.responseText);
                    Ext.Msg.alert('Success', responseObject.msg);
                },
                failure: function(response, opts) {
                    var responseObject = Ext.decode(response.responseText);
                    Ext.Msg.alert('Failed', responseObject.msg);
                }
            });
            Ext.getCmp('edit-btn').disable();
            Ext.getCmp('delete-btn').disable();
            ItemId = null;
            Ext.getCmp('books-list').getStore().reload();
		}
	}, {
		text: 'Экспорт в XML',
		handler: function() {
            window.open('index.php/book/xml');
		}
	}],
	columns: [{
		dataIndex: 'author_name',
		text: 'Автор',
		width: 150
	}, {
		dataIndex: 'book_name',
		text: 'Название книги',
		flex: 1
	}, {
		dataIndex: 'book_year',
		text: 'Год издания',
		width: 150
	}],
    /**
     * обработчик клика по строке списке
     */
    listeners : {
        cellclick : function(view, cell, cellIndex, record, row, rowIndex, e) {
            ItemId = record.data.book_id;

            Ext.getCmp('edit-btn').enable();
            Ext.getCmp('delete-btn').enable();
        }
    }
});