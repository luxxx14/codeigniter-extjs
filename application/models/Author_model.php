<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Class Book_model
 * Модель для работы с авторами книг
 */
class Author_model extends CI_Model {

    /**
     * Загрузка списка авторов
     */
    public function loadAuthorsList()
    {
        $query = $this->db->get('authors');
        foreach ($query->result() as $row)
        {
            $result[] = array('id' => $row->id, 'first_name' => $row->first_name, 'last_name' => $row->last_name, 'full_name' => $row->first_name . ' ' . $row->last_name);
        }

        return $result;
    }
}
