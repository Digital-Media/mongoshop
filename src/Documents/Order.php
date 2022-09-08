<?php

declare(strict_types=1);

namespace Documents;

use Doctrine\ODM\MongoDB\Mapping\Annotations as ODM;
use Doctrine\Common\Collections\ArrayCollection;
use \MongoDB\BSON\UTCDateTime;
use Documents\OrderItem;

/**  @ODM\Document(collection="order") */
class Order
{
   /** @ODM\Id */
    private string $id;

    /** @ODM\Field(type="date") */
    private string $date_ordered;

    /** @ODM\Field(type="float") */
    private float $total_sum;

    /** @ODM\EmbedMany(targetDocument=OrderItem::class) */
    private $order_items = [];

    public function __construct()
    {
        $this->order_items= new ArrayCollection();
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function setDateOrdered(): void
    {
        $this->date_ordered = (new UTCDateTime())->__toString();
    }

    public function getDateOrdered(): string
    {
        return $this->date_ordered;
    }

    public function setTotalSum(float $total_sum): void
    {
        $this->total_sum = $total_sum;
    }

    public function getTotalSum(): float
    {
        return $this->total_sum;
    }

    /**
     * @return array
     */
    public function getOrderItems(): array
    {
        return $this->order_items->toArray();
    }

    public function setOrderItems(OrderItem $order_items) {
        $this->order_items->add($order_items);
    }
}