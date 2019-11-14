<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Class Book
 * Контроллер для работы с книгами
 */
class Book extends CI_Controller {

	/**
	 * Загрузка списка книг
	 */
	public function loadList()
	{
		$this->load->model('Book_model');
		$bookList = $this->Book_model->loadList();

		echo json_encode($bookList);
	}

    /**
     * Загрузка списка авторов книг (для селекта в форме)
     */
    public function loadAuthorList()
    {
        $this->load->model('Author_model');
        $bookList = $this->Author_model->loadAuthorsList();

        echo json_encode($bookList);
    }

    /**
     * Добавление книги
     */
    public function addBook() {
        $this->load->model('Book_model');

        $data['name'] = $this->input->post('book_name');
        $data['author_id'] = intval($this->input->post('author_id'));
        $data['issue_year'] = $this->input->post('issue_year');
        //var_dump($data);

        /* фильтрация и валидация данных */
        $currentYear = intval(date('Y', time()));
        if (intval($data['issue_year']) > $currentYear) {
            echo json_encode(array('msg' => "Год не может быть больше текущего"));
            exit;
        }
        $data['name'] = strip_tags($data['name']);
        //$data['name'] = htmlspecialchars($data['name'], null, null, false);

        /* добавление записи в БД */
        $resultAddBook = $this->Book_model->addBook($data);
        if ($resultAddBook == true) {
            echo json_encode(array('success' => true, 'msg' => "Книга добавлена"));
        } else {
            echo json_encode(array('msg' => "Что то пошло не так )"));
        }
        exit;
    }

    /**
     * Удаление книги
     */
    public function deleteBook() {
        $this->load->model('Book_model');
        $book_id = intval($this->input->post('id'));
        $resultDeleteBook = $this->Book_model->deleteBook($book_id);
        if ($resultDeleteBook == true) {
            echo json_encode(array('success' => true, 'msg' => "Книга удалена"));
        } else {
            echo json_encode(array('msg' => "Что то пошло не так )"));
        }
        exit;
    }

    /**
     * Экспорт в XML
     */
    public function getXMLData() {
        header('Content-type: text/xml');

        $this->load->model('Book_model');
        $XMLData = $this->Book_model->loadList();

        //var_dump($XMLData);
        //exit;

        $this->load->helper('xml');

        $dom = xml_dom();
        $books = xml_add_child($dom, 'books');

        foreach($XMLData as $data) {
            $book = xml_add_child($books, 'book');

            xml_add_child($book, 'id', $data['book_id']);
            xml_add_child($book, 'name', $data['book_name']);
            xml_add_child($book, 'author', $data['author_name']);
            //xml_add_attribute($author, 'birthdate', '1948-04-04');
        }

        xml_print($dom);
    }
}
