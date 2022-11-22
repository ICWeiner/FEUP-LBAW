<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class book extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_product';

    protected $table = 'book';

    public $timestamps = false;

    protected $fillable = [
        'id_product', 'edition', 'isbn', 'id_publisher',
    ];

    protected $hidden = [
        'isbn',
    ];

    protected $casts = [
        'id_product' => 'integer',
        'edition' => 'integer',
        'isbn' => 'string',
        'id_publisher' => 'integer',
    ];

    public function owner()
    {
        return $this->belongsTo(Product::class, 'id_product');
    }

    public function authors()
    {
        return $this->belongsToMany(author::class, 'authorbook', 'id_book', 'id_author');
    }

    public function publisher()
    {
        return $this->belongsTo(publisher::class, 'id_publisher');
    }
}
