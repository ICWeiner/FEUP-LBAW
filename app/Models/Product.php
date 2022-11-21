<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_product';

    protected $table = 'product';

    public $timestamps = false;

    protected $fillable = [
        'name', 'price', 'stock_quantity', 'url', 'year', 'rating ', 'sku',
    ];

    protected $hidden = [
        'url',
    ];

    protected $casts = [
        'id_product' => 'integer',
        'name' => 'string',
        'price' => 'float',
        'stock_quantity' => 'integer',
        'url' => 'string',
        'year' => 'integer',
        'rating' => 'float',
        'sku' => 'integer',
    ];

    public function shoe() {
        return $this->hasOne('App\Models\shoe');
    }

    public function funkoPop() {
        return $this->hasOne('App\Models\funkoPop');
    }

    public function book() {
        return $this->hasOne('App\Models\book');
    }

    public function reviews() {
        return $this->hasMany('App\Models\review');
    }

    public function ownerCollection() {
        return $this->belongsTo('App\Models\collection');
    }

    public function ownerOrd() {
        return $this->belongsToMany('App\Models\ord');
    }

    /*public function type() TODO:unsure about this, one product can have one of multiple types, that isnt stored on the product table
        return $this->hasOne('App\Models\Type');
    }*/
}
