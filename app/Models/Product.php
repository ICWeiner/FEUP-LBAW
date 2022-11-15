<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_product';

    public $timestamps = false;

    protected $fillable = [
        'name', 'price', 'stock_quantity', 'url', 'year', 'rating ', 'sku',
    ];

    protected $hidden = [
        'url',
    ];

    /*public function type() TODO:unsure about this, one product can have one of multiple types, that isnt stored on the product table
        return $this->hasOne('App\Models\Type');
    }*/
}
