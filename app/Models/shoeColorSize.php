<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class shoeColorSize extends Model
{
    #use HasFactory;

    protected $primaryKey = [
        'id_shoe', 'id_primaryColor', 'id_secondaryColor', 'id_size',
    ];

    protected $table = 'shoecolorsize';

    public $timestamps = false;

    protected $casts = [
        'id_shoe' => 'integer',
        'id_primaryColor' => 'integer',
        'id_secondaryColor' => 'integer',
        'id_size' => 'integer',
    ];

    public function shoe() {
        return $this->belongsTo(shoe::class, 'id_shoe', 'id_shoe');
    }

    public function primaryColor() {
        return $this->hasOne(color::class, 'id_color');
    }

    public function secondaryColor() {
        return $this->hasOne(color::class, 'id_color');
    }

    public function size() {
        return $this->hasOne(size::class, 'id_size');
    }
}
