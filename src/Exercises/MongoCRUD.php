<?php
namespace Exercises;

use Utilities\Utilities;
use MongoDB\Client;

/**
 * The class MongoCRUD implements basic CRUD operations against MongoDB.
 *
 * User credentials are written to test.users
 *
 * @author  Martin Harrer <martin.harrer@fh-hagenberg.at>
 */
final class MongoCRUD
{
    /**
     * @var array messages is used to display error and status messages after a form was sent an validated
     */
    private array $messages = [];

    /**
     * @var object twig provides a Twig object to display hmtl templates
     */
    private object $twig;

    /**
     * @var array twigParams is used to set variables passed to Twig
     */
    private array $twigParams = [];

    /**
     * MongoCRUD constructor.
     *
     * Initializes Twig
     * Creates a database handler for the database connection.
     */
    public function __construct($twig)
    {
        $this->twig=$twig;
        // simply testing the connection
        $database = (new Client('mongodb://mongo:27017/'))->test;
        $cursor = $database->command(['ping' => 1]);
    }

    /**
     * Validates the user input
     *
     * email and password are required fields.
     * The combination of email + password is checked against database in @see Login::authenitcateUser()
     *
     * Error messages are stored in the array $messages[].
     * Calls MongoCRUD::business() if all input fields are valid.
     *
     * @return void Returns nothing
     */
    public function isValid(): void
    {
        if ((count($this->messages) === 0)) {
                $this->business();
            }
        $this->twigParams['email'] = $_POST['email'];
        $this->twigParams['messages'] = $this->messages;
        $this->twig->display("mongocrud.html.twig", $this->twigParams);
    }

    /**
     * Process the user input, sent with a POST request
     *
     * @return void Returns nothing
     */
    protected function business(): void
    {
        $collection = (new Client('mongodb://mongo:27017'))->test->users;

        $insertOneResult = $collection->insertOne([
            'username' => 'admin',
            'email' => 'admin@example.com',
            'name' => 'Admin User',
        ]);

        printf("Inserted %d document(s)\n", $insertOneResult->getInsertedCount());

        var_dump($insertOneResult->getInsertedId());
    }
}
