<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Shoe extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_product';

    protected $table = 'shoe';

    public $timestamps = false;

    protected $fillable = [
        'name', 'type_name', 'brand_name',
    ];

    protected $casts = [
        'id_product' => 'integer',
        'name' => 'string',
        'type_name' => 'string',
        'brand_name' => 'string',
    ];

    public function owner() {
        return $this->belongsTo(Product::class, 'id_product');
    }

    public function options() {
        return $this->hasOne(shoeColorSize::class, 'id_shoe');
    }
}
