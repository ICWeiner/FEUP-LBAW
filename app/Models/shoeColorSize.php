<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class shoeColorSize extends Model
{
    #use HasFactory;

    protected $primaryKey = [
        'id_shoe', 'id_primaryColor', 'id_secondaryColor', 'id_size',
    ];

    protected $table = 'shoeColorSize';

    public $timestamps = false;

    protected $casts = [
        'id_shoe' => 'integer',
        'id_primaryColor' => 'integer',
        'id_secondaryColor' => 'integer',
        'id_size' => 'integer',
    ];

    public function primaryColor() {
        return $this->hasOne('App\Models\color');
    }

    public function secondaryColor() {
        return $this->hasOne('App\Models\color');
    }

    public function size() {
        return $this->hasOne('App\Models\size');
    }
}
