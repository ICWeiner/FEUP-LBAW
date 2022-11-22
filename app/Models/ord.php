<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ord extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_ord';

    protected $table = 'ord';

    public $timestamps = false;

    protected $fillable = [
        'total_price', 'tracking_number', 'buy_date', 'shipping_date', 'arrival_date', 'id_user',
    ];

    protected $hidden = [
        'buy_date', 'shipping_date', 'arrival_date'
    ];

    protected $casts = [
        'id_ord' => 'integer',
        'total_price' => 'float',
        'tracking_number' => 'string',
        'buy_date' => 'datetime:d-m-Y',
        'shipping_date' => 'datetime:d-m-Y',
        'arrival_date' => 'datetime:d-m-Y',
        'id_user' => 'integer',
    ];

    public function products() {
        return $this->belongsToMany(Product::class,'productord','id_ord','id_product')->withPivot('quantity');
    }

    public function owner() {
        return $this->belongsTo(User::class);
    }
}
