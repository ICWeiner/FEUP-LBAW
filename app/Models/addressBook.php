<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class addressBook extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_address_book';

    protected $table = 'addressbook';

    public $timestamps = false;

    protected $fillable = [
        'address', 'phone_number', 'name', 'id_user',
    ];

    protected $hidden = [
        'address', 'phone_number',
    ];

    protected $casts = [
        'id_address_book' => 'integer',
        'address' => 'string',
        'phone_number' => 'string',
        'name' => 'string',
        'id_user' => 'integer',
    ];

    public function owner() {
        return $this->belongsTo('App\Models\User');
    }
}
