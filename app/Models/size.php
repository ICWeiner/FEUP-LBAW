<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class size extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_size';

    protected $table = 'size';

    public $timestamps = false;

    protected $fillable = [
        'size_eu', 'size_us',
    ];

    protected $hidden = [
        'size_eu', 'size_us',
    ];

    protected $casts = [
        'id_size' => 'integer',
        'size_eu' => 'integer',
        'size_us' => 'integer',
    ];

    public function owner() {
        return $this->belongsTo('App\Models\shoeColorSize');
    }
}
