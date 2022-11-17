<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class book extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_book';

    protected $table = 'book';

    public $timestamps = false;

    protected $fillable = [
        'edition', 'isbn', 'id_publisher',
    ];

    protected $hidden = [
        'isbn',
    ];

    protected $casts = [
        'id_book' => 'integer',
        'edition' => 'integer',
        'isbn' => 'string',
        'id_publisher' => 'integer',
    ];

    public function owner() {
        return $this->belongsTo('App\Models\Product');
    }

    public function authors() {
        return $this->belongsToMany('App\Models\Person');
    }

    public function publisher() {
        return $this->belongsTo('App\Models\Publisher');
    }
}
