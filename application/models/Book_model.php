<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Class Book_model
 * Модель для работы с книгами
 */
class Book_model extends CI_Model {

    /**
     * Получение автора из связанной таблицы
     */
    public function getAuthorById($authorID) {
        $query = $this->db->get_where('authors', ['id' => intval($authorID)]);

        return $query->result()[0]->first_name . ' ' . $query->result()[0]->last_name;
    }

    /**
     * Загрузка списка книг
     */
    public function loadList()
    {
        $result = [];
        $query = $this->db->get('books');
        foreach ($query->result() as $row)
        {
            $result[] = array('book_id' => $row->id, 'book_name' => $row->name, 'author_name' => $this->getAuthorById($row->author_id), 'book_year' => $row->issue_year);
        }

        return $result;
    }

    /**
     * Добавление записи книги
     */
    public function addBook($data) {
        return $this->db->insert('books', $data);
    }

    /**
     * Удаление записи книги
     */
    public function deleteBook($id) {
        return $this->db->delete('books', array('id' => intval($id)));
    }

}
