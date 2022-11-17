<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class banned extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_banned';

    protected $table = 'banned';

    public $timestamps = false;

    protected $fillable = [
        'reason', 'official_date', 'id_user',
    ];

    protected $hidden = [
        'reason', 'official_date',
    ];

    protected $casts = [
        'id_banned' => 'integer',
        'reason' => 'string',
        'official_date' => 'datetime:d-m-Y',
        'id_user' => 'integer'
    ];
}
