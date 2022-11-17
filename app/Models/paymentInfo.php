<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class paymentInfo extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_payment_info';

    protected $table = 'paymentInfo';

    public $timestamps = false;

    protected $fillable = [
        'address', 'name', 'card_number', 'id_user',
    ];

    protected $hidden = [
        'address', 'card_number', 'name',
    ];

    protected $casts = [
        'id_payment_info' => 'integer',
        'address' => 'string',
        'name' => 'string',
        'card_number' => 'string',
        'id_user' => 'integer',
    ];
}
