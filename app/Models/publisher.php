<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class publisher extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_publisher';

    protected $table = 'publisher';

    public $timestamps = false;

    protected $fillable = [
        'name',
    ];

    protected $hidden = [
        'name',
    ];

    protected $casts = [
        'id_publisher' => 'integer',
        'name' => 'string',
    ];
}
