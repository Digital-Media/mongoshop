<?php

declare(strict_types=1);

namespace Documents;

use Doctrine\ODM\MongoDB\Mapping\Annotations as ODM;

/**  @ODM\Document(collection="cart") */
class Cart
{
    /** @ODM\Id */
    private string $id;

    /** @ODM\Field(type="string") */
    private string $pid;  // a collection can't have a compound key for a primary key (identifier),
                          // therefore $pid must be a separate column (key).

    /** @ODM\Field(type="string") */
    private string $session_id;

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
    public function getPid(): ?string
    {
        return $this->pid;
    }

    public function setPid($pid): void
    {
        $this->pid = $pid;
    }
    public function setSessionId(string $session_id): void
    {
        $this->session_id = $session_id;
    }

    public function getSessionId(): string
    {
        return $this->session_id;
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