<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class productOrd extends Model
{
    #use HasFactory;

    protected $primaryKey = [
        'id_product', "id_ord",
    ];

    protected $table = 'productOrd';

    public $timestamps = false;

    protected $fillable = 'quantity';

    protected $casts = [
        'id_product' => 'integer',
        'id_ord' => 'integer',
        'quantity' => 'integer',
    ];
}
