<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class funkoPop extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_funkoPop';

    protected $table = 'funkoPop';

    public $timestamps = false;

    protected $fillable = 'number_pop';

    protected $casts = [
        'id_funkoPop' => 'integer',
        'number_pop' => 'integer',
    ];

    public function owner() {
        return $this->belongsTo('App\Models\Product');
    }
}
