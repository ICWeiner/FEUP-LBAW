<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class funkoPop extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_product';

    protected $table = 'funkopop';

    public $timestamps = false;

    protected $fillable = ['id_product', 'number_pop'];

    protected $casts = [
        'id_product' => 'integer',
        'number_pop' => 'integer',
    ];

    public function owner()
    {
        return $this->belongsTo(Product::class, 'id_product');
    }
}
