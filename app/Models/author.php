<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class author extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_author';

    protected $table = 'author';

    public $timestamps = false;

    protected $fillable = [
        'name', 'url',
    ];

    protected $hidden = [
        'url',
    ];

    protected $casts = [
        'id_author' => 'integer',
        'name' => 'string',
        'url' => 'string',
    ];

    public function books() {
        return $this->belongsToMany(book::class,'authorbook','id_author','id_book');  
    }
}
