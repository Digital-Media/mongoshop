<?php
namespace Exercises;

use Utilities\Utilities;
use MongoDB\Client;
use MongoDB\BSON\ObjectId;

/*
 * The class Country implements a form for managing Countries at MongoShop.
 *
 * If country data are valid, they are stored in the collection test.country.
 * A List of countries ist displayed below the input form.
 *
 * @author Martin Harrer <martin.harrer@fh-hagenberg.at>
 */
final class Countries
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
     * @var object connection provides a object for a connection to mongodb.
     */
    private object $connection;

    /**
     * @var object db_test provides a object to access the database test.
     */
    private object $db_test;

    //TODO add variable for countries object.

    /**
     * Countries Constructor.
     *
     * Initializes Twig
     * Creates a database handler for the database connection.
     */
    public function __construct($twig)
    {
        $this->twig=$twig;
        //$database = (new Client('mongodb://mongo:27017/'))->test;
        //$cursor = $database->command(['ping' => 1]);
        //var_dump($cursor->toArray()[0]);
        //TODO add connection, database and countries handler/object
    }

    /**
     * Set route and fill the Country list below form
     * Display Country page
     *
     * @param string $route
     * @return void
     */
    public function displayForm(string $route = "/createcountry"): void
    {
        $this->twigParams['route'] = $route;
        $this->twigParams['countries'] = $this->fillCountryArray();
        $this->twig->display("countries.html.twig", $this->twigParams);
    }

    /**
     * Returns all entries of the collection test.countries in an array.
     *
     * @return mixed Array with rows of collection test.countries. false in case of error
     */
    private function fillCountryArray(): array
    {
        $result[]= ['cid' => 1, 'country' => 'Homeland', 'isocode' => 'HL'];
        return $result;
        //TODO use MongoDB Client and $this->countries to read all test.countries
        // use iterator_to_array to return the result, because TWIG supports only arrays
    }

    /**
     * Validate and process country data, sent with a POST request.
     *
     * @return void Returns nothing
     */
    public function insertCountry(): void
    {
        //TODO validate and insert the given country data.
        $insertOneResult = 1;
        $this->twigParams['messages']['status'] = "Country with _id " . $insertOneResult . " inserted";
        $this->displayForm();
    }

    /**
     * Validate and process country data, sent with a POST request
     * First step is to call form with a GET request and provide data for given uid
     * Second step is to send POST with changed data
     * These steps are closely related and therefore handled within one method
     *
     * @return void Returns nothing
     */
    public function updateCountry(): void
    {
        //TODO display form with given cid
        // update country sent with GET request
        isset($_GET['cid']) ? print_r("GET['cid']: " . $_GET['cid']) : null;
        isset($_POST['cid']) ? print_r("POST['cid']: " . $_POST['cid']) : null;
        $this->displayForm("/updatecountry");
    }

    /**
     * Returns keys needed for update form of the collection test.countries in an array.
     *
     * @return mixed Array that returns rows of test.countries. false in case of error
     */
    private function getCountryFields(): array
    {
        $result = [];
        //TODO return selected country data to form input fields
        return $result;
    }

    /**
     * Deletes a country identified by his cid from the collection test.countries.
     *
     * @return void Return nothing
     */
    public function deleteCountry(): void
    {
        //TODO use $this->countries to delete the selected country.
        $deleteResult = 0;
        $this->twigParams['messages']['status'] = $deleteResult . " country deleted";
        $this->displayForm();
    }

    /**
     * Validates the user input
     *
     * name of country and isocode are validated with a regex. You can use Utilities::isString() to do so.
     *
     * Error messages are stored in the array $messages[].
     *
     * @return bool Returns true if user input is valid, otherwise false.
     */
    private function isValid(): bool
    {
        if (Utilities::isEmptyString($_POST['country'])) {
            $this->messages['email'] = "Please enter a country.";
        }
        if (Utilities::isEmptyString($_POST['isocode'])) {
            $this->messages['name'] = "Please enter the related isocode.";
        }
        if ((count($this->messages) === 0)) {
            return true;
        } else {
            $this->twigParams['messages'] = $this->messages;
            return false;
        }
    }
}
