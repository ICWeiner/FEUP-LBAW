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
        'id_product' => 'integer',
        'total_price' => 'float',
        'tracking_number' => 'string',
        'buy-date' => 'datetime:d-m-Y',
        'shipping-date' => 'datetime:d-m-Y',
        'arrival_date' => 'datetime:d-m-Y',
        'id_user' => 'integer',
    ];
}
