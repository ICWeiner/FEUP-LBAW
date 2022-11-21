<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class authorBook extends Model
{
    #use HasFactory;

    protected $primaryKey = [
        'id_author', 'id_book',
    ];

    protected $table = 'authorBook';

    public $timestamps = false;

    protected $casts = [
        'id_author' => 'integer',
        'id_book' => 'integer',
    ];
}
