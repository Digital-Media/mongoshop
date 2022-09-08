<?php

declare(strict_types=1);

namespace Documents;

use Doctrine\ODM\MongoDB\Mapping\Annotations as ODM;

/**  @ODM\EmbeddedDocument */
class OrderItem
{
   /** @ODM\Id */
    private string $id;

    /** @ODM\Field(type="string") */
    private string $pid;

    /** @ODM\Field(type="string") */
    private string $product_name;

    /** @ODM\Field(type="float") */
    private float $price;

    /** @ODM\Field(type="int") */
    private int $quantity;


    public function getId(): ?string
    {
        return $this->id;
    }

    public function setPid(string $pid): void
    {
        $this->pid = $pid;
    }

    public function getPid(): string
    {
        return $this->pid;
    }

    public function setProductName(string $product_name): void
    {
        $this->product_name = $product_name;
    }

    public function getProductName(): string
    {
        return $this->product_name;
    }

    public function setPrice(float $price): void
    {
        $this->price = $price;
    }

    public function getPrice(): float
    {
        return $this->price;
    }

    public function setQuantity(int $quantity): void
    {
        $this->quantity = $quantity;
    }

    public function getQuantity(): int
    {
        return $this->quantity;
    }
}