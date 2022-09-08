<?php
namespace Exercises;

use Documents\OrderItem;
use MongoDB\BSON\ObjectId;
use Utilities\Utilities;
use Doctrine\ODM\MongoDB\Configuration;
use Doctrine\ODM\MongoDB\DocumentManager;
use Doctrine\ODM\MongoDB\Mapping\Driver\AnnotationDriver;
use MongoDB\Client;
use Documents\Cart;
use Documents\Order;

/*
 * The class MyCart stores product data in onlineshop.product.
 *
 * @author Martin Harrer <martin.harrer@fh-hagenberg.at>
 */
final class MyCart
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
     * @var object dm provides a ODM object to handle database queries
     */
    private object $dm;

    /**
     * @var string session_id holds the value of the current PHP sessionID.
     */
    private string $session_id;

    /**
     * MyCart constructor.
     *
     * Initializes Twig
     * Creates a database handler for the database connection.
     */
    public function __construct($twig)
    {
        $this->twig=$twig;
        $this->initDB();
        // $this->session_id = session_id();
        $this->session_id = '540d8e6d6803fa290c4257eb'; // faking session because placing an order is not finished
        // can be replaced bei session_id() in a complete shop with login and product list
    }

    private function initDB()
    {

        $client = new Client('mongodb://mongo:27017', [], ['typeMap' => DocumentManager::CLIENT_TYPEMAP]);
        /* simple test for database connection to database "test"
        $database = $client->test;
        $cursor = $database->command(['ping' => 1]);
        var_dump($cursor->toArray()[0]);
        ## */
        $config = new Configuration();
        $config->setProxyDir('../proxies');
        $config->setProxyNamespace('Proxies');
        $config->setHydratorDir('../hydrators');
        $config->setHydratorNamespace('Hydrators');
        $config->setMetadataDriverImpl(AnnotationDriver::create('../src/Documents'));
        $config->setDefaultDB('test');

        $this->dm = DocumentManager::create($client, $config); // specific client config -> docker network
        // $this->dm = DocumentManager::create(null, $config); // default client config -> localhost/127.0.0.1
        spl_autoload_register($config->getProxyManagerConfiguration()->getProxyAutoloader());
    }

    /**
     * Returns all entries of the collection  test.cart in an array.
     * If errors occoured during isValid(), the entries in test.cart are overwritten with values from $_POST
     */
    public function displayForm($route = "/mycart"): void
    {
        $this->twigParams['route'] = $route;
        $cart = $this->fillCartArray();
        if ((count($this->messages) !== 0)) {
             foreach ($cart as $index => $cartrow) {
                foreach ($_POST['quantity'] as $pid => $quantity) {
                    // Es wird nur == genutzt statt === weil die idproduct von der Datenbank als String geliefert wird, der Index aber Integer ist
                    if ($cartrow['pid'] == $pid ) {
                        $cart[$index]['quantity'] = Utilities::sanitizeFilter($quantity);
                    }
                }
            }
        }
        $this->twigParams['order_items'] = $cart;
        $this->twig->display("mycart.html.twig", $this->twigParams);
    }

    /**
     * Returns all items of the collection test.cart in an array.
     *
     * @return mixed Array that returns rows of test.cart.
     */
    private function fillCartArray(): array
    {
        $order_items = [];
        //TODO use $this->dm->createQueryBuilder to read entries from test.cart
        // session_id should match $this->session_id to fake PHP sessions
        // use select to read only pid, product_name, price and quantity
        // sort the result bei _id ascending
        // use hydrate(false) to return an array, because twig doesn't support objects in this case
        //TODO step through the result and build $order_items[]
        // use var_dump($result) to see how to assign values from $result to $order_items.
        // comment the following line, when this is done to show the entries from test.cart
        $order_items[]= ['pid' => 1, 'product_name' => 'My favorite Book', 'price' => 10, 'quantity' => 1];
        return $order_items;
    }

    public function business ()
    {
        if ($this->isValid()) {
            if (isset($_POST['update'])) {
                foreach ($_POST['quantity'] as $pid => $quantity) {
                    if ($quantity == 0) {
                        $this->deleteProductFromCart($pid);
                    } else {
                        $this->updateCart($pid, $quantity);
                    }
                }
            } elseif (isset($_POST['checkout'])) {
                $this->insertOrder();
                $this->deleteFromCart();
            }
        } else {
            $this->twigParams['quantity'] = $_POST['quantity'];
            $this->twigParams['messages']= $this->messages;
        }
        $this->displayForm();
    }

    /**
     * Validates the user input
     *
     * All fields are required.
     *
     * @return bool Returns nothing
     *
     * Error messages are stored in the array $messages[].
     *
     * Price can be validated with Utilities::isPrice().
     */
    private function isValid(): bool
    {
        if (isset($_POST['quantity'])) {
            foreach ($_POST['quantity'] as $pid => $value) {
                if (!$this->isValidPid($pid)) {
                    $this->messages['pid'] = "Please enter a valid Product ID.";
                }
                //TODO Test if quantity is an integer
                    $this->messages['quantity' . $pid] = "Please enter a valid quantity for PID $pid.";
            }
        }
        if ((count($this->messages) === 0)) {
            return true;
        }
        return false;
    }

    private function isValidPid(string $pid): bool
    {
        //TODO Use $this->dm->createQueryBuilder to count entries of pid in test.cart
        // use hydrate(false) to get an array instead of an object.
        $count = 0;
        if ($count > 0) {
            return true;
        }
        return false;
    }

    /**
     * Removes the cart data in the collection test.cart.
     *
     * @return void Returns nothing
     */
    private function deleteProductFromCart(string $pid): void
    {
        $this->dm->createQueryBuilder(Cart::class)
            ->remove()
            ->field('_id')->equals($pid)
            ->field('session_id')->equals($this->session_id)
            ->getQuery()->execute();
        $this->twigParams['messages'][$pid] = "Product $pid has been removed from Cart";
    }

    /**
     * Updates quantity in the collection test.cart.
     *
     * @return void Returns nothing
     */
    private function updateCart(string $pid, int $quantity): void
    {
        $this->dm->createQueryBuilder(Cart::class)
            // Find the cart_item
            ->findAndUpdate()
            ->field('pid')->equals($pid)
            ->field('session_id')->equals($this->session_id)
            ->field('quantity')->notEqual($quantity)

            // Update found cart_item
            ->field('quantity')->set($quantity)
            ->getQuery()->execute();
        $this->twigParams['messages']['status'] = "Quantities have been updated";
    }

    /**
     * Stores the product data in the table onlineshop.product.
     *
     * @return void Returns nothing
     */
    private function insertOrder(): void
    {
        //TODO See /src/Documents/Order.php and OrderItem.php to see getter and setter
        //TODO Initialize new Order object
        $cart = $this->fillCartArray();
        $total_sum = $this->totalSum($cart);
        //TODO add total_sum and date_ordered
        foreach ($cart as $key => $value) {
            foreach ($_POST['quantity'] as $pid => $quantity) {
                if ($pid == $value['pid']) {
                    //TODO Initialize new OrderItem object
                    // add pid, and quantity from $_POST
                    // get matching product_name and price from $cart
                    // add the new OrderItem object to Order
                }
            }
        }
        //TODO persist $order object and flush it
        $this->twigParams['messages']['status'] = "Your Order with OrderId " . 1 . " was successful.";
    }

    /**
     * Building total sum of price * quantiy for all items belonging to one session_id
     *
     * @return float total_sum
     */
    private function totalSum(array $cart): float
    {
        $total_sum=0;
        //TODO Build total_sum from cart array
        return $total_sum;
    }

    /**
     * @return void
     */
    private function deleteFromCart():void
    {
        //TODO use $this->dm->createQueryBuilder to delete cart for $this->session
    }
}
