<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class collection extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_collection';

    protected $table = 'collection';

    public $timestamps = false;

    protected $fillable = [
        'name', 'id_product',
    ];

    protected $casts = [
        'id_collection' => 'integer',
        'name' => 'string',
        'id_product' => 'integer',
    ];
}
