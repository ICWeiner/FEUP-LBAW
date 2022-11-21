<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class authorBook extends Model
{
    #use HasFactory;

    protected $primaryKey = [
        'id_author', 'id_book',
    ];

    protected $table = 'authorbook';

    public $timestamps = false;

    protected $casts = [
        'id_author' => 'integer',
        'id_book' => 'integer',
    ];

    public function owner() {
        return $this->belongsTo(book::class, 'id_product');
    }
}
